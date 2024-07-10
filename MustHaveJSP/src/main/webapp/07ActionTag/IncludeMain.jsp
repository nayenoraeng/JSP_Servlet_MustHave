<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//외부파일의 경로를 변수로 저장한다.
	//아래의 표현식 사용가능 여부를 확인하기 위한 용도의 변수이다.
	String outerPath1 = "./inc/OuterPage1.jsp";
	String outerPath2 = "./inc/OuterPage2.jsp";
	
	//page영역과 request영역에 각 속성을 저장한다.
	//위의 파일에서 읽어올 수 있는지 확인하기 위한 용도의 속성
	pageContext.setAttribute("pAttr", "동명왕");
	request.setAttribute("rAttr", "온조왕");
%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>지시어와 액션태그 동작 방식 비교</title>
	</head>
	<body>
		<h2>지시어와 액션태그 동작 방식 비교</h2>
		
		<h3>지시어로 페이지 포함하기</h3>
		<!-- 
			지시어를 통한 인크루드의 경우 페이지의 경로는 문자열 형태로만
			기술할 수 있다. 표현식을 통해 변수를 사용할 수 엇ㅂ다.
		 -->
		<%@ include file="./inc/OuterPage1.jsp" %>
		<%--@ include file="<%= outerPath1OuterPage1 %>" --%> <!-- 에러 발생 -->
		
		<!-- 
			지시어를 통한 인크루드는 포함한 파일의 소스를 그대로 현재문서에
			포함시킨 후 컴파일을 진행한다. 따라서 하나의 페이지라 생각하면 된다.
			그러므로 newVar1은 정상적으로 출력된다.
		 -->
		<p>외부파일에 선언한 변수 : <%=newVar1%></p>
		
		<h3>액션 태그로 페이지 포함하기</h3>
		<!-- 
			액션태그를 이용한 인크루드는 문자열과 표현식 두가지 
			모두 사용할 수 있다.
		 -->
		<jsp:include page="./inc/OuterPage2.jsp" />
		<jsp:include page="<%=outerPath2%>" />
		
		<!-- 
			액션태그를 통한 인크루드는 포함한 파일 먼저 실행(컴파일)한 수
			실행된 결과를 해당문서에 포함시키낟. 따라서 외부파일에서
			선언한 변수를 현재 페이지에서 사용할 수 없게 된다.
		 -->
		<p>외부파일에 선언한 변수 : <%-- newVar2 --%></p> <!-- 에러 발생 -->
	</body>
</html>