<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %> 
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>JSTL - import</title>
	</head>
	<body>
		<!-- request 영역에 변수를 생성 -->
		<c:set var="requestVar" value="MustHave" scope="request" />
		<c:import url="/11JSTL/inc/OtherPage.jsp" var="contents">
			<c:param name="user_param1" value="JSP"/>
			<c:param name="user_param2" value="기본서"/>
		</c:import>
		
		<!-- 
			아래와 같이 이미지를 삽입할 때는 주로 상대경로를 사용하는 것이 좋다
			만약 절대경로를 사용해야한다면 하드코딩을 하는 것보다는 request 내장객체에서
			제공하는 메서드를 사용하는 것이 좋다. 웹프로그래밍은 웹서버에 배포하는 것이
			목적이므로 서버의 환경이 달라지면 경로도 수정되어야 하므로
			이를 최소화할 수 있도록 개발하는 것이 좋다.
			특히 JSTL에서 URl을 지정할 때 컨텍스트 루트 경로는 명시하지 않아도되므로
			일반적인 방식보다 작성에 유리한 점이 있다.
		 -->
		<div>
			<h4>이미지 삽입하기</h4>
			<h5>상대경로 지정</h5>
			<img src="../../images/Error.jpg" width="150" height="80"/>
			<h5>절대경로 지정</h5>
			<img src="/MustHaveJSP/images/Error.jpg" width="150" height="80"/>
			<h5>절대경로 지정(request 내장 객체 사용)</h5>
			<img src="<%=request.getContextPath()%>/images/Error.jpg" width="150" height="80"/>
		</div>
		
		<!-- 앞에서 선언한 import 태그의 var 속성의 변수를 통해
			문서를 출력한다. -->
		<h4>다른문서 삽입하기</h4>
		${ contents }
		
		<!-- http로 시작하는 외부 url도 import 태그를 통해 삽입할 수 있다. -->
		<h4>외부 자원 삽입하기</h4>
		<iframe src="../inc/GoldPage.jsp" style="width: 100%; height: 600px;"></iframe>
	</body>
</html>