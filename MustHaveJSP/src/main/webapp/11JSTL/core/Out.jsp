<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %> 
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>JSTL - Out</title>
	</head>
	<body>
		<c:set var="iTag">
			i 태그는 <i>기울임</i>을 표현합니다.
		</c:set>
		
		<!-- escapeXml 속성이 true  이면 HTML 태그가 그대로 출력된다.
			innerText()와 동일하다 -->
		<!-- escapeXml 속성은 true가 디폴트 값이므로 HTML 태그가 그대로 출력된다. -->
		<h4>기본 사용</h4>
		<c:out value="${ iTag }" />
		
		<!-- false가 되면 HTML 태그가 적용되어 출력됨 innerHTML() -->
		<h4>escapeXml 속성</h4>
		<c:out value="${ iTag }"  escapeXml="false"/>
		
		<!-- 최초 실행시에는 파라미터가 없는 상태이므로
			default 값이 출력된다. -->
		<h4>default 속성</h4>
		<c:out value="${ param.name }"  default="이름 없음"/>
		<!--  value 값이 null이면 default값이 실행됨. -->
		<c:out value=""  default="빈 문자열도 값입니다."/>
<%-- 		<c:out value="${ null }"  default="빈 문자열도 값입니다."/> --%>
	</body>
</html>