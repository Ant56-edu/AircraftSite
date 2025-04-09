<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Session Checker</title>
</head>
<body>
<h1 align="center">Session Checker</h1>
<% 
    	String usuario="";
    	try {  
    		usuario=session.getAttribute("attributo2").toString();
    		String acceso = session.getAttribute("attributo1").toString();
     		if (!acceso.equals("1")) {
    %>
    			<p align="center">There is a problem: Your account has not been activated</p>
    			<p align="center"><a href="cerrarsesion.jsp">Salir</a></p>	
    <% 
     		}
    	} catch (Exception e) {
	%>
    		<p align="center">There is a problem: You are not authenticated</p>
    <%     			
    	}
    %>
</body>
</html>