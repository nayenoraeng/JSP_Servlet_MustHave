<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %> 
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>JSTL - Redirect</title>
	</head>
	<body>
	<!-- 
		태그가 실행되는 즉시 페이지가 이동된다. 새로운 페이지에 대한
		요청이므로 request 영역은 공유되지 않는다. 절대 경로 사용시
		컨텍스트 루트를 필요로 한다.
	 -->
	 <!-- request 영역에 변수를 저장 -->
		<c:set var="requestVar" value="MustHave" scope="request"/>
		<c:redirect url="/11JSTL/inc/OtherPage.jsp">
			<c:param name="user_param1" value="출판사"/>
			<c:param name="user_param2" value="골든래빗"/>
		</c:redirect>
	</body>
</html>