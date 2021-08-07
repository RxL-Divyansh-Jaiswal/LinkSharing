<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <script src="https://kit.fontawesome.com/75cf4e84e0.js" crossorigin="anonymous"></script>
    <asset:stylesheet src="home/index.css"></asset:stylesheet>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <asset:javascript src="topPosts.js"></asset:javascript>
    <asset:javascript src="recentPosts.js"></asset:javascript>
    <script>
        var topUrl = "${createLink(controller: 'resource', action: 'topPosts')}"
        var recentUrl = "${createLink(controller: 'resource', action: 'recentShares')}"
    </script>
    <title>Home Page</title>
</head>

<body>
<!-- navbar -->
<div id="navbar">
    <g:link controller="home" action="home">Link Sharing</g:link>

    <div class="navigator">
        <input type="text" name="search" placeholder="Search...">
        <button>Search</button>

    </div>

</div>

<h3 class="success">${flash.logSuccess}</h3>

<!-- main area -->
<div id="main_area">
    <div class="posts">

        <div class="recent">
            <div class="head_box">
                <h2 style="margin: 0 2%">Recent Shares</h2>
            </div>

            <div id="recent_shares" style="min-height:10rem; max-height: 20rem;overflow-y: scroll;"></div>
        </div>

        <div class="tops">
            <div class="head_box">
                <h2 style="margin: 0 2%; display: inline-block;">Top Posts</h2>
                %{--<select style="float: right; margin-right: 1%; margin-top: 1%;">--}%
                    %{--<option>Day</option>--}%
                    %{--<option>Week</option>--}%
                    %{--<option>Month</option>--}%
                    %{--<option>Year</option>--}%
                %{--</select>--}%

            </div>

            <div id="top_posts" style="min-height:10rem; max-height: 20rem;overflow-y: scroll;"></div>

        </div>

    </div>

    <div class="forms">

        <div class="login_form">
            <p class="heading"><i>Welcome Back</i></p>

            <h3 class="errMsg">${flash.logError}</h3>

            <g:form controller="user" action="loginUser" method="post">
                <label>Email &nbsp; &nbsp; &nbsp;</label>
                <input type="email" name="email" required>
                <br>
                <label>Password</label>
                <input type="password" name="password" required>
                <br>

                <p class="forgetLink"><a href=""><i>Forget Password</i></a></p>
                <input id="loginBtn" type="submit" value="Log In">
            </g:form>

        </div>

        <div class="register_form">
            <p class="heading"><i>New Here, Let's get started...</i></p>

            <h3 class="succMsg">${flash.success}</h3>

            <h3 class="errMsg">${flash.resError}</h3>

            <g:form controller="user" action="registerUser" method="post" enctype="multipart/form-data">
                <label>First name</label>
                <input type="text" name="firstName" placeholder="John" required style="margin-left: 18%;">
                <br>
                <label>Last name</label>
                <input type="text" name="lastName" placeholder="Smith" required style="margin-left: 19%">
                <br>
                <label>Email &nbsp; &nbsp; &nbsp;</label>
                <input type="email" name="email" placeholder="johnSmith@gmail.com" required style="margin-left: 20.5%">
                <br>
                <label>Username &nbsp; &nbsp; &nbsp;</label>
                <input type="text" name="userName" placeholder="jSmith" required style="margin-left: 11%">
                <br>
                <label style="margin-top: 10px;">Password</label>
                <input type="password" name="password" placeholder="(5 - 15 characters)" required style="margin-left: 21%">
                <br>
                <label style="margin-top: 10px;">Confirm Password</label>
                <input type="password" name="cnf_password" placeholder="(5 - 15 characters)" required>
                <br>
                <label style="margin-top: 10px;">Photo</label>
                <input type="file" name="image">
                <br>
                <input id="registerBtn" type="submit" value="Register">
            </g:form>
        </div>

    </div>
</div>

</body>
</html>