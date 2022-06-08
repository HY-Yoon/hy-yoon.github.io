<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/main</title>
</head>
<body>
<h1>영화정보</h1>
<ul>
	<c:forEach var="vo" items="${requestScope.list }">
		<li>${vo.title }<a href="${pageContext.request.contextPath }/detail?mnum=${vo.mnum }">상세보기</a></li>
	</c:forEach>
</ul>
</body>
</html>