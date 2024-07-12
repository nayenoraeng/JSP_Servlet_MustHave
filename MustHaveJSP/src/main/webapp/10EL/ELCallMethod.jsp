<%@page import="el.MyELClass"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="mytag" uri="/WEB-INF/MyTagLib.tld" %>
<%
	MyELClass myClass = new MyELClass();
	pageContext.setAttribute("myClass", myClass);
%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>표현언어(EL) - 메서드 호출</title>
	</head>
	<body>
		<!-- 일반적인 메서드 호출 -->
		<h3>영역에 저장 후 메서드 호출하기</h3>
		970218-3000000 => ${ myClass.getGender("970218-3000000") } <br/>
		000225-2000000 => ${ myClass.getGender("000225-2000000") } <br/>
		
		<!-- 정적메서드의 경우 객체 생성 없이 클래스 명으로 직접 호출할 수 있음 -->
		<h3>클래스 명을 통해 정적메서드 호출하기</h3>
		${ MyELClass.showGugudan(7) }
		
		<h3> JSP 코드를 통해 메서드 호출하기</h3>
		<%
			out.print(MyELClass.isNumber("백20") ? "숫자임" : "숫자아님");
			out.println("<br/>");
			
			boolean isNumstr = MyELClass.isNumber("120");
			if (isNumstr==true)
				out.print("숫자입니다.");
			else
				out.print("숫자가 아닙니다.");
		%>
		
		<h3> TLD 파일 등록후 정적 메서드 호출하기</h3>
		<ul>
			<li>mytag:isNumber("100") => ${ mytag:isNumber("100") }</li>
			<li>mytag:isNumber("이백") => ${ mytag:isNumber("이백") }</li>
		</ul>
	</body>
</html>