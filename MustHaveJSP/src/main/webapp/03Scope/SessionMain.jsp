<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/*
		session영역 : 클라이언트가 웹브라우저를 최초로 연 후 닫을 때까지 요청되는
	*/
	ArrayList<String> lists = new ArrayList<String>();
	lists.add("리스트");
	lists.add("컬렉션");
	//컬렉션을 통째로 session영역에 저장
	session.setAttribute("lists", lists);
%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>session 영역</title>
	</head>
	<body>
		<h2>페이지 이동 후 session 영역의 속성 읽기</h2>
		<!-- 공유되는지 확인하기 위한 링크 -->
		<a href="SessionLocation.jsp">SessionLocation.jsp 바로가기</a>
	</body>
</html>