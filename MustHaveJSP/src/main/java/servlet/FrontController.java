package servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/*
	어노테이션을 통한 요청명 매핑으로 *을 통해 여러 요청명을 한번에 매핑한다.
	즉, .one으로 끝나는 모든 요청에 대해 매핑 처리함.
*/
//밑 one은 내가 하고 싶은 거 아무거나 해도 됨
@WebServlet("*.one")
public class FrontController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	/*
		get방식으로 들어오는 요청을 처리하기 위해 doGet메서드를 오버라이딩
		서블릿이 이메서드가 정의되지 않았다면 405에러가 발생하게된다
		해당방식의 요청을 처리할 수 없다는 의미이다.
	*/

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException
	{
		/*
			리퀘스트내장객체를 통해 현재 요청된 url을 얻어온다. 즉 웹브라우저의
			주소표시줄에 있는 전체 경로명에서 host (localhost) 를 제외한 나머지
			경로를 얻어올 수 있다
		*/
		String uri = req.getRequestURI();
		//url 마지막 /의 인덱스를 얻어온다.
		int lastSlash = uri.lastIndexOf("/");
		//앞에서 얻어온 index를 통해 url을 자른다. 즉 마지막에 있는 요청만 남김
		String commandStr = uri.substring(lastSlash);
		
		/*
			마지막 요청명을 통해 요청을 판단한 후 해당 요청을 처리할 메서드를
			호출한다 이때 사용자의 요청정보를 담은 리퀘스트 객체로
		*/
		if(commandStr.equals("/regist.one"))
			registFunc(req);
		else if(commandStr.equals("/login.one"))
			loginFunc(req);
		else if(commandStr.equals("/freeboard.one"))
			freeboardFunc(req);
		
		//요청명에 관련된 변수들을 리퀘스트 영역에 저장
		req.setAttribute("uri", uri);
		req.setAttribute("commandStr", commandStr);
		//view로 포워드한다.
		req.getRequestDispatcher("/12Servlet/FrontController.jsp").forward(req, resp);
	}
	
	//페이지 별 처리 메서드. 각 페이지에 출력할 데이터를 리퀘스트 영역에 저장
	void registFunc(HttpServletRequest req) {
		req.setAttribute("resultValue", "<h4>회원가입</h4>");
	}
	
	void loginFunc(HttpServletRequest req) {
		req.setAttribute("resultValue", "<h4>로그인</h4>");
	}
	
	void freeboardFunc(HttpServletRequest req) {
		req.setAttribute("resultValue", "<h4>자유게시판</h4>");
	}
	
	/*
		이렇게 하면 요청명마다 매번 서블릿을 하나씩 만들지 않아도 되니 편리
		서블릿 클래스의 내용이 방대해질 수 있으므로 카테고리 별로 구분하여
		작성하는 것이 좋다.
	*/
}
