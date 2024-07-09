package utils;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CookieManager {
	
	public static void makeCookie(HttpServletResponse response, String cName,
			String cValue, int cTime)
	{
		Cookie cookie = new Cookie(cName, cValue);
		cookie.setPath("/");
		cookie.setMaxAge(cTime);
		response.addCookie(cookie);
	}
	
	public static String readCookie(HttpServletRequest request, String cName)
	{		
		String cookieValue =""; //반환 값
		//생성된 쿠키를 배열로 읽어온다.
		Cookie[] cookies = request.getCookies();
		
		if(cookies != null) {
			//읽어온 쿠키의 갯수만큼 반복한다.
			for (Cookie c : cookies) {
				//쿠키명을 얻어온다.
				String cookieName =c.getName();
				//내가 찾은 쿠키명(cName)이 있는지 확인한다
				if(cookieName.equals(cName)) {
					//쿠키명이 일치하면 쿠키값을 읽어서 저장한다
					cookieValue = c.getValue(); //반환 값 갱신
				}
			}
		}
		return cookieValue; //값을 반환
		
	}
	/*
		쿠키삭제 : 쿠키는 삭제를 위한 별도의 메서드가 없다
		빈값과 유지시간을 0으로 설정하면 삭제된다. 따라서 앞에서 정의한
		makeCookie()메서드를 재활용한다.
		
	*/
	//명시한 이름의 쿠키를 삭제합니다.
	public static void deleteCookie(HttpServletResponse response, String cName)
	{
		makeCookie(response, cName, "", 0);
	}

}
