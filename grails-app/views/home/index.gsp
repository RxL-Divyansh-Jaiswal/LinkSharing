<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <script src="https://kit.fontawesome.com/75cf4e84e0.js" crossorigin="anonymous"></script>
    <asset:stylesheet src="home/index.css"></asset:stylesheet>
    <title>Home Page</title>
</head>

<!-- navbar -->
	<div id="navbar">
		<a href="#">Link Sharing</a>

		<div class="navigator">
			<input type="text" name="search" placeholder="Search...">
			<button>Search</button>
		</div>
	</div>

	<!-- main area -->
	<div id="main_area">
		<div class="posts">

			<div class="recent">
				<div class="head_box">
					<h2 style="margin: 0 2%">Recent Shares</h2>
				</div>

				<div class="card">
					<img src="https://www.kindpng.com/picc/m/78-785827_user-profile-avatar-login-account-male-user-icon.png" style="height: 6rem; width: 6rem;">
					<div class="card_details">
						<div class="info">
							<p style="float: left; margin: 0;">Uday Pratap Singh &nbsp; @uday &nbsp; 5 min</p>
							<p style="float: right; margin: 0;"><a href="">Grails</a></p>
						</div>

						<p>
							Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
						</p>

						<div class="card_navigator">
							<p style="float: left; margin: 0">
								<a href=""><i class="fab fa-facebook-f"></i></a> &nbsp; <a href=""><i class="fab fa-twitter"></i></a> &nbsp; <a href=""><i class="fab fa-google-plus-g"></i></a>
							</p>
							<p style="float: right; margin: 0;"><a href="">View Post</a></p>
						</div>
					</div>
				</div>

				<div class="card">
					<img src="https://www.kindpng.com/picc/m/78-785827_user-profile-avatar-login-account-male-user-icon.png" style="height: 6rem; width: 6rem;">
					<div class="card_details">
						<div class="info">
							<p style="float: left; margin: 0;">Uday Pratap Singh &nbsp; @uday &nbsp; 5 min</p>
							<p style="float: right; margin: 0;"><a href="">Grails</a></p>
						</div>

						<p>
							Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
						</p>

						<div class="card_navigator">
							<p style="float: left; margin: 0">
								<a href=""><i class="fab fa-facebook-f"></i></a> &nbsp; <a href=""><i class="fab fa-twitter"></i></a> &nbsp; <a href=""><i class="fab fa-google-plus-g"></i></a>
							</p>
							<p style="float: right; margin: 0;"><a href="">View Post</a></p>
						</div>
					</div>
				</div>
			</div>

			<div class="tops">
				<div class="head_box">
					<h2 style="margin: 0 2%; display: inline-block;">Top Posts</h2>
					<select style="float: right; margin-right: 1%; margin-top: 1%;">
						<option>Day</option>
						<option>Week</option>
						<option>Month</option>
						<option>Year</option>
					</select>
				</div>

				<div style="overflow-y: scroll;">
					<div class="card">
					<img src="https://www.kindpng.com/picc/m/78-785827_user-profile-avatar-login-account-male-user-icon.png" style="height: 6rem; width: 6rem;">
					<div class="card_details">
						<div class="info">
							<p style="float: left; margin: 0;">Uday Pratap Singh &nbsp; @uday &nbsp; 5 min</p>
							<p style="float: right; margin: 0;"><a href="">Grails</a></p>
						</div>

						<p>
							Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
						</p>

						<div class="card_navigator">
							<p style="float: left; margin: 0">
								<a href=""><i class="fab fa-facebook-f"></i></a> &nbsp; <a href=""><i class="fab fa-twitter"></i></a> &nbsp; <a href=""><i class="fab fa-google-plus-g"></i></a>
							</p>
							<p style="float: right; margin: 0;"><a href="">View Post</a></p>
						</div>
					</div>
				</div>
				</div>

			</div>

		</div>
		<div class="forms">

			<div class="login_form">
				<p class="heading"><i>Welcome Back</i></p>
				<h3 class="errMsg">${flash.logError}</h3>
				<form action="user/loginUser" method="post">
					<label>Email &nbsp; &nbsp; &nbsp;</label>
					<input type="email" name="email" required>
					<br>
					<label>Password</label>
					<input type="password" name="password" required>
					<br>
					<p class="forgetLink"><a href=""><i>Forget Password</i></a></p>
					<input id="loginBtn" type="submit" value="Log In">
				</form>
			</div>

			<div class="register_form">
				<p class="heading"><i>New Here, Let's get started...</i></p>
				<h3 class="succMsg">${flash.success}</h3>
				<h3 class="errMsg">${flash.resError}</h3>

				<form action="user/registerUser" method="post" enctype="multipart/form-data">
					<label>First name</label>
					<input type="text" name="firstName" required style="margin-left: 18%;">
					<br>
					<label>Last name</label>
					<input type="text" name="lastName" required style="margin-left: 19%">
					<br>
					<label>Email &nbsp; &nbsp; &nbsp;</label>
					<input type="email" name="email" required style="margin-left: 20.5%">
					<br>
					<label>Username &nbsp; &nbsp; &nbsp;</label>
					<input type="text" name="userName" required style="margin-left: 11%">
					<br>
					<label style="margin-top: 10px;">Password</label>
					<input type="password" name="password" required style="margin-left: 21%">
					<br>
					<label style="margin-top: 10px;">Confirm Password</label>
					<input type="password" name="cnf_password" required>
					<br>
					<label style="margin-top: 10px;">Photo</label>
					<input type="file" name="image">
					<br>
					<input id="registerBtn" type="submit" value="Register">
				</form>
			</div>

		</div>
	</div>

</body>
</html>