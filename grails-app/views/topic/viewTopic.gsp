<%@ page import="linksharing.Subscription" %>
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
    <asset:javascript src="modifier.js"></asset:javascript>
    <script>
        var dataUrl = "${createLink(controller: 'topic', action: 'searchTopics')}"
        var visUrl = "${createLink(controller: 'topic', action: 'changeVisibility')}"
        var serUrl = "${createLink(controller: 'topic', action: 'changeSeriousness')}"

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

<g:if test="${flash.success}">
    <h3 class="success">${flash.success}</h3>
</g:if>
<g:else test="${flash.error}">
    <h3 class="error">${flash.error}</h3>
</g:else>

<h3 id="searchErr" class="error"></h3>

<div class="search_results"></div>

<!-- main area -->
<div id="main_area">
    <div class="details">
        <div class="topic_card">
            <div class="head_box">
                <h3 style="margin: 0 2%; display: inline-block;">Topic: "${topic.name}"</h3>
            </div>

            <div id="topic_details">
                <div class="topic_details">
                    <asset:image src="${topic.createdBy.photo}" style="height: 5rem; width: 5rem;"></asset:image>
                    <div class="topic_info">
                        <p style="margin: 0;"><g:link controller="topic" action="viewTopic" id="${topic.id}">${topic.name}</g:link>&nbsp;&nbsp;(${topic.visibility})</p>

                        <div style="display: flex; flex-direction: row; justify-content: space-between;">
                            <div>
                                <p style="margin-bottom: 0;"><g:link controller="user" action="getProfile" id="${topic.createdBy.id}" style="text-decoration: none; color: darkred;">@${topic.createdBy.userName}</g:link></p>
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
                    <g:if test="${linksharing.Subscription.findByTopicAndSubscriber(topic,session.user)}">
                        <select onchange="changeSeriousness(${linksharing.Subscription.findByTopicAndSubscriber(topic,session.user).id},this.value)">
                            <g:if test="${linksharing.Subscription.findByTopicAndSubscriber(topic,session.user).seriousness == linksharing.enums.Seriousness.Very_Serious}">
                                <option value="Very_Serious">Very Serious</option>
                                <option value="Serious">Serious</option>
                                <option value="Casual">Casual</option>
                            </g:if>
                            <g:elseif test="${linksharing.Subscription.findByTopicAndSubscriber(topic,session.user).seriousness == linksharing.enums.Seriousness.Serious}">
                                <option value="Serious">Serious</option>
                                <option value="Casual">Casual</option>
                                <option value="Very_Serious">Very Serious</option>
                            </g:elseif>
                            <g:else>
                                <option value="Casual">Casual</option>
                                <option value="Very_Serious">Very Serious</option>
                                <option value="Serious">Serious</option>
                            </g:else>
                        </select>
                    </g:if>

                    <g:if test="${topic.createdBy.id == session.user.id || session.user.admin}">
                        <select onchange="changeVisibility(${topic.id},this.value)">
                            <g:if test="${topic.visibility == linksharing.enums.Visibility.Private}">
                                <option>Private</option>
                                <option>Public</option>
                            </g:if>
                            <g:else>
                                <option>Public</option>
                                <option>Private</option>
                            </g:else>
                        </select>

                        <button data-bs-toggle="modal" data-bs-target="#inviteModal" style="background: transparent; border: none;"><i class="far fa-envelope"></i></button>
                        <button style="background: transparent; border: none;"><g:link controller="topic" action="deleteTopic" id="${topic.id}" style="color: black;"><i class="fas fa-trash"></i></g:link></button>
                    </g:if>
                    <g:else>
                        <button data-bs-toggle="modal" data-bs-target="#inviteModal" style="background: transparent; border: none;"><i class="far fa-envelope"></i></button>
                    </g:else>
                </div>
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

                            <p style="margin: 0;"><g:link controller="user" action="getProfile" id="${s.subscriber.id}" style="text-decoration: none; color: darkred;">@${s.subscriber.userName}</g:link></p>

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
                                    <a href=""><i class="fab fa-facebook-f"></i></a> &nbsp; <a href=""><i class="fab fa-twitter"></i></a> &nbsp; <a href=""><i class="fab fa-google-plus-g"></i></a>
                                </p>
                                <g:if test="${i.class == linksharing.DocumentResource}">
                                    <p style="float: right; margin: 0;"><g:link controller="resource" action="download" id="${i.id}">Download</g:link>&nbsp;&nbsp;<g:link controller="resource" action="viewResource" id="${i.id}">View Post</g:link>
                                    </p>
                                </g:if>
                                <g:else>
                                    <p style="float: right; margin: 0;"><a
                                            href="${i.url}" target="_blank">View Full Site</a>&nbsp;&nbsp;<g:link controller="resource" action="viewResource" id="${i.id}">View Post</g:link>
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