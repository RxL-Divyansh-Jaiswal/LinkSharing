<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <script src="https://kit.fontawesome.com/75cf4e84e0.js" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <asset:stylesheet src="user/privateProfile.css"></asset:stylesheet>
    <title>PRIVATE PROFILE PAGE</title>
</head>
<body>
<!-- navbar -->
<div id="navbar">
    <a href="#" class="homeLink">Link Sharing</a>

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
<g:render template="/templates/modals" />

<h3 class="success">${flash.topicSuccess}</h3>
<h3 class="success">${flash.linkResSuccess}</h3>
<h3 class="success">${flash.docResSuccess}</h3>
<h3 class="error">${flash.topicError}</h3>
<h3 class="error">${flash.linkResError}</h3>
<h3 class="error">${flash.docResError}</h3>


<!-- main area -->
<div id="main_area">
    <div class="user_info">
        <div class="user_card">
            <asset:image src="${session.user.photo}" style="height: 6rem; width: 6rem; margin-left: 1%;"></asset:image>
            <div style="margin-left: 1%;">
                <p style="margin: 0;">${session.user.name}</p>
                <p style="margin: 0;">@${session.user.userName}</p>
                <p style="margin: 0;">Subscriptions&nbsp;&nbsp;&nbsp;&nbsp;Topics</p>
                <p style="margin: 0;">50&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;30</p>
            </div>
        </div>

        <div class="topics">
            <div class="head_box">
                <h3 style="margin: 0 2%; display: inline-block;">Topics</h3>
                <div style="float: right; margin-right: 1%; margin-top: 1%;">
                    <input type="text" placeholder="Search Post...">
                    <button class="topic_search_btn"><i class="fas fa-search"></i></button>
                </div>
            </div>

            <div>
                <div class="topic_details">
                    <img src="https://www.kindpng.com/picc/m/78-785827_user-profile-avatar-login-account-male-user-icon.png" style="height: 5rem; width: 5rem;">
                    <div class="topic_info">
                        <input type="text" placeholder="Grails">
                        <button>Save</button>
                        <p style="margin:0;">@uday&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Subscriptions&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Posts</p>
                        <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;30&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;50</p>
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

                    <button style="background: transparent; border: none;"><i class="far fa-envelope"></i></button>
                    <button style="background: transparent; border: none;"><i class="fas fa-edit"></i></button>
                    <button style="background: transparent; border: none;"><i class="fas fa-trash"></i></button>
                </div>
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


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</body>
</html>