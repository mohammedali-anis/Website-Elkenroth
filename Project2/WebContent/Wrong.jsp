
<!--   @author Mohammed Ali Anis -->
 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Something went wrong</title>
</head>
<Style>
body {
	background-color: #2C2E3B;
	font-family: 'Montserrat', sans-serif;
	font-size: 16px;
	line-height: 1.25;
	letter-spacing: 1px;
}

* {
	box-sizing: border-box;
	transition: .25s all ease;
}

.login-container {
	display: block;
	position: relative;
	z-index: 0;
	margin: 4rem auto 0;
 	padding: 5rem 4rem 0 4rem;
	width: 100%;
	max-width: 525px;
	min-height: 680px;
	background-image: url(https://www.heimatverein-altenkirchen.de/bilder/impressionen/rathaus_betzdorf.jpg);
	box-shadow: 0 50px 70px -20px rgba(0, 0, 0, 0.85);
}

.login-container:after {
	content: '';
	display: inline-block;
	position: absolute;
	z-index: 0;
	top: 0;
	right: 0;
	bottom: 0;
	left: 0;
	background-image: radial-gradient(ellipse at left bottom, rgba(22, 24, 47, 1) 0%,rgba(38, 20, 72, .9) 59%, rgba(17, 27, 75, .9) 100%);
	box-shadow: 0 -20px 150px -20px rgba(0, 0, 0, 0.5);
}

.form-login {
	position: relative;
	z-index: 1;
  padding-bottom: 4.5rem;
  
}

.login-nav {
	position: relative;
	padding: 0;
	margin: 0 0 10em 1rem;
}

.login-nav__item {
	list-style: none;
	display: inline-block;
}

.login-nav__item + .login-nav__item {
	margin-left: 2.25rem;
}

.login-nav__item a {
	position: relative;
	color: rgba(255, 255, 255, 0.5);
	text-decoration: none;
	text-transform: uppercase;
	font-weight: 500;
	font-size: 1.25rem;
	padding-bottom: .9rem;
	transition: .20s all ease;
}

.login-nav__item.active a,
.login-nav__item a:hover{
	color: #FF0000;
	transition: .15s all ease;
}

.login-nav__item a:after {
	content: '';
  display: inline-block;
  height: 10px;
  background-color: rgb(255, 255, 255);
  position: absolute;
  right: 100%;
  bottom: -1px;
  left: 0;
  border-radius: 50%;
  transition: .15s all ease;
}

.login-nav__item a:hover:after,
.login-nav__item.active a:after{
	background-color: rgb(17, 97, 237);
	height: 2px;
	right: 0;
	bottom: 2px;
	border-radius: 0;
	transition: .20s all ease;
}
.login__label {
	display: block;
	padding-left: 1rem;
	padding-right: 0rem;
}

.login__label,
.login__label--checkbox {
	color: #FFFFFF;
	text-transform: capitalize;
	font-size: 2.99rem;
	margin-bottom: 1rem;
	font-style: inherit;
}


.login__label2 {
	display: block;
	padding-left: 1rem;
}

.login__label2 {
	color: #FFFFFF;
	text-transform: capitalize;
	font-size: 1.1rem;
	margin-bottom: 1rem;
	font-style: inherit;
}


</Style>

<body>



<div class="login-container">
	<form action="ForgetPassword" class="form-login" method="post">
		<ul class="login-nav">
			<li class="login-nav__item active">
				<a>Something Went Wrong !</a>
			</li>
		</ul>
		
		<label for="login-input-user" class="login__label">
			Ooops ! 
		</label>
		
		<label class="login__label2">
			Something went wrong please try again ! 
		</label>
		
		
		
		
		
	</form>
	
</div>


</body>
</html>