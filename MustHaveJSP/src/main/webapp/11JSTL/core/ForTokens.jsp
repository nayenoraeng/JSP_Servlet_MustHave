<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %> 
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>JSTL forTokens</title>
	</head>
	<body>
		<%
		//콤마로 구분된 문자열을 준비 배열X
			String rgba = "Red,Green,Blue,Black";
		%>
		<h4>JSTL의 forTokens태그 사용</h4>
		<c:forTokens items="<%=rgba %>" delims="," var="color">
			<span style="color:${color};">${color}</span> <br/>
		</c:forTokens>
		
		<h4>StringTokenizer 사용</h4>
		
		<h4>String 클래스의 split() 메서드 사용</h4>
	</body>
</html>