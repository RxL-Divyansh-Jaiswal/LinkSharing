<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <script src="https://kit.fontawesome.com/75cf4e84e0.js" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <asset:stylesheet src="resource/viewResource.css"></asset:stylesheet>
    <title>${resource.topic.name}--Resource</title>
</head>

<body>
<!-- navbar -->
<div id="navbar">
    <g:link controller="home" action="home" class="homeLink">Link Sharing</g:link>

    <div class="navigator">
        <ul>
            <li>
                <input type="text" name="search" placeholder="Search...">
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

<!-- main area -->
<div id="main_area">
    <div class="post">
        <div class="details">
            <div class="post_info">
                <asset:image src="${resource.createdBy.photo}" style="height: 7rem; width: 7rem;"></asset:image>
                %{--<img src="https://www.kindpng.com/picc/m/78-785827_user-profile-avatar-login-account-male-user-icon.png" style="height: 7rem; width: 7rem;">--}%

                <div style="width: 34rem;">
                    <p style="margin: 1%;">${resource.createdBy.name} <g:link controller="topic" action="viewTopic"
                                                                              id="${resource.topic.id}"
                                                                              style="float: right;">${resource.topic.name}</g:link></p>

                    <p style="margin: 1%">@${resource.createdBy.userName} <span
                            style="float: right;">${resource.dateCreated.toString().substring(11, 13)}:${resource.dateCreated.toString().substring(14, 16)} ${hourMap.get(resource.dateCreated.toString().substring(11, 13))} ${resource.dateCreated.toString().substring(8, 10)} ${monthMap.get(resource.dateCreated.toString().substring(5, 7))} ${resource.dateCreated.toString().substring(0, 4)}</span>
                    </p>
                </div>
            </div>

            <form id="rating-form">
                <span class="rating-star">
                    <input type="radio" name="rating" value="5"><span class="star"></span>
                    <input type="radio" name="rating" value="4"><span class="star"></span>
                    <input type="radio" name="rating" value="3"><span class="star"></span>
                    <input type="radio" name="rating" value="2"><span class="star"></span>
                    <input type="radio" name="rating" value="1"><span class="star"></span>
                </span>
            </form>

            <p class="post_content">${resource.description}</p>

            %{--<p class="post_content">--}%
            %{--Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.--}%
            %{--</p>--}%

            <div class="post_navigator">
                <p style="float: left; margin: 0">
                    <a href=""><i class="fab fa-facebook-f"></i></a> &nbsp; <a href=""><i class="fab fa-twitter"></i>
                </a> &nbsp; <a href=""><i class="fab fa-google-plus-g"></i></a>
                </p>
                <g:if test="${resource.class == linksharing.DocumentResource}">
                    <p style="float: right; margin: 0;"><a href="">Delete</a>&nbsp;&nbsp;<a
                            href="">Edit</a>&nbsp;&nbsp;<g:link controller="resource" action="download"
                                                                id="${resource.id}">Download</g:link></p>
                </g:if>
                <g:else>
                    <p style="float: right; margin: 0;"><a href="">Delete</a>&nbsp;&nbsp;<a
                            href="">Edit</a>&nbsp;&nbsp;<a href="${resource.url}" target="_blank">View Full Site</a></p>
                </g:else>
            </div>
        </div>

    </div>

    <div class="trending_topics">
        <div class="topics">
            <div class="head_box">
                <h3 style="margin: 0 2%; display: inline-block;">Trendings Topics</h3>
            </div>

            <div class="topic_details">
                <img src="https://www.kindpng.com/picc/m/78-785827_user-profile-avatar-login-account-male-user-icon.png"
                     style="height: 5rem; width: 5rem;">

                <div class="topic_info">
                    <p style="margin: 0;">Uday Pratap Singh<a href="" style="float: right;">Grails</a></p>

                    <div style="display: flex; flex-direction: row; justify-content: space-between;">
                        <div>
                            <p style="margin-bottom: 0;">@uday</p>
                            <a href="">Subscribe</a>
                        </div>

                        <div>
                            <p style="margin-bottom: 0;">Subscriptions</p>

                            <p>30</p>
                        </div>

                        <div>
                            <p style="margin-bottom: 0;">Posts</p>

                            <p>50</p>
                        </div>
                    </div>
                    %{--<p style="margin:0;">@uday&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Subscriptions&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Posts</p>--}%
                    %{--<p><a href="">Subscribe</a>&nbsp;&nbsp;&nbsp;30&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;50</p>--}%
                </div>
            </div>

            <div class="topic_details">
                <img src="https://www.kindpng.com/picc/m/78-785827_user-profile-avatar-login-account-male-user-icon.png"
                     style="height: 5rem; width: 5rem;">

                <div class="topic_info">
                    <p style="margin: 0;">Uday Pratap Singh<a href="" style="float: right;">Grails</a></p>

                    <div style="display: flex; flex-direction: row; justify-content: space-between;">
                        <div>
                            <p style="margin-bottom: 0;">@rcthomas</p>
                            <select>
                                <option>Serious</option>
                                <option>Very Serious</option>
                                <option>Casual</option>
                            </select>
                        </div>

                        <div>
                            <p style="margin-bottom: 0;">Subscriptions</p>

                            <p>30</p>
                        </div>

                        <div>
                            <p style="margin-bottom: 0;">Posts</p>

                            <p>50</p>
                        </div>
                    </div>

                    <p style="float: right; margin: -4% 0 0 0;">
                        <select>
                            <option>Private</option>
                            <option>Public</option>
                        </select>
                        &nbsp;&nbsp;<a href="">Edit</a>&nbsp;&nbsp;<a href="">Delete</a>
                    </p>
                    %{--<p style="margin:0;">@uday&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Subscriptions&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Posts</p>--}%
                    %{--<p>--}%
                    %{--<select>--}%
                    %{--<option>Serious</option>--}%
                    %{--<option>Very Serious</option>--}%
                    %{--<option>Casual</option>--}%
                    %{--</select>--}%
                    %{--&nbsp;&nbsp;&nbsp;30&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;50</p>--}%
                </div>
            </div>

            %{--<p style="float: right; margin: -4% 4% 0 0;">--}%
            %{--<select>--}%
            %{--<option>Private</option>--}%
            %{--<option>Public</option>--}%
            %{--</select>--}%
            %{--&nbsp;&nbsp;<a href="">Edit</a>&nbsp;&nbsp;<a href="">Delete</a>--}%
            %{--</p>--}%
        </div>
    </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
</body>
</html>