<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>표현언어(EL) -폼값 처리</title>
	</head>
	<body>
	<!-- 
		폼값으로 전송된 파라미터를 받을때 EL의 내장객체를 사용할 수 있다.
		param : 단일값 받을 떄 사용
		paramValues : 2개 이상의 값을 받을 때 사용. 이경우 배열을 통해
			값을 구분해야한다.
	 -->
		<h3>EL로 폼값 받기</h3>
		<ul>
			<li>이름 : ${ param.name }</li>
			<li>성별 : ${ param.gender }</li>
			<li>학력 : ${ param.grade }</li>
			<!-- 
				check
			 -->
			<li>관심사항 : ${ paramValues.inter[0] }
				${ paramValues.inter[1] }
				${ paramValues.inter[2] }
				${ paramValues.inter[3] }
			</li>
		</ul>
		
<%-- 		<h3>JSP 내장객체를 통해 폼값 받기</h3>
		<%
			String name = request.getParameter("name");
			String gender = request.getParameter("gender");
			String grade = request.getParameter("grade");
			String [] interArr = request.getParameterValues("inter");
			
			out.println("이름 : " + name + "<br/>");
			out.println("성별 : " + gender + "<br/>");
			out.println("학력 : " + grade + "<br/>");
			out.println("관심사항1 : " + interArr[0] + "<br/>");
			out.println("관심사항2 : " + interArr[1] + "<br/>");
			/*
				JSP내장객체를 통해 폼값을 받은 후 출력하는 경우
				선택된 값이 1개밖에 없다면 예외가 발생하게 된다.
			*/
			
		%> --%>
	</body>
</html>