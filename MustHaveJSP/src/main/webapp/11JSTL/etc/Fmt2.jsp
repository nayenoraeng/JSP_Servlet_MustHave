<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!-- 국제화태그 사용을 위한 선언 -->
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>JSTL - fmt 2</title>
	</head>
	<body>
		<c:set var="today" value="<%= new java.util.Date() %>"/>
		
		<h4>날짜 포맷</h4>
		full : <fmt:formatDate value="${ today }" type="date" dateStyle="full"/>
		<br/>
		short : <fmt:formatDate value="${ today }" type="date" dateStyle="short"/>
		<br/>
		long : <fmt:formatDate value="${ today }" type="date" dateStyle="long"/>
		<br/>
		default : <fmt:formatDate value="${ today }" type="date" dateStyle="default"/>
		
		<h4>시간 포맷</h4>
		full : <fmt:formatDate value="${ today }" type="time" timeStyle="full"/>
		<br/>
		short : <fmt:formatDate value="${ today }" type="time" timeStyle="short"/>
		<br/>
		long : <fmt:formatDate value="${ today }" type="time" timeStyle="long"/>
		<br/>
		default : <fmt:formatDate value="${ today }" type="time" timeStyle="default"/>
		
		<h4>날짜/시간 표시</h4>
		<fmt:formatDate value="${ today }" type="both" dateStyle="full"
				timeStyle="full"/> <br/>
		<fmt:formatDate value="${ today }" type="both" 
			pattern="yyyy-MM-dd hh:mm:ss"/>
		
		<h4>타임존 설정</h4>
		<fmt:timeZone value="GMT">
			<fmt:formatDate value="${ today }" type="both" dateStyle="full"
				timeStyle="full"/>
		</fmt:timeZone>
		<br/>
		<fmt:timeZone value="America/Chicago">
			<fmt:formatDate value="${ today }" type="both" dateStyle="full"
				timeStyle="full"/>
		</fmt:timeZone>
		<br/>
		<!-- 표준시에 9를 더하면 KST(대한민국 표준시)가 된다. Asia/Seoul -->
		<fmt:timeZone value="GMT+9">
			<fmt:formatDate value="${ today }" type="both" dateStyle="full"
				timeStyle="full"/>
		</fmt:timeZone>
		
		<h4>timezone에 사용할 수 있는 문자열 구하기</h4>
		<c:forEach var="ids" items="<%= java.util.TimeZone.getAvailableIDs() %>">
			${ ids } <br/>
		</c:forEach>
	</body>
</html>