<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %> 
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>JSTL forEach 2</title>
	</head>
	<body>
		<h4>향상 for문 형태의 forEach 태그</h4>
		<%
			//루프에서 순회할 String 배열을 선언
			String [] rgba = { "Red", "Green" , "Blue", "Black"};
		%>
		<!-- 원소의 갯수만큼 반복하여 span태그가 4번 출력된다.  -->
		<!-- java의 향상된 for (int var : items) -->
		<c:forEach items="<%= rgba %>" var="c" >
			<span style="color:${c};">${c}</span>
		</c:forEach>
		
		<h4>varStatus 속성 살펴보기</h4>
		<table border="1">
			<c:forEach items="<%= rgba %>" var="c"  varStatus="loop">
				<tr>
					<td>count : ${ loop.count }</td>
					<td>index : ${ loop.index }</td>
					<td>current : ${ loop.current }</td>
					<td>first : ${ loop.first }</td>
					<td>last : ${ loop.last }</td>
				</tr>
			</c:forEach>
		</table>
	</body>
</html>