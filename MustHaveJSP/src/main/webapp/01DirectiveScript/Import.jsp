<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>page 지시어 - import 속성</title>
	</head>
	<body>
		<%
		Date today =new Date(); //외부클래스 생성
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String todayStr = dateFormat.format(today);
		out.print("오늘 날짜 :" + todayStr); //오늘 날짜를 웹브라우저에 출력
		%>
	</body>
</html>