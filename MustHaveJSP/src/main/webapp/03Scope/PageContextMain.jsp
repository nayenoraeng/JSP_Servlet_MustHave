<%@page import="common.Person"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  //속성 저장
	/*
		page영역
	*/
	//pageContext를 이용해 page영역에 정수형 데이터 속성값을 저장
	pageContext.setAttribute("pageInteger", 1000);
	pageContext.setAttribute("pageString", "페이지 영역의 문자열");
	pageContext.setAttribute("pagePerson", new Person("한석봉" , 99));
%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>page 영역</title>
	</head>
	<body>
		<h2>page 영역의 속성값 읽기</h2>
		<%
			//정수 데이터를 읽을 때는 Integer클래스를 통해 자동 언박싱한다.
			int pInteger = (Integer)(pageContext.getAttribute("pageInteger"));
			//문자열 데이터는 toString()을 통해 문자열 형태로 반환한다.
			String pString = pageContext.getAttribute("pageString").toString();
			//Person과 같이 개발자가 정의한 클래스는 원래의 타입으로 형변환한다.
			Person pPerson = (Person)(pageContext.getAttribute("pagePerson"));
		%>
		<ul>
			<!-- JAVA의 기본클래스인 경우 별도의 처리없이 즉시 내용을 출력 할 수 있다. -->
			<li>Integer 객체 : <%= pInteger %></li>
			<li>String 객체 : <%= pString %></li>
			<li>Person 객체 : <%= pPerson.getName() %>, <%= pPerson.getAge() %></li>
		</ul>
		
		<!-- 
			지시어를 통한 include는 모함시킬 페이지의 원본소스를 그대로 현재 문서에
			포함시킨 후 컴파일을 진행한다. 따라서 동일한 페이지로 취급되므로
			page영역이 그대로 공유된다.
			즉, include된 페이지의 내용은 정상적으로 출력된다.
		 -->
		<h2>include된 파일에서 page영역 읽어오기</h2>
		<%@ include file ="PageInclude.jsp" %>
		
		<!-- 
			페이지 이동은	
		 -->
		<h2>페이지 이동 후 page 영역 읽어오기</h2>
		<a href="PageLocation.jsp">PageLocation.jsp 바로가기</a>
	</body>
</html>