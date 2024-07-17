package model2.mvcboard;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/mvcboard/view.do")
public class ViewController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException
	{
		MVCBoardDAO dao = new MVCBoardDAO();
		//게시물 불러오기
		String idx = req.getParameter("idx");
		dao.updateVisitCount(idx); //조회수 1증가
		MVCBoardDTO dto = dao.selectView(idx);
		dao.close();
		
		//줄바꿈 처리
		dto.setContent(dto.getContent().replace("\r\n", "<br/>"));
		
		String ext = null, fileName =dto.getSfile();
		if(fileName != null) {
			ext = fileName.substring(fileName.lastIndexOf(".")+1);
		}
		
		//첨부파일 확장자 추출 및 이미지 타입 확인
		String[] mimeStr = {"png", "jpg", "gif", "PNG", "JPG", "GIF"};
		List<String> mimeList = Arrays.asList(mimeStr);
		boolean isImage = false;
		if(mimeList.contains(ext)) {
			isImage = true;
		}
		
		req.setAttribute("dto", dto);
		req.setAttribute("isImage", isImage);
		req.getRequestDispatcher("/14MVCBoard/View.jsp").forward(req, resp);
	}
}
