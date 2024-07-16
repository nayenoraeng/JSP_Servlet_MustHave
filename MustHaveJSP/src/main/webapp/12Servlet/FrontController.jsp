<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>FrontController.jsp</title>
	</head>
	<body>
		<h3>한번의 매핑으로 여러가지 요청 처리하기</h3>
		${ resultValue } <!-- 서블릿에서 리퀘스트영역에 저장한 결과값 -->
		<ol>
			<li>URI : ${ uri }</li> <!-- 클라이언트가 요청한 전체 경로 -->
			<!-- 전체 경로에서 마지막 XXX.one -->
			<li>요청명 : ${ commandStr }</li>
		</ol>
		<ul>
			<li><a href="../12Servlet/regist.one">회원가입</a></li>
			<li><a href="../12Servlet/login.one">로그인</a></li>
			<li><a href="../12Servlet/freeboard.one">자유게시판</a></li>
		</ul>
	</body>
</html>