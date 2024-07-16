package servlet;

import java.io.IOException;

import jakarta.annotation.PostConstruct;
import jakarta.annotation.PreDestroy;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//어노테이션을 통한 매핑처리
@WebServlet("/12Servlet/LifeCycle.do")
public class LifeCycle extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	/*
		서블릿 수명주기에서 최초로 호출되는 메서드로 어노테이션을 통해
		생성한다. 따라서 메서드명은 개발자가 결정하면 된다. init()메서드가
		호출되기 전 wjscjflfmf dnlgo wnfh tkdydgksek.
	*/
	@PostConstruct
	public void myPostConstruct () {
		System.out.println("myPostConstruct() 호출");
	}
	
	/*
		서블릿 객체 생성 후 딱 한번만 호출되는 메서드
	*/
	@Override
	public void init() throws ServletException
	{
		System.out.println("init() 호출");
	}
	
	/*
		클라이언트의 요청을 분석하기 위해 호출된다
	*/
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException
	{
		System.out.println("service() 호출");
		/*
			요청방식을 분석한 후 각 메서드를 호출할 떄 별도의 호출문장을 
			기술하지 않는다 단지 아래문장이면 된다.
		*/
		//전송방식을 확인해 doGet()이나 doPost() 호출
		super.service(req, resp);
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException
	{
		System.out.println("doGet() 호출");
		req.getRequestDispatcher("/12Servlet/LifeCycle.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException
	{
		System.out.println("doPost() 호출");
		req.getRequestDispatcher("/12Servlet/LifeCycle.jsp").forward(req, resp);
	}
	
	/*
		서블릿이 새롭게 컴파일 되거나 서버가 종료될 때 호출된다.
		이때 서블릿 객체는 메모리에서 소멸된다.
		이클립스에서는 server 탭에서 서버를 종료하면 아래 메서드가 호출된다.
	*/
	@Override
	public void destroy()
	{
		System.out.println("destroy() 호출");
	}
	
	/*
		destroy() 메서드 호출 후 후처리를 위해 사용된다. 어노테이션을 사용하므로 메서드 명은
		우리가 결정하면 된다.
	*/
	@PreDestroy
	public void myPreDestroy()
	{
		System.out.println("myPreDestroy() 호출");

	}
}
