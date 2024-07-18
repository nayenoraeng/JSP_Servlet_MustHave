package api;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/NaverSearchAPI.do")
public class SearchAPI extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException
	{
		String clientId = "HlPeSlWKfM8o0qOHmVf1";
		String clidentSecret = "arxfE1gic2";
		
		int startNum = 0;
		String text = null;
		try
		{
			startNum = Integer.parseInt(req.getParameter("startNum"));
			String searchText = req.getParameter("keyword");
			text = URLEncoder.encode(searchText, "UTF-8");
		} 
		catch (UnsupportedEncodingException e)
		{
			throw new RuntimeException("검색어 인코딩 실패", e);
		}
		
		String apiURL = "https://openapi.naver.com/v1/search/blog?query=" + text
						+ "&display=10&start=" + startNum;
		
		Map<String, String> requestHeaders = new HashMap<>();
		requestHeaders.put("X-Naver-Client-Id", clientId);
		requestHeaders.put("X-Naver-Client-Secret", clidentSecret);
		String responseBody = get(apiURL, requestHeaders);
		
		System.out.println(responseBody);
		
		resp.setContentType("text/html:chatset=utf-8");
		resp.getWriter().write(responseBody);
		
	}
	
	private static String get(String apiUrl, Map<String, String> requestHeaders)
	{
		HttpsURLConnection con = connect(apiUrl);
		try
		{
			con.setRequestMethod("GET");
			for(Map.Entry<String, String> header : requestHeaders.entrySet()) {
				con.setRequestProperty(header.getKey(), header.getValue());
			}
			
			int responseCode = con.getResponseCode();
			if(responseCode == HttpsURLConnection.HTTP_OK) {
				return readBody(con.getInputStream());
			} else {
				return readBody(con.getErrorStream());
			}
			
		} 
		catch (IOException e)
		{
			throw new RuntimeException("API 요청과 응답 실패", e);
		}
		finally {
			con.disconnect();
		}
	}
	
	private static HttpsURLConnection connect(String apiUrl)
	{
		try
		{
			URL url = new URL(apiUrl);
			return (HttpsURLConnection)url.openConnection();
		} 
		catch (MalformedURLException e)
		{
			throw new RuntimeException("API URL이 잘못되었습니다 : " + apiUrl, e);
		}
		catch (IOException e)
		{
			throw new RuntimeException("연결이 실패했습니다 : " + apiUrl, e);
		}
	}
	
	private static String readBody(InputStream body)
	{
		InputStreamReader streamReader = new InputStreamReader(body);
		
		try(BufferedReader lineReader = new BufferedReader(streamReader))
		{
			StringBuilder responseBody = new StringBuilder();
			
			String line;
			while ((line = lineReader.readLine()) != null) {
				responseBody.append(line);
			}
			
			return responseBody.toString();
		} 
		catch (IOException e)
		{
			throw new RuntimeException("API 응답을 읽는데 실패했습니다.", e);
		}
	}
	
}
