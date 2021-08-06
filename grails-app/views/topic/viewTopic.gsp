<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <script src="https://kit.fontawesome.com/75cf4e84e0.js" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <asset:stylesheet src="topic/viewTopic.css"></asset:stylesheet>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <asset:javascript src="searchTopic.js"></asset:javascript>
    <script>
        var dataUrl = "${createLink(controller: 'topic', action: 'searchTopics')}"
    </script>
    <title>${topic.name}</title>
</head>

<body>
<!-- navbar -->
<div id="navbar">
    <g:link controller="home" action="home" class="homeLink">Link Sharing</g:link>

    <div class="navigator">
        <ul>
            <li>
                <input type="text" id="search_text" name="search" placeholder="Search...">
                <button id="search_btn">Search</button>
            </li>
            <li><button data-bs-toggle="modal" data-bs-target="#topicModal"><i class="fas fa-comment"></i></button>
            </li>
            <li><button data-bs-toggle="modal" data-bs-target="#inviteModal"><i class="far fa-envelope"></i>
            </button>
            </li>
            <li><button data-bs-toggle="modal" data-bs-target="#linkModal"><i class="fas fa-link"></i></button></li>
            <li><button data-bs-toggle="modal" data-bs-target="#docModal"><i class="fas fa-file"></i></button></li>
            <li>
                <div class="settings">
                    <button class="settings_btn" style="font-size: 1.5rem;">${session.user.userName}</button>

                    <div class="settings_opt">
                        <g:link controller="user" action="getProfile" id="${session.user.id}">Profile</g:link>
                        <a href="">Topics</a>
                        <a href="">Posts</a>
                        <g:link controller="user" action="logout">Logout</g:link>
                    </div>
                </div>
            </li>
        </ul>
    </div>
</div>

<!-- modals -->
<g:render template="/templates/modals"/>

<h3 class="success">${flash.topicSuccess}</h3>

<h3 class="success">${flash.linkResSuccess}</h3>

<h3 class="success">${flash.docResSuccess}</h3>

<h3 class="error">${flash.topicError}</h3>

<h3 class="error">${flash.linkResError}</h3>

<h3 class="error">${flash.docResError}</h3>

<div class="search_results"></div>

<!-- main area -->
<div id="main_area">
    <div class="details">
        <div class="topic_card">
            <div class="head_box">
                <h3 style="margin: 0 2%; display: inline-block;">Topic: "${topic.name}"</h3>
            </div>

            <div class="topic_details">
                <asset:image src="${topic.createdBy.photo}" style="height: 5rem; width: 5rem;"></asset:image>
                <div class="topic_info">
                    <p style="margin: 0;"><g:link controller="topic" action="viewTopic"
                                                  id="${topic.id}">${topic.name}</g:link>&nbsp;&nbsp;(${topic.visibility})</p>

                    <div style="display: flex; flex-direction: row; justify-content: space-between;">
                        <div>
                            <p style="margin-bottom: 0;">@${topic.createdBy.userName}</p>
                            <g:if test="${linksharing.Subscription.findByTopicAndSubscriber(topic,session.user)}">
                                <g:link controller="topic" action="unsubscribeTopic" id="${topic.id}">Unsubscribe</g:link>
                            </g:if>
                            <g:else>
                                <g:link controller="topic" action="subscribeTopic" id="${topic.id}">Subscribe</g:link>
                            </g:else>

                        </div>

                        <div>
                            <p style="margin-bottom: 0;">Subscriptions</p>

                            <p>${subscriptions.size()}</p>
                        </div>

                        <div>
                            <p style="margin-bottom: 0;">Posts</p>

                            <p>${resources.size()}</p>
                        </div>
                    </div>
                </div>
            </div>

            <div style="float: right;">
                <select>
                    <option>Serious</option>
                    <option>Very Serious</option>
                    <option>Casual</option>
                </select>

                <button style="background: transparent; border: none;"><i class="far fa-envelope"></i></button>
            </div>
        </div>

        <div class="users_card" style="height: auto;">
            <div class="head_box">
                <h3 style="margin: 0 2%; display: inline-block;">Users: "${topic.name}"</h3>
            </div>

            <div class="users_list" style="min-height: 8rem; max-height: 14rem">
                <g:each in="${subscriptions}" var="s">
                    <div class="user_card_details">
                        <asset:image src="${s.subscriber.photo}" style="height: 5rem; width: 5rem;"></asset:image>

                        <div class="user_info">
                            <p style="margin: -1% 0 0 0;">${s.subscriber.name}</p>

                            <p style="margin: 0;">@${s.subscriber.userName}</p>

                            <p style="margin: 0;">Subscriptions&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Topics</p>

                            <p>${s.subscriber.subscriptions.size()}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${s.subscriber.topics.size()}</p>
                        </div>
                    </div>
                </g:each>
            </div>
        </div>
    </div>

    <div class="posts">
        <div class="post_list">
            <div class="head_box">
                <h3 style="margin: 0 2%; display: inline-block;">Posts: "${topic.name}"</h3>

                <div style="float: right; margin-right: 1%; margin-top: 1%;">
                    <input type="text" placeholder="Search Post...">
                    <button class="post_search_btn"><i class="fas fa-search"></i></button>
                </div>
            </div>

            <div class="related_posts">
                <g:each in="${resources}" var="i">
                    <div class="post_card">
                        <asset:image src="${i.createdBy.photo}" style="height: 5rem; width: 5rem;"></asset:image>
                        <div class="post_card_details">
                            <g:if test="${i.description.length() > 120}">
                                <p>${i.description.substring(0, 120)}...</p>
                            </g:if>
                            <g:else><p>${i.description}</p></g:else>

                            <div class="post_card_navigator">
                                <p style="float: left; margin: 0">
                                    <a href=""><i class="fab fa-facebook-f"></i></a> &nbsp; <a href=""><i
                                        class="fab fa-twitter"></i></a> &nbsp; <a href=""><i
                                        class="fab fa-google-plus-g"></i></a>
                                </p>
                                <g:if test="${i.class == linksharing.DocumentResource}">
                                    <p style="float: right; margin: 0;"><g:link controller="resource" action="download"
                                                                                id="${i.id}">Download</g:link>&nbsp;&nbsp;<a
                                            href="">Mark as Read</a>&nbsp;&nbsp;<g:link controller="resource"
                                                                                        action="viewResource"
                                                                                        id="${i.id}">View Post</g:link>
                                    </p>
                                </g:if>
                                <g:else>
                                    <p style="float: right; margin: 0;"><a
                                            href="${i.url}" target="_blank">View Full Site</a>&nbsp;&nbsp;<a
                                            href="">Mark as Read</a>&nbsp;&nbsp;<g:link controller="resource"
                                                                                        action="viewResource"
                                                                                        id="${i.id}">View Post</g:link>
                                    </p>
                                </g:else>

                            </div>
                        </div>
                    </div>

                </g:each>
            </div>
        </div>
    </div>
</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>

</body>
</html>