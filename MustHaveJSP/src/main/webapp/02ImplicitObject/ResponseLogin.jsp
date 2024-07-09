<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>내장객체 - response</title>
	</head>
	<body>
	<%
	//request 내장객체를 통해 전송된 폼값을 받는다. name으로 보내는
	String id = request.getParameter("user_id");
	String pwd = request.getParameter("user_pwd");
	//문자열을 통한 단순비교로 로그인 정보를 확인한다.
	//만약 정보가 일치한다면 Welcome페이지로 이동한다.
	if (id.equalsIgnoreCase("must") && pwd.equalsIgnoreCase("1234")){
		//JS의 location.href와 기능적으로 완전한 동일한 메서드로 인수로 주어진
		//경로로 이동하게 된다.
		response.sendRedirect("ResponseWelcome.jsp");
	}
	else
	{
		request.getRequestDispatcher("ResponseMain.jsp?loginErr=1").forward(request, response);
	}
	%>
	</body>
</html>