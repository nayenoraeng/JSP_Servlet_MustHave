<%@page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
/*
	로그인 체크를 위한 파일로 섹션 영역에 UserId라는 속성값이 없으면
	경고창을 띄운후 로그인 페이지로 이동한다.
	로그인에
*/
	if(session.getAttribute("UserId") == null) {
		JSFunction.alertLocation("로그인 후 이용해주십시오", 
				"../06Session/LoginForm.jsp", out);
		return;
	}
%>