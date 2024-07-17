package model2.mvcboard;

import java.io.IOException;

import fileupload.FileUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.JSFunction;

@WebServlet("/mvcboard/pass.do")
public class PassController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	//패스워드 검증 페이지로 진입
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException
	{
		/*
			/mvcboard/pass.do?mode=delete&idx=122
			
		*/
		req.setAttribute("mode", req.getParameter("mode"));
		req.getRequestDispatcher("/14MVCBoard/Pass.jsp").forward(req, resp);
	}
	
	//비밀번호 검증 페이지에서 전송한 경우 수정, 삭제 처리
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException
	{
		//입력한 비밀번호와 hidden 박스에서 전송된 파라미터를 받아 매개변수에 저장
		String idx = req.getParameter("idx");
		String mode = req.getParameter("mode");
		String pass = req.getParameter("pass");
		
		//DAO객체 생성
		MVCBoardDAO dao = new MVCBoardDAO();
		boolean confirmed = dao.confirmPassword(pass, idx);
		dao.close();
		
		//패스워드 검증에 성공한 경우
		if(confirmed) {
			if(mode.equals("edit")) { //수정모드
				HttpSession session = req.getSession();
				session.setAttribute("pass", pass);
				resp.sendRedirect("../mvcboard/edit.do?idx=" + idx);
			}
			else if(mode.equals("delete")) {
				dao = new MVCBoardDAO();
				MVCBoardDTO dto = dao.selectView(idx);
				int result = dao.deletePost(idx);
				dao.close();
				if(result == 1) {
					String savaFileName = dto.getSfile();
					FileUtil.deleteFile(req, "/Uploads", savaFileName);
				}
				JSFunction.alertLocation(resp, "삭제되었습니다.", "../mvcboard/list.do");
			}
		}
		else {
			JSFunction.alertBack(resp, "비밀번호 검증에 실패했습니다.");
		}
	}

}
