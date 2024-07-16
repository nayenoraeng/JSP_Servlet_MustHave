package servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/*
	서블릿 클래스를 만들기 위한 절차
	1. HttpServlet 클래스를 상속한다
	2. 클라이언트의 요청을 받아 처리하기 위한 doGet() 혹은 doPost()메서드를
		오버라이딩한다
	3. 서블릿에 필수적인 패키지 임포트와 예외처리는 자동완성된다.
	4. request 내장객채 - 매개변수 req // response - resp
*/

public class HelloServlet extends HttpServlet {
	
	//직렬화된 클래스의 버전 관리에 사용되는 식별자
	private static final long serialVersionUID = 1L; //없으면 경고 뜸
	
	//doGet만 치고 자동완성 누르면 아래 메서드가 뜸.
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
		throws ServletException, IOException 
	{
		//리퀘스트 영역에 속성값을 저장한다
		req.setAttribute("message", "Hello Servlet..!!");
		//view에 해당하는 jsp페이지로 포워드 한다.
		req.getRequestDispatcher("/12Servlet/HelloServlet.jsp").forward(req, resp);
		/*리퀘스트 영역은 포워드 된 페이지 까지 공유되므로 서블리셍서 저장한 속성값은
		 	JSP 에서 사용할 수 있다 */
	}
}
