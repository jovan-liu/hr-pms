<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<body>
<h2>Hello World - Index</h2>

<%=request.getContextPath()%>

<c:set var="appName" value="${pageContext.request.contextPath}"/>
<h3>${appName}</h3>
</body>
</html>
