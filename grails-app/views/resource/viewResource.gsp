<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <script src="https://kit.fontawesome.com/75cf4e84e0.js" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <asset:stylesheet src="resource/viewResource.css"></asset:stylesheet>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <asset:javascript src="rating.js"></asset:javascript>
    <asset:javascript src="searchTopic.js"></asset:javascript>
    <asset:javascript src="modifier.js"></asset:javascript>
    <script>
        var dataUrl = "${createLink(controller: 'topic', action: 'searchTopics')}"
        var rateUrl = "${createLink(controller: 'resource', action: 'rateResource')}"
        var visUrl = "${createLink(controller: 'topic', action: 'changeVisibility')}"
        var serUrl = "${createLink(controller: 'topic', action: 'changeSeriousness')}"
    </script>

    <title>${resource.topic.name}--Resource</title>
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

<div class="search_results"></div>

<!-- main area -->
<div id="main_area">
    <div class="post">
        <div class="details">
            <div class="post_info">
                <asset:image src="${resource.createdBy.photo}" style="height: 7rem; width: 7rem;"></asset:image>

                <div style="width: 34rem;">
                    <p style="margin: 1%;">${resource.createdBy.name} <g:link controller="topic" action="viewTopic" id="${resource.topic.id}" style="float: right;">${resource.topic.name}</g:link></p>

                    <p style="margin: 1%"><g:link controller="user" action="getProfile" id="${resource.topic.createdBy.id}" style="text-decoration: none; color: darkred;">@${resource.createdBy.userName}</g:link> <span
                            style="float: right;">${resource.dateCreated.toString().substring(11, 13)}:${resource.dateCreated.toString().substring(14, 16)} ${hourMap.get(resource.dateCreated.toString().substring(11, 13))} ${resource.dateCreated.toString().substring(8, 10)} ${monthMap.get(resource.dateCreated.toString().substring(5, 7))} ${resource.dateCreated.toString().substring(0, 4)}</span>
                    </p>
                </div>
            </div>

            <form id="rating-form" action="${resource.id}">
                <span class="rating-star">
                    <input type="radio" name="rating" value="5"><span class="star"></span>
                    <input type="radio" name="rating" value="4"><span class="star"></span>
                    <input type="radio" name="rating" value="3"><span class="star"></span>
                    <input type="radio" name="rating" value="2"><span class="star"></span>
                    <input type="radio" name="rating" value="1"><span class="star"></span>
                </span>
            </form>

            <p class="post_content">${resource.description}</p>

            <div class="post_navigator">
                <p style="float: left; margin: 0">
                    <a href=""><i class="fab fa-facebook-f"></i></a> &nbsp; <a href=""><i class="fab fa-twitter"></i></a> &nbsp; <a href=""><i class="fab fa-google-plus-g"></i></a>
                </p>
                <g:if test="${resource.createdBy.id == session.user.id || session.user.admin}">
                    <g:if test="${resource.class == linksharing.DocumentResource}">
                        <p style="float: right; margin: 0;"><g:link controller="resource" action="deleteResource" id="${resource.id}">Delete</g:link>&nbsp;&nbsp;<g:link controller="resource" action="download" id="${resource.id}">Download</g:link></p>
                    </g:if>
                    <g:else>
                        <p style="float: right; margin: 0;"><g:link controller="resource" action="deleteResource" id="${resource.id}">Delete</g:link>&nbsp;&nbsp;<a href="${resource.url}" target="_blank">View Full Site</a></p>
                    </g:else>
                </g:if>
                <g:else>
                    <g:if test="${resource.class == linksharing.DocumentResource}">
                        <p style="float: right; margin: 0;"><g:link controller="resource" action="download" id="${resource.id}">Download</g:link></p>
                    </g:if>
                    <g:else>
                        <p style="float: right; margin: 0;"><a href="${resource.url}" target="_blank">View Full Site</a></p>
                    </g:else>
                </g:else>

            </div>
        </div>

    </div>

    <div class="trending_topics">
        <div class="topics" style="height: auto">
            <div class="head_box">
                <h3 style="margin: 0 2%; display: inline-block;">Trendings Topics</h3>
            </div>

            <div id="trend_list" style="min-height: 8rem; max-height: 14rem; overflow-y: scroll">
                <g:each in="${trendingTopics}" var="i">
                    <g:if test="${i.isSubscribed}">
                        <div class="topic_details">
                            <asset:image src="${i.creatorPhoto}" style="height: 5rem; width: 5rem;"></asset:image>
                            <div class="topic_info">
                                <p style="margin: 0;">${i.creatorName}<g:link controller="topic" action="viewTopic" id="${i.topicId}" style="float: right;">${i.topicName}</g:link></p>

                                <div style="display: flex; flex-direction: row; justify-content: space-between;">
                                    <div>
                                        <p style="margin-bottom: 0;"><g:link controller="user" action="getProfile" id="${i.creatorId}" style="text-decoration: none; color: darkred;">@${i.creatorUserName}</g:link></p>
                                        <select onchange="changeSeriousness(${i.subsId},this.value)">
                                            <g:if test="${i.seriousness == linksharing.enums.Seriousness.Very_Serious}">
                                                <option value="Very_Serious">Very Serious</option>
                                                <option value="Serious">Serious</option>
                                                <option value="Casual">Casual</option>
                                            </g:if>
                                            <g:elseif test="${i.seriousness == linksharing.enums.Seriousness.Serious}">
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
                                    </div>

                                    <div>
                                        <p style="margin-bottom: 0;">Subscriptions</p>

                                        <p>${i.subsCount}</p>
                                    </div>

                                    <div>
                                        <p style="margin-bottom: 0;">Posts</p>

                                        <p>${i.postCount}</p>
                                    </div>
                                </div>

                                <g:if test="${i.creatorUserName == session.user.userName}">
                                    <p style="float: right; margin: -4% 0 0 0;">
                                        <select onchange="changeVisibility(${i.topicId},this.value)">
                                            <g:if test="${i.visibility == linksharing.enums.Visibility.Private}">
                                                <option>Private</option>
                                                <option>Public</option>
                                            </g:if>
                                            <g:else>
                                                <option>Public</option>
                                                <option>Private</option>
                                            </g:else>
                                        </select>
                                        &nbsp;&nbsp;<g:link controller="topic" action="deleteTopic" id="${i.topicId}">Delete</g:link>
                                    </p>
                                </g:if>
                            </div>
                        </div>
                    </g:if>
                    <g:else>
                        <div class="topic_details">
                            <asset:image src="${i.creatorPhoto}" style="height: 5rem; width: 5rem;"></asset:image>

                            <div class="topic_info">
                                <p style="margin: 0;">${i.creatorName}<g:link controller="topic" action="viewTopic" id="${i.topicId}" style="float: right;">${i.topicName}</g:link></p>

                                <div style="display: flex; flex-direction: row; justify-content: space-between;">
                                    <div>
                                        <p style="margin-bottom: 0;">@${i.creatorUserName}</p>
                                        <g:link controller="topic" action="subscribeTopic" id="${i.topicId}">Subscribe</g:link>
                                    </div>

                                    <div>
                                        <p style="margin-bottom: 0;">Subscriptions</p>

                                        <p>${i.subsCount}</p>
                                    </div>

                                    <div>
                                        <p style="margin-bottom: 0;">Posts</p>

                                        <p>${i.postCount}</p>
                                    </div>
                                </div>

                                <g:if test="${session.user.admin}">
                                    <p style="float: right; margin: -4% 0 0 0;">
                                        <select onchange="changeVisibility(${i.topicId},this.value)">
                                            <g:if test="${i.visibility == linksharing.enums.Visibility.Private}">
                                                <option>Private</option>
                                                <option>Public</option>
                                            </g:if>
                                            <g:else>
                                                <option>Public</option>
                                                <option>Private</option>
                                            </g:else>
                                        </select>
                                        &nbsp;&nbsp;<g:link controller="topic" action="deleteTopic" id="${i.topicId}">Delete</g:link>
                                    </p>
                                </g:if>
                            </div>
                        </div>
                    </g:else>
                </g:each>
            </div>
        </div>
    </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
</body>
</html>