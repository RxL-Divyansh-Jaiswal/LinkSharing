<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <script src="https://kit.fontawesome.com/75cf4e84e0.js" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <asset:stylesheet src="user/forgetPassword.css"></asset:stylesheet>
    <asset:javascript src="forgetPassword.js"></asset:javascript>
    <script>
        var checkUrl = "${createLink(controller: 'user', action: 'checkUser')}"
</script>
    <title>FORGET PASSWORD</title>
</head>
<body>
<!-- navbar -->
<div id="navbar">
    <g:link controller="home" action="home">Link Sharing</g:link>
</div>

<h3 style="text-align: center; color: red">${flash.msg}</h3>

<div class="info_input">
    <input id="email" class="email" type="email" name="email" placeholder="johnSmith@gmail.com" required>
    <button id="check_btn" class="continue_btn">Continue</button>
</div>

<div class="checker" style="height: auto;">
    <g:form controller="user" action="resetPassword" style="margin: 2%;">
        <input id="userEmail" type="email" name="email" style="display: none;">
        <p id="ques" style="text-align: center;"></p>
        <input type="text" name="answer" placeholder="Answer" style="margin-left: 28%; font-size: 1.25rem; width: 19rem;" required>
        <br>
        <input class="pass_input" type="password" name="new_password" placeholder="New Password (5-15 characters)" required>
        <br>
        <input class="pass_input" type="password" name="cnf_password" placeholder="Confirm Password" required>
        <br>
        <input type="submit" id="reset_btn" class="reset_btn" value="Reset Password">
    </g:form>
</div>

</body>
</html>