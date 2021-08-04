<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <script src="https://kit.fontawesome.com/75cf4e84e0.js" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <asset:stylesheet src="user/dashboard.css"></asset:stylesheet>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <asset:javascript src="searchTopic.js"></asset:javascript>
    <script>
        var dataUrl = "${createLink(controller: 'topic', action: 'searchTopics')}"
    </script>

    <title>DASHBOARD</title>
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

<h3 class="success">${flash.logSuccess}</h3>

<h3 class="success">${flash.topicSuccess}</h3>

<h3 class="success">${flash.linkResSuccess}</h3>

<h3 class="success">${flash.docResSuccess}</h3>

<h3 class="error">${flash.topicError}</h3>

<h3 class="error">${flash.linkResError}</h3>

<h3 class="error">${flash.docResError}</h3>

<div class="search_results">
    %{--<div class="head_box">--}%
        %{--<h3 style="margin: 0 2%; display: inline-block;">Search results for "Gr"</h3>--}%
    %{--</div>--}%

    %{--<div class="topic_details">--}%
        %{--<img src="https://www.kindpng.com/picc/m/78-785827_user-profile-avatar-login-account-male-user-icon.png" style="height: 5rem; width: 5rem;">--}%
        %{--<div class="topic_info">--}%
            %{--<p style="margin: 0;"><a href="">Grails</a></p>--}%
            %{--<div style="display: flex; flex-direction: row; justify-content: space-between;">--}%
                %{--<div>--}%
                    %{--<p style="margin-bottom: 0;">@rcthomas</p>--}%
                    %{--<a href="">Subscribe</a>--}%
                %{--</div>--}%
                %{--<div>--}%
                    %{--<p style="margin-bottom: 0;">Subscriptions</p>--}%
                    %{--<p>30</p>--}%
                %{--</div>--}%
                %{--<div>--}%
                    %{--<p style="margin-bottom: 0;">Posts</p>--}%
                    %{--<p>50</p>--}%
                %{--</div>--}%
            %{--</div>--}%
        %{--</div>--}%
    %{--</div>--}%
</div>

