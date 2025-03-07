package model1.board;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import common.JDBConnect;
import jakarta.servlet.ServletContext;

//JDBC를 이용한 DB연결을 위해 클래스 상속
public class BoardDAO extends JDBConnect  // 5장에서 생성한 JDBConnect 상속
{
	//인수생성자에서는 application 내장객체를 매개변수로 전달한다.
	public BoardDAO(ServletContext application) // JDBConnect에 정의된 생성자
	{
		//부모생성자에서는 application을 통해 web.xml(오라클 접속 정보)에
		//직접 접근하여 컨텍스트 초기화 파라미터를 얻어온다.
		super(application);
	}
	
	//멤버메서드
	//게시물의 갯수를 카운트 하여 int형으로 반환한다
	public int selectCount(Map<String, Object> map)
	{
		//결과(게시물 수)를 담을 변수
		int totalCount = 0;
		
		//게시물 수를 얻어오는 쿼리문 작성. COUNT(*)함수 사용
		String query = "SELECT COUNT(*) FROM board";
		//검색어가 있는 경우 where절을 추가하여 조건에 맞는 게시물만 인출한다.
		if(map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchField") + " "
					+ " LIKE '%" + map.get("searchWord") + "%'";
		}
		
		try {
			//정적쿼리문 실행을 위한 Statement 객체 생성
			stmt = con.createStatement();
			//select 쿼리문 실행 후 결과는 ResultSet으로 반환한다.
			rs = stmt.executeQuery(query);
			//커서를 첫번째 행으로 이동하여 레코드를 읽는다. (결과값이 있는지 확인)
			rs.next();
			//첫번째 컬럼의 값을 가져와서 변수(정수이므로 getInt()
			//1은 인덱스에 저장한다.
			totalCount = rs.getInt(1);
		}
		catch (Exception e) {
			System.out.println("게시물 수를 구하는 중 예외발생");
			e.printStackTrace();
		}
		
		return totalCount;
	}
	//작성된 게시물을 반환한다. 특히 반환값은 여러개의 레코드를 반환할 수
	//있으므로 List컬렉션을 반환타입으로 정의한다.
	public List<BoardDTO> selectList(Map<String, Object> map) 
	{
		//List계열의 컬렉션을 생성한다. 이때 매개변수는 BoardDTO객체로 설정
		//게시판 목록은 출력 순서가 보장되어야 하므로 Set컬렉션은 사용할 수 없음
		//List컬렉션을 사용해야한다!!!!! Linkedlist Arraylist 사용해도 무관.
		List<BoardDTO> bbs = new Vector<BoardDTO>();
		
		//레코드 추출을 위한 select쿼리문 작성
		String query = "SELECT * FROM board ";
		if (map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchField") + " "
					+ " LIKE '%" + map.get("searchWord") + "%' ";			
		}
		//최근 게시물을 상단에 노출하기 위해 내림차순으로 정렬한다.
		query += " ORDER BY num DESC ";
		
		try {
			//쿼리 실행 및 결과값 반환
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			//2개이상의 레코드가 반환될 수 있으므로 while문을 사용
			//객수만큼 반복하게된다.
			while (rs.next()) {
				//하나의 레코드를 저장할 수 있는 DTO객체 생성
				BoardDTO dto = new BoardDTO();
				
				//setter()을 이용해서 각 컬럼의 값을 저장
				dto.setNum(rs.getString("num"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setId(rs.getString("id"));
				dto.setVisitcount(rs.getString("visitcount"));
				
				//List컬렉션에 DTO객체를 추가한다
				bbs.add(dto);
			}
		}
		catch (Exception e) {
			System.out.println("게시물 조회 중 예외발생");
			e.printStackTrace();
		}
		
		return bbs;
	}
	
	public int insertWrite(BoardDTO dto) {
		int result = 0;
		
		try {
			/*
				인파라미터가 있는 동적쿼리문으로 insert 문 작성
				게시물의 일련번호는 시퀀스를 통해 자동부여 받고,
				조회수의 경우에는 0을 입력한다
			*/
			String query = "INSERT INTO board ( "
						 + " num,title,content,id,visitcount) "
						 + " VALUES ( "
						 + " seq_board_num.NEXTVAL, ?, ?, ?, 0)";
			//동적쿼리문이므로 prepared 객체를 통해 인파라미터를 채워준다.
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getId());
			//insert를 실행하여 입력된 행의 갯수를 돌려준다.
			result = psmt.executeUpdate();
		}
		catch (Exception e) {
			System.out.println("게시물 입력 중 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}
	
	//인수로 전달된 게시물의 일련번호로 하나의 게시물을 인출한다.
	public BoardDTO SelectView(String num) 
	{
		//하나의 레코드 저장을 위해 DTO객체 생성
		BoardDTO dto = new BoardDTO();
		
		//inner join(내부조인)을 통해 member 테이블의 name 컬럼까지 가져온다.
		/*
			보드테이블에서는 작성자의 아이디만 저장되므로 이름을 출력하기 위해서는
			member테이블과이ㅡ 조인이 필요하기 때문
			보드테이블의 모든 컬럼과 멤버 테이블의 네임 컬럼을 가져온다.
		*/
		String query = "SELECT B.*, M.name "
					 + " FROM member M INNER JOIN board B "
					 + " ON M.id=B.id "
					 + " WHERE num=?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, num);		//인파라미터를 일련번호로 설정
			rs = psmt.executeQuery();	//쿼리문 실행
			/*
				일련번호는 중복되지 않으므로 단 한개의 게시물만 인출하게 된다.
				따라서 while문이 아닌 if문으로 처리한다.
				next() 메서드는 ResultSet으로 반환된 게시물을 확인해서
			*/
			
			if(rs.next()) {
				dto.setNum(rs.getString(1)); 
				dto.setTitle(rs.getString(2));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setId(rs.getString("id"));
				dto.setVisitcount(rs.getString(6));
				dto.setName(rs.getString("name"));
			}
		}
		catch (Exception e) {
			System.out.println("게시물 상세보기 중 예외 발생");
			e.printStackTrace();
		}
		return dto;
	}
	//조회수를 증가시킬 게시물의 일련번호를 매개변수 받음
	//게시물의 조회수를 1증가시킨다.
	public void updateVisitCount(String num) 
	{
		/*
			게시물의 일련번호를 통해 visitcount 를 1 증가시킨다
			해당 컬럼은 number 타입이므로 사칙연산 가능
		*/
		String query = "UPDATE board SET "
					 + " visitcount=visitcount+1 "
					 + " WHERE num=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, num);
			/*
				일반적인 update 와 같이 기존의 행에 영향을 주는 쿼리문은
				executeUpdate 를 사용하지만 행의 개수를 알필요가 없으면
				executeQuery 사용해도 무방
			*/
			psmt.executeQuery();
		}
		catch (Exception e) {
			System.out.println("게시물 조회수 증가 중 예외 발생");
			e.printStackTrace();
		}
	}
	
	// 게시물 수정하기
	public int updateEdit(BoardDTO dto) {
		int result = 0;
		
		try {
			//특정 일련번호에 해당하는 게시물을 수정한다.
			String query = "UPDATE board SET "
						 + " title=?, content=? "
						 + " WHERE num=?";
			
			psmt = con.prepareStatement(query);
			//인파라미터 설정하기 (순서 지켜야함!)
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getNum());
			
			result = psmt.executeUpdate();
		}
		catch (Exception e) {
			System.out.println("게시물 수정 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
	//게시물 삭제하기
	public int deletePost (BoardDTO dto) {
		int result = 0;
		try {
			//인파라미터가 있는 delete 쿼리문 작성
			String query = "DELETE FROM board WHERE num=?";
			
			psmt = con.prepareStatement(query);
			//인파라미터로 일련번호를 설정
			psmt.setString(1, dto.getNum());
			//쿼리문 실행
			result = psmt.executeUpdate();
		}
		catch (Exception e) {
			System.out.println("게시물 삭제 중 예외 발생");
			e.printStackTrace();
		}
		//결과 반환
		return result;
	}
	
	//게시물 목록 출력시 페이징 기능 추가
	public List<BoardDTO> selectListPage(Map<String, Object> map){
		List<BoardDTO> bbs = new ArrayList<BoardDTO>();
		/*
			검색조건에 일치하는 게시물을 얻어온 후 각 출력 페이지에
			출력할 구간까지 설정한 서브 쿼리문 작성
		*/		
		String query = "SELECT * FROM ( "
					 + "	SELECT Tb.*, ROWNUM rNum FROM ( "
					 + "		SELECT * FROM board ";
		//검색어만 있는 경우에만  where을 추가한다
		if (map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchField")
				   + " LIKE '%" + map.get("searchWord") +"%' ";
		}
		//BETWEEN을 통해 게시물의 구간을 결정할 수 있다.
		query += "		ORDER BY num DESC "
			   + "		) Tb "
			   + " ) "
			   + " WHERE rNum BETWEEN ? AND ?";
		/*
			BETWEEN절 대신 비교연산자를 통해 쿼리문을 구성할 수도 있다
			where rNum >=? and rNum <=?
		*/
		try {
			//인파라미터가 있는 쿼리문 prepared객체 생성
			psmt = con.prepareStatement(query);
			//인파라미터 설정. 구간의 시작과 끝을 계산한 값이다
			psmt.setString(1, map.get("start").toString());
			psmt.setString(2, map.get("end").toString());
			//쿼리문을 실행하고 결과 레코드를 반환받는다.
			rs = psmt.executeQuery();
			//결과 레코드 갯수만큼 반복하여 List 컬렉션에 저장한다.
			while (rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setNum(rs.getString("Num")); 
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setId(rs.getString("id"));
				dto.setVisitcount(rs.getString("visitcount"));
				
				bbs.add(dto);
			}
		}
		catch (Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		
		return bbs;
	}

}
