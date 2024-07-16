package fileupload;

import java.util.List;
import java.util.Vector;

import common.DBConnPool;

//커넥션 풀을 사용하기 위해 DBConnPool 상속
public class MyFileDAO extends DBConnPool{
	//새로운 게시물 등록시 첨부파일도 함께 저장한다.
	public int insertFile(MyFileDTO dto) {
		int applyResult = 0;
		try {
			/*
				게시물 입력을 위한 insert문 생성. 입력 폼에서 등록한 제목,
				이름과 원본파일명, 저장된 파일명을 등록한다.
				일련번호의 경우 회원제 게시판에서 생성했던 시퀀스를 그대로
				사용한다. 시퀀스의 목적은 중복되지 않은 일련번호를 생성하는
				것이므로 하나의 시퀀스를 여러개의 테이블에 사용해도 된다.
			*/
			String query = "INSERT INTO myfile ( "
						 + " idx, title, cate, ofile, sfile) "
						 + " VALUES ( "
						 + " seq_board_num.nextval, ?, ?, ?, ?)";
			
			psmt = con.prepareStatement(query);
			//인파라미터 설정
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getCate());
			psmt.setString(3, dto.getOfile());
			psmt.setString(4, dto.getSfile());
			//쿼리문 실행
			applyResult = psmt.executeUpdate();
		}
		catch (Exception e) {
			System.out.println("INSERT 중 예외발생");
			e.printStackTrace();
		}
		return applyResult;
	}
	
	public List<MyFileDTO> myFileList() {
		
		List<MyFileDTO> fileList = new Vector<MyFileDTO>();
		//일련번호를 내림차순으로 정렬한 뒤 게시물을 select 한다.
		String query = "SELECT * FROM myfile ORDER BY IDX DESC";
		
		try {
			//정적 쿼리문 실행
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			//인출한 행의 갯수만큼 반복한다.
			while (rs.next()) {
				//레코드를 DTO 객체로 저장한 후
				MyFileDTO dto = new MyFileDTO();
				dto.setIdx(rs.getString(1));
				dto.setTitle(rs.getString(2));
				dto.setCate(rs.getString(3));
				dto.setOfile(rs.getString(4));
				dto.setSfile(rs.getString(5));
				dto.setPostdate(rs.getString(6));
				
				//List 컬렉션에 추가한다.
				fileList.add(dto);
			}
		}
		catch (Exception e) {
			System.out.println("SELECT 시 예외 발생");
			e.printStackTrace();
		}
		
		//List 객체 반환
		return fileList;
	}
	
}
