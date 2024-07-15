<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="common.Person"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>JSTL - set 2</title>
	</head>
	<body>
		<h4>List 컬렉션 이용하기</h4>
		<%
			//Person 객체를 저장할 수 있는 List계열의 컬렉션을 생성한다.
			ArrayList<Person> pList = new ArrayList<Person>();
			pList.add(new Person("성삼문", 55));
			pList.add(new Person("박팽년", 60));
 		%>
 		<!--  List컬렉션을 request영역에 저장한다. -->
 		<c:set var="personList" value="<%= pList %>" scope="request" />
 		<!--  2개의 객체 중 0번 인덱스를 출력한다. List 이므로 인덱스로 접근할
 			수 있다. 차후 forEach 태그를 사용하면 2개의 객체 전부를 반복해서 
 			출력할 수 있다. -->
 		<ul>
 			<li> 이름 : ${ requestScope.personList[0].name }</li>
 			<!--  다른 영역에 똑같은 이름으로 저장한 속성이 없으므로
 				requestScope는 생략할 수 있다. -->
 			<li> 나이 : ${ personList[0].age }</li>
 		</ul>
 		
 		<h4>Map 컬렉션 이용하기</h4>
		<%
			/*
				Map의 key String 타입, Value는 Person타입으로 정의한 후 2개의
				Person 객체를 저장한다.
			*/
			Map<String, Person> pMap  = new HashMap<String, Person>();
			pMap.put("personArgs1", new Person("하위지", 65));
			pMap.put("personArgs2", new Person("이개", 67));
 		%>
 		<c:set var="personMap" value="<%= pMap %>" scope="request" />
 		<ul>
 			<li> 이름 : ${ requestScope.personMap.personArgs2.name }</li>
 			<li> 나이 : ${ personMap.personArgs2.age }</li>
 		</ul>
	</body>
</html>