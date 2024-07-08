<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" buffer="1kb" autoFlush="true"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>page 지시어 = buffer, autoFlush 속성</title>
	</head>
	<body>
	<%
	/*
		buffer의 용량을 늘리거나, autoFlush를 true로 변경해야함
	*/
		for (int i =1; i<=100; i++){
			out.println("abcde12345");
		}
	/*
		JSP에서 buffer의 용량을 지정하는 경우는 거의 없다!
		단 JSP가 웹브라우저에 내용을 출력할 떄 버퍼를 사용하는 것을 인지
		하고 이를 통해 에러페이지 처리나 포워드 드으이 기능을 수행 할수 있게 된다.
	*/
	%>
	</body>
</html>