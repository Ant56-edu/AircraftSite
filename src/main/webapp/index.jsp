<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="essentials/style.css">
<meta charset="UTF-8">
<title>Ant's Aircraft Database</title>
</head>
<body>
	<header>
		<h1 align="center">Welcome to Ant's Aircraft Database</h1>
		<%
		boolean userLogged = false;
		try { 
			String acceso = session.getAttribute("attributo1").toString();
			if (!acceso.equals("1"))
				response.sendRedirect("sessionhandler.jsp");
			userLogged = true;
		} catch (Exception e) {
			userLogged = false;
		}
		if (userLogged == false) {
		%>
		<a class="headerLink" href="loginscreen.jsp">Log in</a> <a
			class="headerLink" href="signupscreen.jsp">Sign up</a>
		<%
		} else {
		%>
		<a class="headerLink" href="logoutscreen.jsp">Log Out</a>
		<%
		}
		%>
		<a class="headerLink" href="editor.jsp">Create (or edit) entries</a>
	</header>
	<p align="center">This website is a student's web application
		project and still very much work in progress, so it may be a bit rough
		around the edges. Feel free to leave any constructive feedback in the
		form below. (Note: not all feedback submitted may be seen.
		Additionally, although being logged in is required to send feedback
		as a security measure, all feedback is anonymous.)</p>

	<br>
	<div>
		<h2>Aircraft Entry search</h2>
		<form action="planeEntry.jsp" method="post">
			<label> </label> <label for="searchFilters">Filters: <select
				name="filter" id="searchFilters">
					<optgroup id="FGT" label="Fighter">
						<option value="Air Superiority / Interceptor">Air
							Superiority / Interceptor</option>
						<option value="Fighter-Bomber">Fighter-Bomber</option>
						<option value="Multirole">Multirole</option>
						<option value="Reconnaissance">Reconnaissance</option>
						<option value="SEAD/DEAD">SEAD/DEAD</option>
					</optgroup>
					<optgroup id="BMBR" label="Bomber">
						<option value="Supersonic">Supersonic</option>
						<option value="Stealth">Stealth</option>
						<option value="Light">Light</option>
						<option value="Heavy">Heavy</option>
						<option value="Ground Attack">Ground Attack</option>
					</optgroup>
					<optgroup id="CRG" label="Cargo">
						<option value="Transport">Transport</option>
						<option value="Refueling">Refueling</option>
						<option value="Multirole">Multirole</option>
						<option value="Reconnaissance">Reconnaissance</option>
						<option value="Electronic Warfare">Electronic Warfare</option>
					</optgroup>
					<optgroup id="AEW&C" label="Advanced Early Warning & Control">
						<option value="Carrier Borne">Carrier Borne</option>
						<option value="Conventional">Conventional</option>
						<option value="Helicopter">Helicopter</option>
					</optgroup>
					<optgroup id="MPA" label="Maritime Patrol">
						<option value="Carrier Borne">Carrier Borne</option>
						<option value="Conventional">Conventional</option>
						<option value="Helicopter">Helicopter</option>
					</optgroup>
			</select>
			</label> <label> <input name="entryName" id="searchName">
			</label>
			<button type="submit">Search</button>
		</form>
	</div>
	<br>
	<br>
	<div>
		<h2>Weapon Entry search</h2>
		<form action="weaponEntry.jsp" method="post">
			<label> </label> <label for="searchFilters">Filters: <select
				name="filter" id="searchFilters">
					<optgroup id="MSSL" label="Missiles">
						<option id="AA" value="Air-to-Air">Air-to-Air</option>
						<option id="AS" value="Air-to-Surface">Air-to-Surface</option>
					</optgroup>
					<optgroup id="BMB" label="Bombs">
						<option id="GP" label="General Purpose">General Purpose</option>
						<option id="GD" label="Guided">Guided</option>
					</optgroup>
					<optgroup id="AW" label="Automatic weapons">
						<option id="AC" label="Autocannon">Autocannon</option>
						<option id="RC" label="Rotary Cannon">Rotary Cannon
							('Minigun')</option>
						<option id="MG" label="Machine Gun">Machine Gun</option>
					</optgroup>
					<optgroup id="PD" label="Pods">
						<option id="EW" label="Electronic Warfare">Electronic
							Warfare</option>
						<option id="TGT" label="Targeting">Targeting</option>
					</optgroup>
			</select>
			</label> <label> <input name="entryName" id="searchName">
			</label>
			<button type="submit">Search</button>
		</form>
	</div>
	<br>

	<div>
		<h2>Entries of the day</h2>
		<a class="entryLink"
			href="planeEntry.jsp?filter=Air Superiority&entryName=Grumman F-14 Tomcat">Grumman
			F-14 Tomcat</a> <br> <a class="entryLink"
			href="planeEntry.jsp?filter=Multirole&entryName=Dassault Rafale">Dassault
			Aviation</a> <br> <a class="entryLink"
			href="weaponEntry.jsp?filter=Air-to-Air&entryName=Aim-7 Sparrow">AIM-7
			Sparrow</a>
	</div>
</body>
<%
if (userLogged == true) {
%>
<footer>
	<h2>Feedback Form</h2>
	<form action="./FeedSub" method="post">
		<label for="feedbackSubject">Subject: <input name="subject"
			id="feedbackSubject" type="text"
			onkeypress="return checkfield(this,event);" maxlength="255">
		</label> <br> <label for="feedback">Text: <input name="text"
			id="feedback" type="text" onkeypress="return checkfield(this,event);"></label>
		<br>
		<button type="submit">Send</button>
	</form>
</footer>
<%
} else {
%>
<footer>
	<h1 align="center">You must be logged in to submit feedback</h1>
</footer>
<%
}
%>
</html>