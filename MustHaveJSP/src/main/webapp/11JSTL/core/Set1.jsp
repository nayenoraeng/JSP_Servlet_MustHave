<%@page import="common.Person"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- core 태그를 위한 선언 -->
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>JSTL - set 1</title>
	</head>
	<body>
	<!-- 
		set 태그 : 변수를 선언할 떄 사용한다. jsp 의 setAttrobute()와 동일한 기능
		4가지 영역에 새로운 속성을 추가
		var : 속성명
		scope : 4가지 영역을 지정
		target : set 태그를 통해 생성된 자바빈즈의 이름을 지정함
		property : target 으로 지정한 자바빈즈의 멤버변수값을 지정
	 -->
	 <!-- 일반값을 사용 -->
		<c:set var="directVar" value="100" />
		<!-- EL 사용 -->
		<c:set var="elVar" value="${ directVar mod 5 }" />
		<!-- JSP 표현식 사용 -->
		<c:set var="expVar" value="<%= new Date() %>" />
		<!-- value 속성을 이용하여 -->
		<c:set var="betweenVar">변수값 요렇게 설정</c:set>
		
		<!--  속성명이 중복되지 않는다면 영역을 표시하는 내장객체를 생략할 수 있다. -->
		<h4>EL을 이용해 변수 출력</h4>
		<ul>
			<li>directVar : ${ pageScope.directVar } </li>
			<li>elVar : ${ elVar } </li>
			<li>expVar : ${ expVar } </li>
			<li>betweenVar : ${ betweenVar } </li>
		</ul>
		
		<!-- 클래스의 생성자를 통해 객체를 생성한 후 request 영역에 저장한다. -->
		<h4>자바빈즈 생성 1 - 생성자 사용</h4>
		<!-- 
			JSTL은 JSP 코드이므로 value 속성에 기술할 때 객체를 생성하기 위한
			더블쿼테이션이 겹쳐지는 경우가 발생하게 된다. 이때는 value 를
			싱글쿼테이션으로 감싸서 겹쳐지지 않게 처리해야한다.
		 -->
		<c:set var="personVar1" value='<%= new Person("박문수", 50) %>'
				scope="request" />
		<ul>
			<!-- request 영역에 저장된 자바빈즈의 getter()를 통해 멤버변수의
				값을 출력한다.  -->
			<li>이름 : ${ requestScope.personVar1.name }</li>
			<li>나이 : ${ personVar1.age }</li>
		</ul>
		
		<!-- 빈객체를 생성한 후 target, property 를 통해 멤버변수의 값을
			지정한다. -->
		<h4>자바빈즈 생성 2 - target, property 사용</h4>
		<!-- 자바빈즈 생성 -->
		<c:set var="personVar2" value="<%= new Person() %>" scope="request" />
		<!-- 자바빈즈에 정의한 setter()를 통해 초기화 한다, 값을 나중에 설정하려면
			target, property 속성을 사용한다. target 에는 변수를, 
			property 에는 멤버변수명을 지정한다. key 값 -->
		<c:set target= "${ personVar2 }"  property="name" value="정약용"/>
		<c:set target= "${ personVar2 }"  property="age" value="60"/>
		<ul>
			<li>이름 : ${ personVar2.name }</li>
			<li>나이 : ${ requestScope.personVar2.age }</li>
		</ul>
	</body>
</html>