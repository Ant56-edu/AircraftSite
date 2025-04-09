<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="essentials/style.css">
<title>Ant's Aircraft Database Login</title>
</head>
<body>
	<header>
		<h1 align="center">Ant's Aircraft Database Login Screen</h1>
	</header>
	<form action="./LogAuth" method="post" name="login" id="login">
		<table align="center">
			<tr>
				<td><input type="hidden" name="varoculta" value="secret" />
					Username:</td>
				<td><input type="text" name="usuario"
					onkeypress="return checkfield(this,event);" maxlength="10" value="" /></td>
			</tr>
			<tr>
				<td>Password:</td>
				<td><input type="password" name="pass"
					onkeypress="return checkfield(this,event);" maxlength="8" value="" /></td>
			</tr>
			<tr>
				<td></td>
				<td style="text-align: right;"><input type="button" name="send"
					value="Log in" onclick="checksend();" /></td>
			</tr>
		</table>
	</form>
	<script type="text/javascript" src="./essentials/scripts.js"></script>
</body>
</html>