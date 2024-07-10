<%@page import="utils.JSFunction"%>
<%@page import="utils.CookieManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//전송된 폼값을 받는다
	String user_id = request.getParameter("user_id");
	String user_pw = request.getParameter("user_pw");
	/*
		체크박스의 경우 둘 이상의 값이라면 getParameterValue()를 통해
		폼값을 받아야하지만 항모깅 한개라면 getParameter()를 사용해서
		받을 수 있다.
	*/
	String save_check = request.getParameter("save_check");
	//아이디 패스워드 일치여부를 통해 로그인 성공, 실패를 판단한다.
	if("must".equals(user_id) && "1234".equals(user_pw)) { //사용자 인증
		//로그인에 성공하고
		if(save_check != null && save_check.equals("Y")){ //[아이디 저장하기] 체크 확인
			//아이디 저장하기에 체크한 경우라면 쿠키를 생성
			//로그인한 아이디를 유효기간 1일로 생성
			CookieManager.makeCookie(response, "loginId", user_id, 86400);
		}
		else
		{
			//체크하지 않은 경우 쿠키를 삭제한다.
			CookieManager.deleteCookie(response, "loginId");
		}
		//로그인 성공 알림창
		JSFunction.alertLocation("로그인에 성공했습니다." , "IdSaveMain.jsp", out);
	}
	else {
		JSFunction.alertBack("로그인에 실패했습니다." , out);
	}
%>

