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
		<h1 align="center">Ant's Aircraft Database Aircraft Entry Viewer</h1>
		<%
		boolean userLogged = false;
		try { //AQUI VA EL CONTROL DE SESION
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
			String query = "select ARMAMENTS.name, ARMTYPES.type, ARMAMENTS.wikiLink, ARMAMENTS.desc, MANUFACTURER.name FROM MANUFACTURER JOIN MAN_HAS_ARMS ON (MANUFACTURER.manId = MAN_HAS_ARMS.manId) JOIN ARMAMENTS ON (MAN_HAS_ARMS.armId = ARMAMENTS.armId) JOIN ARMS_HAS_ARMTYPE ON (ARMAMENTS.armId = ARMS_HAS_ARMTYPE.armId) JOIN ARMTYPES ON (ARMS_HAS_ARMTYPE.armTypeId = ARMTYPES.armTypeId) WHERE ARMTYPES.type LIKE '%"
			+ filter + "%' AND ARMAMENTS.name LIKE '%" + entryName + "%' GROUP BY ARMAMENTS.name;";
			String[][] tablares = null;
			try {
				tablares = db.resConsultaSelectA3(query);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if (tablares != null) {

				resultado = "<br><table style=''>";
				for (int i = 0; i < tablares.length; i++) { //g es una variable tipo grupo que va recorriendo la lista
			resultado += "<tr>";
			resultado += "<td>" + tablares[i][0] + "</td>";
			resultado += "<td>" + tablares[i][1] + "</td>";
			resultado += "<td>" + tablares[i][2] + "</td>";
			resultado += "<td>" + tablares[i][3] + "</td>";
			resultado += "<td>" + tablares[i][4] + "</td>";
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