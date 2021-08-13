<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <script src="https://kit.fontawesome.com/75cf4e84e0.js" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <asset:stylesheet src="user/publicProfile.css"></asset:stylesheet>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <asset:javascript src="searchTopic.js"></asset:javascript>
    <script>
        var dataUrl = "${createLink(controller: 'topic', action: 'searchTopics')}"
    </script>
    <title>${user.name}--Profile</title>
</head>
<body>
<!-- navbar -->
<div id="navbar">
    <g:link controller="home" action="home" class="homeLink">Link Sharing</g:link>

    <div class="navigator">
        <ul>
            <li>
                <input type="text" id="search_text" name="search" placeholder="Search...">
                <button id="search_btn"><i class="fas fa-search"></i></button>
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
                        <g:if test="${session.user.admin}">
                            <g:link controller="user" action="getProfile" id="${session.user.id}">Profile</g:link>
                            <g:link controller="user" action="allUsers">Users</g:link>
                            <g:link controller="user" action="logout">Logout</g:link>
                        </g:if>
                        <g:else>
                            <g:link controller="user" action="getProfile" id="${session.user.id}">Profile</g:link>
                            <g:link controller="user" action="logout">Logout</g:link>
                        </g:else>
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

<h3 class="success">${flash.inviteSuccess}</h3>

<h3 class="error">${flash.topicError}</h3>

<h3 class="error">${flash.linkResError}</h3>

<h3 class="error">${flash.docResError}</h3>

<h3 class="error">${flash.inviteError}</h3>

<h3 id="searchErr" class="error"></h3>

<div class="search_results"></div>

<!-- main area -->
<div id="main_area">
    <div class="user_info">
        <div class="user_card">
            <asset:image src="${user.photo}" style="height: 6rem; width: 6rem;"></asset:image>

            <div style="margin-left: 1%;">
                <p style="margin: 0;">${user.name}</p>
                <p style="margin: 0;">@${user.userName}</p>
                <p style="margin: 0;">Subscriptions&nbsp;&nbsp;&nbsp;&nbsp;Topics</p>
                <p style="margin: 0;">${user.subscriptions.size()}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${user.topics.size()}</p>
            </div>
        </div>

        <div class="topics">
            <div class="head_box">
                <h3 style="margin: 0 2%; display: inline-block;">Topics</h3>
            </div>

            <div class="topics_list">
                <g:each in="${topics}" var="i">
                    <div class="topic_card">
                        <div>
                            <p><g:link controller="topic" action="viewTopic" id="${i.id}">${i.name}</g:link></p>
                            <g:if test="${!linksharing.Subscription.findByTopicAndSubscriber(i,session.user)}">
                                <p><g:link controller="topic" action="subscribeTopic" id="${i.id}">Subscribe</g:link></p>
                            </g:if>
                            <g:else>
                                <p><g:link controller="topic" action="unsubscribeTopic" id="${i.id}">Unsubscribe</g:link></p>
                            </g:else>

                        </div>

                        <div class="inner_info">
                            <div>
                                <p>Subscriptions</p>
                                <p>${i.subscriptions.size()}</p>
                            </div>
                            <div>
                                <p>Posts</p>
                                <p>${i.resources.size()}</p>
                            </div>
                        </div>
                    </div>
                </g:each>
            </div>
        </div>

        <div class="subscriptions">
            <div class="head_box">
                <h3 style="margin: 0 2%; display: inline-block;">Subscriptions</h3>
            </div>

            <div class="subscriptions_list">
                <g:each in="${subscriptions}" var="i">
                    <g:if test="${linksharing.Subscription.findByIdAndSubscriber(i.id,user)}">
                        <div class="topic_card">
                            <div>
                                <p><g:link controller="topic" action="viewTopic" id="${i.topic.id}">${i.topic.name}</g:link></p>
                                <g:if test="${linksharing.Subscription.findByTopicAndSubscriber(i.topic,session.user)}">
                                    <p><g:link controller="topic" action="unsubscribeTopic" id="${i.topic.id}">Unsubscribe</g:link></p>
                                </g:if>
                                <g:else>
                                    <p><g:link controller="topic" action="subscribeTopic" id="${i.topic.id}">Subscribe</g:link></p>
                                </g:else>
                            </div>

                            <div class="inner_info">
                                <div>
                                    <p>Subscriptions</p>
                                    <p>${i.topic.subscriptions.size()}</p>
                                </div>
                                <div>
                                    <p>Posts</p>
                                    <p>${i.topic.resources.size()}</p>
                                </div>
                            </div>
                        </div>
                    </g:if>
                </g:each>
            </div>
        </div>
    </div>

    <div class="posts">
        <div class="post_list">
            <div class="head_box">
                <h3 style="margin: 0 2%; display: inline-block;">Posts</h3>
            </div>

            <div class="related_posts">
                <g:each in="${resources}" var="i">
                    <div class="post_card">
                        <p style="margin: 0;"><g:link controller="topic" action="viewTopic" id="${i.topic.id}">${i.topic.name}</g:link></p>
                        <div class="post_card_details">
                            <g:if test="${i.description.length() > 120}">
                                <p>${i.description.substring(0, 120)}...</p>
                            </g:if>
                            <g:else><p>${i.description}</p></g:else>

                            <div class="post_card_navigator">
                                <p style="float: left; margin: 0">
                                    <a href=""><i class="fab fa-facebook-f"></i></a> &nbsp; <a href=""><i class="fab fa-twitter"></i></a> &nbsp; <a href=""><i class="fab fa-google-plus-g"></i></a>
                                </p>
                            <g:if test="${i.class == linksharing.DocumentResource}">
                                <p style="float: right; margin: 0;"><g:link controller="resource" action="download" id="${i.id}">Download</g:link>&nbsp;&nbsp;<g:link controller="resource" action="viewResource" id="${i.id}">View Post</g:link></p>
                            </g:if>
                            <g:else>
                                <p style="float: right; margin: 0;"><a
                                        href="${i.url}" target="_blank">View Full Site</a>&nbsp;&nbsp;<g:link controller="resource" action="viewResource" id="${i.id}">View Post</g:link></p>
                            </g:else>
                            </div>
                        </div>
                    </div>
                </g:each>
            </div>
        </div>
    </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</body>
</html>