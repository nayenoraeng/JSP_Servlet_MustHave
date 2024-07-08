<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>내장객체 - request</title>
	</head>
	<body>
	<%
		//post 방식으로 전송된 한글이 깨지는 현상을 처리한다.
		request.setCharacterEncoding("UTF-8");
		String id = request.getParameter("id");
		String sex = request.getParameter("sex");
		String[] favo = request.getParameterValues("favo");
		String favoStr = "";
		if (favo != null) {
			for (int i = 0; i < favo.length; i++) {
				favoStr += favo[i] + " ";
			}
		}
		String intro = request.getParameter("intro").replace("\r\n", "<br/>");
	%>
	<ul>
		<li> 아이디 : <%= id %></li>
		<li> 성별 : <%= sex %></li>
		<li> 관심사항 : <%= favoStr %></li>
		<li> 자기소개 : <%= intro %></li>
	</ul>
	</body>
</html>