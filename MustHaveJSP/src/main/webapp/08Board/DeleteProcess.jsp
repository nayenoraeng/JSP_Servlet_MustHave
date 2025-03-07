<%@page import="model1.board.BoardDAO"%>
<%@page import="model1.board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- 작성자 본인만 삭제할 수 있으므로 기본적으로 로그인 체크를 해야한다. -->
<%@ include file="./IsLoggedIn.jsp" %>
<%
	//폼값(일련번호) 받기
	String num = request.getParameter("num");

	BoardDTO dto = new BoardDTO();
	BoardDAO dao = new BoardDAO(application);
	//본인확인을 위해 기존 게시물을 인출한다.
	dto = dao.SelectView(num);
	
	/*
		세션영역에 저장된 회원정보를 얻어온 후 String으로 변환
		ㅇ여역에는 모든 값(객체)을 저장할 수 있도록  Object타입을
		사용하므로 사용시 기존의 값으로 형변환 해야한다.
	*/
	String sessionId = session.getAttribute("UserId").toString();
	
	int delResult = 0;
	
	//세션의 아이디와 게시물의 아이디가 일치하면 작성자 본인임
	if (sessionId.equals(dto.getId())) {
		dto.setNum(num);
		delResult = dao.deletePost(dto);
		//자원해제
		dao.close();
		
		if(delResult == 1) {
			/*
				게시물이 삭제되면 내용보기는 의미 없으므로 목록(리스트)으로
				이동하면 된다.
			*/
			JSFunction.alertLocation("삭제되었습니다", "List.jsp", out);
		}
		else {
			/*
				작성자 본인이 아니면 삭제할 수 없다.
			*/
			JSFunction.alertBack("삭제에 실패하였습니다.", out);
		}
	}
	else {
		JSFunction.alertBack("본인만 삭제할 수 있습니다.", out);
		return;
	}
%>