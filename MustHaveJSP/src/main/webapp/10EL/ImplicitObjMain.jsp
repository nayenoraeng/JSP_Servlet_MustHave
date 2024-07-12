<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	pageContext.setAttribute("scopeValue", "페이지 영역");
	request.setAttribute("scopeValue", "리퀘스트 영역");
	session.setAttribute("scopeValue", "세션 영역");
	application.setAttribute("scopeValue", "애플리케이션 영역");
%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>표현 언어(EL) 내장 객체</title>
	</head>
	<body>
		<h2>ImplicitObjMain 페이지</h2>
		<!-- 맨밑줄 주석처리 해야 뜸. -->
		<h3>각 영역의 속성을 JSP 내장 객체를 통해 읽기</h3> 
		<ul>
			<li>페이지 영역 : <%= pageContext.getAttribute("scopeValue") %></li>
			<li>리퀘스트 영역 : <%= request.getAttribute("scopeValue") %></li>
			<li>세션 영역 : <%= session.getAttribute("scopeValue") %></li>
			<li>애플리케이션 영역 : <%= application.getAttribute("scopeValue") %></li>
		</ul>
		
		<h3>각 영역에 저장된 속성 읽기(EL)사용</h3>
		<ul>
			<li>페이지 영역 : ${ pageScope.scopeValue }</li>
			<li>리퀘스트 영역 : ${ requestScope.scopeValue }</li>
			<li>세션 영역 : ${ sessionScope.scopeValue }</li>
			<li>애플리케이션 영역 : ${ applicationScope.scopeValue }</li>
		</ul>
		
		<!-- 영역명 지정없이 속성을 읽을 때는 가장 좁은 영역을 우선으로 출력
		page영역 출력함. -->
		<h3>영역 지정 없이 속성 읽기</h3>
		<ul>
			<li>${ scopeValue }</li> <!-- 밑줄을 주석하면 페이지영역으로나옴 -->
		</ul>
		
		<jsp:forward page="ImplicitForwardResult.jsp" />
	</body>
</html>