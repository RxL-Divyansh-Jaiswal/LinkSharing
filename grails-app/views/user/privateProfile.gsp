<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <script src="https://kit.fontawesome.com/75cf4e84e0.js" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <asset:stylesheet src="user/privateProfile.css"></asset:stylesheet>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <asset:javascript src="searchTopic.js"></asset:javascript>
    <asset:javascript src="modifier.js"></asset:javascript>
    <script>
        var dataUrl = "${createLink(controller: 'topic', action: 'searchTopics')}"
        var visUrl = "${createLink(controller: 'topic', action: 'changeVisibility')}"
        var serUrl = "${createLink(controller: 'topic', action: 'changeSeriousness')}"
    </script>
    <title>PRIVATE PROFILE PAGE</title>
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

<h3 class="error">${flash.topicError}</h3>

<h3 class="error">${flash.linkResError}</h3>

<h3 class="error">${flash.docResError}</h3>

<div class="search_results"></div>

<!-- main area -->
<div id="main_area">
    <div class="user_info">
        <div class="user_card">
            <asset:image src="${session.user.photo}" style="height: 6rem; width: 6rem; margin-left: 1%;"></asset:image>
            <div style="margin-left: 1%;">
                <p style="margin: 0;">${session.user.name}</p>

                <p style="margin: 0;">@${session.user.userName}</p>

                <p style="margin: 0;">Subscriptions&nbsp;&nbsp;&nbsp;&nbsp;Topics</p>

                <p style="margin: 0;">${linksharing.Subscription.findAllBySubscriber(session.user).size()}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${linksharing.Topic.findAllByCreatedBy(session.user).size()}</p>
            </div>
        </div>

        <div class="topics">
            <div class="head_box">
                <h3 style="margin: 0 2%; display: inline-block;">Topics</h3>
            </div>

            <div id="topic_list" style="min-height: 10rem; max-height: 20rem; overflow-y: scroll">
                <g:each in="${topics}" var="i">
                    <div class="topic_details">
                        <asset:image src="${i.createdBy.photo}" style="height: 5rem; width: 5rem;"></asset:image>

                        <div class="topic_info">
                            <input type="text" placeholder="${i.name}">
                            <button>Save</button>

                            <div style="display: flex; flex-direction: row; justify-content: space-between;">
                                <div>
                                    <p style="margin-bottom: 0;">@${i.createdBy.userName}</p>
                                </div>

                                <div>
                                    <p style="margin-bottom: 0;">Subscriptions</p>

                                    <p>${i.subscriptions.size()}</p>
                                </div>

                                <div>
                                    <p style="margin-bottom: 0;">Posts</p>

                                    <p>${i.resources.size()}</p>
                                </div>
                            </div>

                            <div style="float: right;">
                                <select onchange="changeSeriousness(${linksharing.Subscription.findByTopicAndSubscriber(i,session.user).id},this.value)">
                                    <g:if test="${linksharing.Subscription.findByTopicAndSubscriber(i,session.user).seriousness == linksharing.enums.Seriousness.Very_Serious}">
                                        <option value="Very_Serious">Very Serious</option>
                                        <option value="Serious">Serious</option>
                                        <option value="Casual">Casual</option>
                                    </g:if>
                                    <g:elseif test="${linksharing.Subscription.findByTopicAndSubscriber(i,session.user).seriousness == linksharing.enums.Seriousness.Serious}">
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

                                <select onchange="changeVisibility(${i.id},this.value)">
                                    <g:if test="${i.visibility == linksharing.enums.Visibility.Private}">
                                        <option>Private</option>
                                        <option>Public</option>
                                    </g:if>
                                    <g:else>
                                        <option>Public</option>
                                        <option>Private</option>
                                    </g:else>
                                </select>

                                <button style="background: transparent; border: none;"><i class="far fa-envelope"></i></button>
                                <button style="background: transparent; border: none;"><g:link controller="topic" action="deleteTopic" id="${i.id}" style="color: black;"><i class="fas fa-trash"></i></g:link></button>
                            </div>
                        </div>
                    </div>
                </g:each>
            </div>

        </div>
    </div>

    <div class="edit_forms">
        <div class="profile_form">
            <div class="head_box">
                <h3 style="margin: 0 2%; display: inline-block;">Profile</h3>
            </div>

            <h3 class="success">${flash.profileSucc}</h3>

            <g:form controller="user" action="updateProfile" method="post" enctype="multipart/form-data" style="margin: 2%;">
                <label>Email&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                <input type="text" name="email" value="${session.user.email}" style="margin-top: 10px;">
                <br>
                <label>First Name&nbsp;</label>
                <input type="text" name="firstName" value="${session.user.firstName}" style="margin-top: 10px;">
                <br>
                <label>Last Name&nbsp;</label>
                <input type="text" name="lastName" value="${session.user.lastName}" style="margin-top: 10px;">
                <br>
                <label>Username&nbsp;&nbsp;</label>
                <input type="text" name="userName" value="${session.user.userName}" style="margin-top: 10px;">
                <br>
                <label>Photo</label>
                <input type="file" name="image" style="margin-top: 10px;">
                <br>
                <input class="profile_upd_btn" type="submit" value="Update">
            </g:form>
        </div>

        <div class="password_form">
            <div class="head_box">
                <h3 style="margin: 0 2%; display: inline-block;">Change Password</h3>
            </div>

            <h3 class="success">${flash.passSuccess}</h3>

            <h3 class="error">${flash.passError}</h3>

            <g:form controller="user" action="updatePassword" style="margin: 2%;">
                <label>Password&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                <input type="password" name="password" style="margin-top: 10px;">
                <br>
                <label>Confirm Password</label>
                <input type="password" name="cnf_password" style="margin-top: 10px;">
                <br>
                <input class="reset_pass_btn" type="submit" value="Change Password">
            </g:form>
        </div>
    </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
</body>
</html>