<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//1. 회원인증 정보를 session 영역에서 삭제한다.
	session.removeAttribute("UserId");
	session.removeAttribute("UserName");
	
	//2. session영역에 모든 속성을 한꺼번에 삭제
	session.invalidate();
	
	//3. 페이지 이동
	response.sendRedirect("LoginForm.jsp");
%>
