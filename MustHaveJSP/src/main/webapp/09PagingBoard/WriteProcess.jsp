<%@page import="model1.board.BoardDAO"%>
<%@page import="model1.board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./IsLoggedIn.jsp" %>
<%
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	BoardDTO dto = new BoardDTO();
	dto.setTitle(title);
	dto.setContent(content);
	dto.setId(session.getAttribute("UserId").toString());
	
	//디비연결을 위해 DAO객체 생성.
	BoardDAO dao = new BoardDAO(application);
	//입력값이 저장된 디티오 객체를 인수를 전달하여 인서트 쿼리문을 실행한다.
	int iResult = dao.insertWrite(dto);
	//더미데이터 100개 만들기 안쓸때 주석
	//int iResult = 0;
// 	for (int i=1; i<=100; i++) {
// 		dto.setTitle(title + "-" + i);
// 		iResult = dao.insertWrite(dto);
// 	}
	
	//자원해제
	dao.close();
	
	if(iResult == 1) {
		//입력에 성공한 경우 리스트로 이동하여 성공한 게시물을 확인한다.
		response.sendRedirect("List.jsp");
	} else {
		//실패하였다면 재입력을 위해 글쓰기 페이지로 다시 돌아간다.
		JSFunction.alertBack("글쓰기에 실패하였습니다.", out);
	}
%>