<%@ page import="common.Person" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setAttribute("requestString", "request 영역의 문자열");
	request.setAttribute("requestPerson", new Person("안중근", 31));
%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>request 영역</title>
	</head>
	<body>
		<h2>request 영역의 속성값 삭제하기</h2>
		<%
		//request영역에 저장되어있으므로 정상적으로 삭제된다.
			request.removeAttribute("requestString");
		//없는 속성이므로 삭제되지 않는다. 또한 에러도 발생하지 않는다.
			request.removeAttribute("requestInteger");
		%>
		<h2>request 영역의 속성값 읽기</h2>
		<%
			Person rPerson = (Person)(request.getAttribute("requestPerson"));
		%>
		<ul>
			<li>String 객체 : <%= request.getAttribute("requestString") %></li>
			<li>Person 객체 : <%= rPerson.getName() %>, <%= rPerson.getAge() %></li>
		</ul>
		
		<h2>포워드된 페이지에서 request 영역 속성값 읽기</h2>
		<%
		request.getRequestDispatcher("RequestForward.jsp?paramHan=한글&paramEng=English")
		.forward(request, response); 
		%>
	</body>
</html>