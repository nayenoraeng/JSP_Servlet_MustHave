<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>내장 객체 - application</title>
	</head>
	<body>
		<h2>web.xml에 설정한 내용 읽어오기</h2>
		<!-- web.xml에 <context-param> 설정한 값을 내장객체를 통해 읽어올 수 있다. -->
		초기화 매개변수 : <%= application.getInitParameter("INIT_PARAM") %>
		
		<!-- 
			이클립스에서는 우리가 직접 작성한 파일을 실행하지 않고 .metadata
			디렉토리 하위에 프로젝트와 동일한 톰캣 환경을 만들어서
		 -->
		<h2>선언부에서 물리적 경로 얻어오기</h2>
		application 내장 객체 : <%= application.getRealPath("/02ImplicitObject") %>
		
		<h2>선언부에서 application 내장 객체 사용하기</h2>
		<!-- 
			선언부에서는 내장객체를 바로 사용하는 것은 불가능하다
			내장객체는 _jspService() 메서드 내에서 생성된 지역변수이므로
			더 넓은 지역인 선언부에서 사용하려면 매개변수로 전달 받아야 한다.
		 -->
		<%!
		public String useImplicitObjext() {
			/*
				방법 1: getServletContext() 메서드를 통해
			*/
			return this.getServletContext().getRealPath("/02ImplicitObject");
		}
		public String useImplicitObjext(ServletContext app) {
			return app.getRealPath("/02ImplicitObject");
		}
		%>
		<ul>
			<li>this 사용 : <%= useImplicitObjext() %></li>
			<li>내장객체를 인수로 전달 : <%= useImplicitObjext(application) %></li>
		</ul>
	</body>
</html>