<%@page import="controller.ServletSacola"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<sql:setDataSource var="bd" 
url="jdbc:mysql://localhost:3306/projetowasabi"
user="root" 
password="HackSql192022"/>

<sql:update dataSource="${bd}" var="res_cardapio">
UPDATE produtos_sacola SET ativo = 0 where ativo = 1
</sql:update>

<%ServletSacola.sacola.clear(); %>
<% session.invalidate(); %>
	
<% response.sendRedirect("login.jsp"); %>
</body>
</html>