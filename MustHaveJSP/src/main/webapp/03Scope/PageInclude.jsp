<%@page import="common.Person"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>page 영역</title>
	</head>
	<body>
		<h4>Include 페이지</h4>
		<% //중복처리 되지 않기 위해 2를 첨가. _JspService() 안에 있기 때문
		int pInteger2 = (Integer)(pageContext.getAttribute("pageInteger"));
		//String pString2 = pageContext.getAttribute("pageString").toString();
		Person pPerson2 = (Person)(pageContext.getAttribute("pagePerson"));
		%>
		<ul>
		    <li>Integer 객체 : <%= pInteger2 %></li>
		    <li>String 객체 : <%= pageContext.getAttribute("pageString") %></li>
		    <li>Person 객체 : <%= pPerson2.getName() %>, <%= pPerson2.getAge() %></li>
		</ul>
		
	</body>
</html>