<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
	<html>
	<head>
	<meta charset="UTF-8">
	<title>표현 언어(EL) 내장 객체</title>
	</head>
	<body>
		<h2>ImplicitObjMain 페이지</h2>
		<!-- 포워드 되면 page영역은 소멸되고 request영역은 공유됨
		아래에서는 페이지 영역이 출력되지 않는다. -->
		<h3>각 영역에 저장된 속성 읽기</h3>
		<ul>
			<li>페이지 영역 : ${ pageScope.scopeValue }</li>
			<li>리퀘스트 영역 : ${ requestScope.scopeValue }</li>
			<li>세션 영역 : ${ sessionScope.scopeValue }</li>
			<li>애플리케이션 영역 : ${ applicationScope.scopeValue }</li>
		</ul>
		<!-- 표현식으로 할경우에는 null만 뜬다 -->
		<%= pageContext.getAttribute("scopeValue") %>
		
		<h3>영역 지정 없이 속성 읽기</h3>
		<ul>
			<li>${ scopeValue }</li>
		</ul>
	</body>
</html>