package fileupload;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;

public class FileUtil 
{
	//파일 업로드
	public static String uploadFile(HttpServletRequest req,
			String sDirectory)
			throws ServletException, IOException
	{
		//part 객체를 통해 서버로 전송된 파일명 읽어오기
		Part part = req.getPart("ofile");
		
		//Part 객체의 헤더값 content-disposition 읽어오기
		String partHeader = part.getHeader("content-disposition");
		//출력결과 => form-data; name
		System.out.println("partHeader=" + partHeader);
		
		//헤더값에서 파일명 잘라내기
		String[] phArr = partHeader.split("filename=");
		String originalFileName = phArr[1].trim().replace("\"", "");
		
		//전송된 파일이 있다면 디렉토리에 저장
		if(!originalFileName.isEmpty()) {
			part.write(sDirectory + File.separator + originalFileName);
		}
		
		//원본 파일명 반환
		return originalFileName;
	}
	
	//파일명 변경
	public static String renameFile(String sDirectory, String fileName)
	{
		//원본 파일의 확장자 잘라내기
		String ext = fileName.substring(fileName.lastIndexOf("."));
		//날짜 및 시간을 통해 "현재 날짜_ 시간" 형식의 문자열을 생성
		String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
		//날짜_시간.확장자" 형태의 새로운 파일명 생성
		String newFileName = now + ext;
		
		//객체를 생성 후 기존 파일명을 새로운 파일명으로 변경
		File oldFile = new File(sDirectory + File.separator + fileName);
		File newFile = new File(sDirectory + File.separator + newFileName);
		oldFile.renameTo(newFile);
		
		//변경된 파일명을 반환
		return newFileName;
	}
}
