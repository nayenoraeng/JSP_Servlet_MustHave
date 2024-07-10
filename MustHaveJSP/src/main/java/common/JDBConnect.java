package common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

//application 내장객채 타입인 ServletContext 를 사용할 수 있도록 임포트
import jakarta.servlet.ServletContext;

public class JDBConnect 
{
	//멤버변수 : 연결, 쿼리문 실행 및 전송, 결과셋 반환
	public Connection con; //데이터 베이스와 연결을 담당
	//인파라미터가 없는 정적 쿼리문을 실행할 때 사용
	public Statement stmt;
	//인파라미터가 있는 동적 쿼리문을 실행할 때 사용
	public PreparedStatement psmt;
	//select 쿼리문의 결과를 저장할 때 사용
	public ResultSet rs;
	
	//기본생성자 : 매개변수가 없느 ㄴ생성자
	public JDBConnect()
	{
		try {
			//JDBC 드라이버를 메모리에 로드-오라클 드라이브 로드
			Class.forName("oracle.jdbc.OracleDriver");
			//DB에 연결 - 커네셕 URL, 계정 아이디와 패스워드 기술
			String url = "jdbc:oracle:thin:@localhost:1521:xe";
			String id ="musthave";
			String pwd ="1234";
			/*
				준비한 url, id, pw 인수로 DriverManager 클래스의
				getConnection()을 호출하고 연결에 성공하면 Connection
				객체가 반환 이렇게 얻은 Connection 객체를 통해 오라클DB에 연결
			*/
			con = DriverManager.getConnection(url, id, pwd);
			//연결 성공시 콘솔에서 로그 확인 연결 성공 후 주석처리
			System.out.println("DB 연결 성공(기본생성자)");
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	//인수생성자 1 : 연결에 필요한 모든 정보를 매개변수로 받음 오버로딩
	public JDBConnect(String driver, String url, String id, String pwd) 
	{
		try {
			//JDBC 드라이버 로드
			Class.forName(driver);
			//DB에 연결
			con = DriverManager.getConnection(url, id, pwd);
			System.out.println("DB 연결 성공(인수 생성자 1)");
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	//인수생성자2 : application 내장객체 사용을 위한 매개변수 선언
	//컨텍스트 초기화 매개변수를 생성자에서 직접 가져올 수 있도록 정의
	//반복해서 사용시 좋음.
	public JDBConnect(ServletContext application) 
	{	/*
			jsp의 내장객체는 메서드에서는 즉시 사용할 수 없고 반드시
			매개변수로 참조값을 받은 후 사용해야한다.
	 	*/
		try {
			//
			String driver = application.getInitParameter("OracleDriver");
			Class.forName(driver);
			String url = application.getInitParameter("OracleURL");
			String id = application.getInitParameter("OracleId");
			String pwd = application.getInitParameter("OraclePwd");
			con = DriverManager.getConnection(url, id, pwd);
			System.out.println("DB 연결 성공(인수 생성자 2)");
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//자원 해제를 위한 메서드 : 자원을 절약하기 위해
	public void close()
	{
		try {
			if(rs != null) rs.close();
			if (stmt != null) stmt.close();
			if (psmt != null) psmt.close();
			if (con != null) con.close();
					
			System.out.println("JDBC 자원 해제");
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
}
