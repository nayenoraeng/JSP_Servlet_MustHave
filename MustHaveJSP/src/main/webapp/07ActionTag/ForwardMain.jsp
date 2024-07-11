<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//page 영역과 request영역에 속성을 저장
	pageContext.setAttribute("pAttr", "김유신");
	request.setAttribute("rAttr", "계백");
%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>액션태그 = forward</title>
	</head>
	<body>
		<h3>sendRedirect를 통한 페이지 이동</h3>
		<!-- 
			페이지 이도으이 경우 새로운 페이지에 대한 요청이 발생하게 되므로
			완전히 서로 다른 페이를 의미한다. 따라서 페이지영역, 리퀘스트 영역
			모두 공유되지 않는다.
		 -->
		<%
			/* response.sendRedirect("forwardSub.jsp"); */
		%>
		
		
	<!-- 
		포워드 된 페이지에서는 리퀘스트영역이 공유 됨 주소표시줄에는
		최초 요청한 페이지가 보여지지만 사용자는 포워드 된 페이지의
		내용을 보게 된다. 즉 하나의 요청을 2개의 페이지가
		공유하는 개념이다.
	 -->
		<h2>액션태그를 이용한 포워딩</h2> <!-- 화면에 출력 안됨 -->
		<jsp:forward page="/07ActionTag/ForwardSub.jsp" />
		
		<%
		/*
		액션태그를 사용하면 jsp코드 보다 훨씬 간결하게 코드를 표현할 수 있다.
		*/
			/* request.getRequestDispatcher("Forward.jsp").forward(request, response); */
		%>
	</body>
</html>