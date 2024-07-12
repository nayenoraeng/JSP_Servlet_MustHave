<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="common.Person"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
	<html>
	<head>
	<meta charset="UTF-8">
	<title>표현언어(EL) - 컬렉션</title>
	</head>
	<body>
		<h2>List 컬렉션</h2>
		<%
			//List 컬렉션을 Object기반으로 생성한다.
			List<Object> aList = new ArrayList<Object>();
			//아래와 같이 타입매개변수를 생략해도 Object 기반의 컬렉션이 된다.
			//List aList2 = new ArrayList();
			
			//String 객체 추가
			aList.add("청해진");
			//Person 객체 추가
			aList.add(new Person ("장보고" , 28));
			/*
				EL은 영역에 저장된 값을 대상으로 하므로 List 컬렉션을
				page영역에 지정한다.
			*/
			pageContext.setAttribute("Ocean", aList);
		%>
		<ul>
			<!--  
				String객체가 출력된다 ArrayList는 배열의 특성을 가지고 있으므로
				인덱스로 접근할 수 있다.
			-->
			<li>0번째 요소 : ${ Ocean[0] }</li>
			<!--  Person 객체를 출력한다. -->
			<li>1번째 요소 : ${ Ocean[1].name }, ${ Ocean[1].age }</li>
			<li>2번째 요소 : ${ Ocean[2] } <!-- 출력되지 않음 --></li>
		</ul>
		
		<h2>Map 컬렉션</h2>
		<%
			Map<String, String> map = new HashMap<String, String>();
			//한글을 key로 설정하여 값을 저장한다.
			map.put("한글", "훈민정음");
			//영문을 key로 설정하여 값을 저장한다.
			map.put("Eng", "English");
			//page 영역에 저장한다.
			pageContext.setAttribute("King", map);
		%>
		<ul>
			<!-- key 값이 영문인 경우에는 아래 3가지 방법을 모두 사용할 수 있다.
				단 한글인 경우에는 .(닷)으로 출력할 수 없다. -->
			<li>영문 key : ${ King["Eng"] } , ${ King['Eng'] }, ${ King.Eng }</li>
			<!--  EL코드를 주석처리하려면 앞에 \(역슬래시)를 붙여준다. 단 코드가
				숨겨지는 것이 아니고 화면에 코드가 그대로 출력된다. -->
			<li>한글 key : ${ King["한글"] } , ${ King['한글'] }, \${ King.한글 }</li>
			<!--  \(주석)이 없으면 에러가 발생한다. -->
		</ul>
	</body>
</html>