<!-- main area -->
<div id="main_area">
    <div class="user_info">
        <div class="user_card">
            %{--<img src="https://www.kindpng.com/picc/m/78-785827_user-profile-avatar-login-account-male-user-icon.png" style="height: 6rem; width: 6rem;">--}%
            <asset:image src="${session.user.photo}" style="height: 6rem; width: 6rem; margin-left: 1%;"></asset:image>
            <div style="margin-left: 1%;">
                <p style="margin: 0;">${session.user.name}</p>

                <p style="margin: 0;">@${session.user.userName}</p>

                <p style="margin: 0;">Subscriptions&nbsp;&nbsp;&nbsp;&nbsp;Topics</p>

                <p style="margin: 0;">50&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;30</p>
            </div>
        </div>

        <div class="subscriptions" style="height: auto">
            <div class="head_box">
                <h3 style="margin: 0 2%; display: inline-block;">Subscriptions</h3>
            </div>

            <div style="min-height: 8rem; max-height: 16rem; overflow-y: scroll">
                <g:each in="${subscriptions}" var="i">
                    <div style="height: 8rem;">
                        <div class="topic_details">
                            <asset:image src="${i.topic.createdBy.photo}"
                                         style="height: 5rem; width: 5rem;"></asset:image>
                            %{--<img src="https://www.kindpng.com/picc/m/78-785827_user-profile-avatar-login-account-male-user-icon.png"--}%
                            %{--style="height: 5rem; width: 5rem;">--}%

                            <div class="topic_info">
                                <p style="margin: 0;"><g:link controller="topic" action="viewTopic"
                                                              id="${i.topic.id}">${i.topic.name}</g:link></p>

                                <div style="display: flex; flex-direction: row; justify-content: space-between;">
                                    <div>
                                        <p style="margin-bottom: 0;">@${i.topic.createdBy.userName}</p>
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
                                %{--<p style="margin:0;">@${i.topic.createdBy.userName}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Subscriptions&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Posts</p>--}%

                                %{--<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;30&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;50</p>--}%
                            </div>
                        </div>

                        <div style="float: right;">
                            <select>
                                <option>Serious</option>
                                <option>Very Serious</option>
                                <option>Casual</option>
                            </select>

                            <select>
                                <option>Private</option>
                                <option>Public</option>
                            </select>

                            <button style="background: transparent; border: none;"><i class="far fa-envelope"></i>
                            </button>
                            <button style="background: transparent; border: none;"><i class="fas fa-edit"></i></button>
                            <button style="background: transparent; border: none;"><i class="fas fa-trash"></i></button>
                        </div>

                    </div>
                </g:each>
            %{--<div style="height: 8rem;">--}%
            %{--<div class="topic_details">--}%
            %{--<img src="https://www.kindpng.com/picc/m/78-785827_user-profile-avatar-login-account-male-user-icon.png"--}%
            %{--style="height: 5rem; width: 5rem;">--}%

            %{--<div class="topic_info">--}%
            %{--<p style="margin: 0;"><a href="">Grails</a></p>--}%

            %{--<p style="margin:0;">@uday&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Subscriptions&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Posts</p>--}%

            %{--<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;30&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;50</p>--}%
            %{--</div>--}%
            %{--</div>--}%

            %{--<div style="float: right;">--}%
            %{--<select>--}%
            %{--<option>Serious</option>--}%
            %{--<option>Very Serious</option>--}%
            %{--<option>Casual</option>--}%
            %{--</select>--}%

            %{--<select>--}%
            %{--<option>Private</option>--}%
            %{--<option>Public</option>--}%
            %{--</select>--}%

            %{--<button style="background: transparent; border: none;"><i class="far fa-envelope"></i></button>--}%
            %{--<button style="background: transparent; border: none;"><i class="fas fa-edit"></i></button>--}%
            %{--<button style="background: transparent; border: none;"><i class="fas fa-trash"></i></button>--}%
            %{--</div>--}%

            %{--</div>--}%

            %{--<div style="height: 8rem;">--}%
            %{--<div class="topic_details">--}%
            %{--<img src="https://www.kindpng.com/picc/m/78-785827_user-profile-avatar-login-account-male-user-icon.png"--}%
            %{--style="height: 5rem; width: 5rem;">--}%

            %{--<div class="topic_info">--}%
            %{--<p style="margin: 0;"><a href="">Grails</a></p>--}%

            %{--<p style="margin:0;">@rcthomas&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Subscriptions&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Posts</p>--}%

            %{--<p><a href="">Subscribe</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;30&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;50--}%
            %{--</p>--}%
            %{--</div>--}%
            %{--</div>--}%

            %{--<div style="float: right;">--}%
            %{--<select>--}%
            %{--<option>Serious</option>--}%
            %{--<option>Very Serious</option>--}%
            %{--<option>Casual</option>--}%
            %{--</select>--}%

            %{--<button style="background: transparent; border: none;"><i class="far fa-envelope"></i></button>--}%
            %{--</div>--}%
            %{--</div>--}%
            </div>

        </div>

        <div class="trending_topics" style="height: 20rem;">
            <div class="head_box">
                <h3 style="margin: 0 2%; display: inline-block;">Trendings Topics</h3>
            </div>

            <div class="topic_details">
                <img src="https://www.kindpng.com/picc/m/78-785827_user-profile-avatar-login-account-male-user-icon.png"
                     style="height: 5rem; width: 5rem;">

                <div class="topic_info">
                    <p style="margin: 0;"><a href="">Grails</a></p>

                    <div style="display: flex; flex-direction: row; justify-content: space-between;">
                        <div>
                            <p style="margin-bottom: 0;">@rcthomas</p>
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

                    %{--<p><a href="">Subscribe</a>&nbsp;&nbsp;&nbsp;30&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;50--}%
                    %{--</p>--}%
                </div>
            </div>

            <div>
                <div class="topic_details">
                    <img src="https://www.kindpng.com/picc/m/78-785827_user-profile-avatar-login-account-male-user-icon.png"
                         style="height: 5rem; width: 5rem;">

                    <div class="topic_info">
                        <input type="text" placeholder="Grails">
                        <button>Save</button>

                        <div style="display: flex; flex-direction: row; justify-content: space-between;">
                            <div>
                                <p style="margin-bottom: 0;">@rcthomas</p>
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

                        <div style="float: right;">
                            <select>
                                <option>Serious</option>
                                <option>Very Serious</option>
                                <option>Casual</option>
                            </select>

                            <select>
                                <option>Private</option>
                                <option>Public</option>
                            </select>

                            <button style="background: transparent; border: none;"><i class="far fa-envelope"></i>
                            </button>
                            <button style="background: transparent; border: none;"><i class="fas fa-edit"></i></button>
                            <button style="background: transparent; border: none;"><i class="fas fa-trash"></i></button>
                        </div>

                        %{--<p style="margin:0;">@uday&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Subscriptions&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Posts</p>--}%

                        %{--<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;30&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;50</p>--}%
                    </div>
                </div>


                %{--<div style="float: right;">--}%
                %{--<select>--}%
                %{--<option>Serious</option>--}%
                %{--<option>Very Serious</option>--}%
                %{--<option>Casual</option>--}%
                %{--</select>--}%

                %{--<select>--}%
                %{--<option>Private</option>--}%
                %{--<option>Public</option>--}%
                %{--</select>--}%

                %{--<button style="background: transparent; border: none;"><i class="far fa-envelope"></i></button>--}%
                %{--<button style="background: transparent; border: none;"><i class="fas fa-edit"></i></button>--}%
                %{--<button style="background: transparent; border: none;"><i class="fas fa-trash"></i></button>--}%
                %{--</div>--}%
            </div>

        </div>
    </div>

    <div class="posts">
        <div class="post_list">
            <div class="head_box">
                <h3 style="margin: 0 2%; display: inline-block;">Inbox</h3>

                <div style="float: right; margin-right: 1%; margin-top: 1%;">
                    <input type="text" placeholder="Search Post...">
                    <button class="post_search_btn"><i class="fas fa-search"></i></button>
                </div>
            </div>

            <div class="related_posts">
                <div class="post_card">
                    <img src="https://www.kindpng.com/picc/m/78-785827_user-profile-avatar-login-account-male-user-icon.png"
                         style="height: 5rem; width: 5rem;">

                    <div class="post_card_details">
                        <div class="info">
                            <p style="float: left; margin: 0;">Uday Pratap Singh &nbsp; @uday</p>

                            <p style="float: right; margin: 0;"><a href="">Grails</a></p>
                        </div>

                        <p>
                            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
                        </p>

                        <div class="post_card_navigator">
                            <p style="float: left; margin: 0">
                                <a href=""><i class="fab fa-facebook-f"></i></a> &nbsp; <a href=""><i
                                    class="fab fa-twitter"></i></a> &nbsp; <a href=""><i
                                    class="fab fa-google-plus-g"></i></a>
                            </p>

                            <p style="float: right; margin: 0;"><a href="">Download</a>&nbsp;&nbsp;<a
                                    href="">View Full Site</a>&nbsp;&nbsp;<a href="">Mark as Read</a>&nbsp;&nbsp;<a
                                    href="">View Post</a></p>
                        </div>
                    </div>
                </div>

                <div class="post_card">
                    <img src="https://www.kindpng.com/picc/m/78-785827_user-profile-avatar-login-account-male-user-icon.png"
                         style="height: 5rem; width: 5rem;">

                    <div class="post_card_details">
                        <div class="info">
                            <p style="float: left; margin: 0;">Uday Pratap Singh &nbsp; @uday</p>

                            <p style="float: right; margin: 0;"><a href="">Grails</a></p>
                        </div>

                        <p>
                            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
                        </p>

                        <div class="post_card_navigator">
                            <p style="float: left; margin: 0">
                                <a href=""><i class="fab fa-facebook-f"></i></a> &nbsp; <a href=""><i
                                    class="fab fa-twitter"></i></a> &nbsp; <a href=""><i
                                    class="fab fa-google-plus-g"></i></a>
                            </p>

                            <p style="float: right; margin: 0;"><a href="">Download</a>&nbsp;&nbsp;<a
                                    href="">View Full Site</a>&nbsp;&nbsp;<a href="">Mark as Read</a>&nbsp;&nbsp;<a
                                    href="">View Post</a></p>
                        </div>
                    </div>
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