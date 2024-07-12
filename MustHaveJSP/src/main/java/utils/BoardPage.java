package utils;

public class BoardPage 
{
	public static String pagingStr(int totalCount, int pageSize, int blockPage,
			int pageNum, String reqUrl)
	{
		String pagingStr ="";
		int totalPages = (int)(Math.ceil(((double) totalCount / pageSize)));
		
		int pageTemp = (((pageNum - 1) / blockPage) * blockPage) + 1;
		if(pageTemp != 1) {
			pagingStr += "<a href='" + reqUrl + "?pageNum=1'>[첫페이지]</a>";
			pagingStr += "&nbsp;";
			pagingStr += "<a href='" + reqUrl + "?pageNum=" + (pageTemp - 1)
						+ "'>[이전블록]</a>";
		}
		
		/*
			각페이지 번호로 바로가기 링크 출력
			앞에서 계산한 pageTemp를 블록페이만큼 반복해서 출력한다.
			이때 1씩 증가시켜준다. 즉 한블럭당 5페이지를 출력한다.
		*/
		int blockCount = 1;
		while (blockCount <= blockPage && pageTemp <= totalPages) {
			//만약 현재페이지라면 링크를 걸지 않는다.
			if (pageTemp == pageNum) {
				pagingStr += "&nbsp;" + pageTemp + "&nbsp;";
			} else {
				//현재페이지가 아닌 경우에만 링크를 추가한다.
				pagingStr += "&nbsp;<a href='" + reqUrl + "?pageNum=" + pageTemp
							+ "'>" + pageTemp + "</a>&nbsp;";
			}
			//반복하면서 1씩 증가시켜 순차적인 페이지번호를 출력한다.
			pageTemp++;
			blockCount++;
		}
		
		//다음페이지 블럭 바로가기 링크 추가
		//마지막 페이지가 아닌 경우에만 다음블럭을 출력한다.
		if (pageTemp <= totalPages) {
			pagingStr += "<a href='" + reqUrl + "?pageNum=" + pageTemp
						+"'>[다음블록]</a>";
			pagingStr += "&nbsp;";
			pagingStr += "<a href='" + reqUrl + "?pageNum=" + totalPages
						+"'>[마지막 페이지]</a>";
		}
		
		return pagingStr;
	}
}
