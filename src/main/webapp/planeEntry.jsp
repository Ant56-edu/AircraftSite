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
		<h1 align="center">Ant's Aircraft Database Entry Viewer</h1>
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
			class="headerLink" href="index.jsp">Go back to Home Page</a>
		<%
}
%>
		<a class="headerLink" href="editor.jsp">Create (or edit) entries</a>
		<%
		beanDB db = new beanDB();
		boolean okdb = false;
		String resultado = "";

		try {
			db.conectarBD();
			okdb = true;
		} catch (Exception e) {
			okdb = false;
			e.printStackTrace();
		}
		if (okdb) {
			String filter = request.getParameter("filter");
			String entryName = request.getParameter("entryName");
			String query = "select MODEL.name, PLANETYPES.type, MODEL.countryId, MODEL.wikiLink, MODEL.shortDesc, MANUFACTURER.name 'Manufacturer' FROM PLANETYPES JOIN MODEL ON (PLANETYPES.planeTypeId = MODEL.planeTypeId) JOIN MANUFACTURER ON (MANUFACTURER.manId = MODEL.manId) WHERE PLANETYPES.type LIKE '%"
			+ filter + "%' AND MODEL.name LIKE '%" + entryName + "%' GROUP BY MODEL.name;";
			String[][] tablares = null;
			try {
				tablares = db.resConsultaSelectA3(query);
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
			if (tablares != null) {

				resultado = "<br><table style=''>";
				for (int i = 0; i < tablares.length; i++) { 
			resultado += "<tr>";
			resultado += "<td>" + tablares[i][0] + "</td>";
			resultado += "<td>" + tablares[i][1] + "</td>";
			resultado += "<td>" + tablares[i][2] + "</td>";
			resultado += "<td>" + tablares[i][3] + "</td>";
			resultado += "<td>" + tablares[i][4] + "</td>";
			resultado += "<td>" + tablares[i][5] + "</td>";
			resultado += "</tr>";
				}
				resultado += "</table>";

			}
			db.desconectarBD();
		} else {
			resultado = "<div style='color: darkred; font-weight: bold;'>ERROR: No se pudo conectar con la BBDD</div>";
		}
		%>
	</header>

	<%=resultado%>


</body>
</html>