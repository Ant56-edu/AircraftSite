<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="pk.beanDB"%>
<%@page import="java.sql.SQLException"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="essentials/style.css">
<title>Ant's Aircraft Database</title>
</head>
<body>
	<header>
		<h1 align="center">Ant's Aircraft Database Entry Creator</h1>
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
		if (userLogged != true) {
		%>
		<a class="headerLink" href="loginscreen.jsp">Log in</a> <a
			class="headerLink" href="signupscreen.jsp">Sign up</a>
		<%
		} else {
		%>
		<a class="headerLink" href="logoutscreen.jsp">Log Out</a> <a
			class="headerLink" href="index.jsp">Go back to the Home Page</a>
		<%
}
%>
		<%
		String[][] tablares = null;
		String[][] tablares2 = null;
		String[][] tablares3 = null;
		beanDB db = new beanDB();
		boolean okdb = false;
		String resultado = "";
		String resultado2 = "";
		try {
			db.conectarBD();
			okdb = true;
		} catch (Exception e) {
			okdb = false;
			e.printStackTrace();
		}
		if (okdb) {
			String query = "select manId, name from MANUFACTURER;";
			String query2 = "select planeTypeId, type from PLANETYPES;";
			String query3 = "select armTypeId, type from ARMTYPES;";
			try {
				tablares = db.resConsultaSelectA3(query);
				tablares2 = db.resConsultaSelectA3(query2);
				tablares3 = db.resConsultaSelectA3(query3);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			db.desconectarBD();
		} else {
			resultado = "<div style='color: darkred; font-weight: bold;'>ERROR: No se pudo conectar con la BBDD</div>";
		}

		if (userLogged == true) {
		%>
	</header>
	<h3>Aircraft Entry</h3>
	<form action="./EntryUpload?entryType=planeEntry" method="post"
		name="planeEntry">
		<table>
			<tbody>
				<tr>
					<td>Name <input id="planeName" type="text" name="name"></td>
					<td>Type <select id="Ptypes" name="type">
							<%
							if (tablares2 != null) {
								for (int i = 0; i < tablares2.length; i++) {
							%>
							<option valve="<%=tablares2[i][0]%>"><%=tablares2[i][1]%></option>
							<%
								}
							}
							%>
					</select></td>
					<td>Country <select id="Ptypes" name="country">
							<option value="US">United States</option>
							<option value="RU">Russia</option>
							<option value="CN">China</option>
							<option value="FR">France</option>
							<option value="DE">Germany</option>
							<option value="GB">United Kingdom</option>
							<option value="IT">Italy</option>
							<option value="SE">Sweden</option>
							<option value="IS">Israel</option>
							<option value="KR">South Korea</option>
							<option value="IN">India</option>
							<option value="JP">Japan</option>
							<option value="TK">Turkey</option>
					</select></td>
					<td>Manufacturer <select name="manufacturer">
							<%
							if (tablares != null) {
								for (int i = 0; i < tablares.length; i++) {
							%>
							<option valve="<%=tablares[i][0]%>"><%=tablares[i][1]%></option>
							<%
								}
							}
							%>
					</select>
					</td>
				</tr>
				<tr>
					<td>Short Description <input name="desc" type="text"></td>
					<td>Wikipedia Link <input name="wiki" type="url"></td>
					<td><button type="submit">Add aircraft</button></td>
				</tr>
			</tbody>
		</table>
	</form>
	<h3>Manufacturer Entry</h3>
	<form action="./EntryUpload?entryType=manufacturerEntry" method="post"
		name="manufacturerEntry">
		<table>
			<tbody>
				<tr>
					<td>Name <input name="name" type="text"></td>
					<td>Country <select id="country" name="country">
							<optgroup label="Country">
							<option value="US">United States</option>
							<option value="RU">Russia</option>
							<option value="CN">China</option>
							<option value="FR">France</option>
							<option value="DE">Germany</option>
							<option value="GB">United Kingdom</option>
							<option value="IT">Italy</option>
							<option value="SE">Sweden</option>
							<option value="IS">Israel</option>
							<option value="KR">South Korea</option>
							<option value="IN">India</option>
							<option value="JP">Japan</option>
							<option value="TK">Turkey</option>
							</optgroup>
					</select></td>
					<td>Short Description <input name="desc" type="text"></td>
				</tr>
				<tr>
					<td>Wikipedia Link <input name="wiki" type="url"></td>
					<td><button type="submit">Add manufacturer</button></td>
				</tr>
			</tbody>
		</table>
	</form>
	<h3>Weapon Entry</h3>
	<form action="./EntryUpload?entryType=weaponEntry" method="post"
		name="weaponEntry">
		<table>
			<tbody>
				<tr>
					<td>Name <input name="name" type="text"></td>
					<td>Type <select name="type" id="Wtypes">
							<%
							if (tablares3 != null) {
								for (int i = 0; i < tablares3.length; i++) {
							%>
							<option valve="<%=tablares3[i][0]%>"><%=tablares3[i][1]%></option>
							<%
							}
							}
							%>
					</select></td>
					<td>Manufacturer <select name="manufacturer">
							<%
							if (tablares != null) {
								for (int i = 0; i < tablares.length; i++) {
							%>
							<option valve="<%=tablares[i][0]%>"><%=tablares[i][1]%></option>
							<%
							}
							}
							%>
					</select>
					</td>

				</tr>
				<tr>
					<td>Short Description <input name="desc" type="text"></td>
					<td>Wikipedia Link <input name="wiki" type="url"></td>
					<td><button type="submit">Add weapon</button></td>
				</tr>
			</tbody>
		</table>
	</form>
	<%
	} else {
	%>
	<footer>
		<h1 align="center">You must be logged in to make new entries</h1>
	</footer>
	<%
	}
	%>
</body>
</html>