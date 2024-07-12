<%@page import="utils.BoardPage"%>
<%@page import="model1.board.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="model1.board.BoardDAO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//DB연결 및 CRUD작업을 위한 DAO객체 생성
	BoardDAO dao = new BoardDAO(application);
	
	/*
		검색어가 있는 경우 클라이언특 ㅏ 선택한 필드명과 검색어를 저장할
		MAP컬렉션 생성
	*/
	Map<String, Object> param = new HashMap<String, Object>();
	String searchField = request.getParameter("searchField");
	String searchWord = request.getParameter("searchWord");
	if(searchWord != null){
		param.put("searchField", searchField);
		param.put("searchWord", searchWord);
	}
	
	int totalCount = dao.selectCount(param);
	
	/* 페이지 코드 추가 부분 */
	//wep.xml 설정한 컨섹스트 초기화 파라미터를 읽어와서 산술 연산을 위해
	//정수 int로 변환한다. 전체 페이지 수 계산
	int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
	int blockPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));
	/*
		전체페이지수를 계산한다
		(전체 게시물 갯수 / 페이지당 출력할 게시물 갯수) => 결과값의 올림처리
		가령 게시물의 갯수가 105개라며 나눴을 때 결과가 10.5이 된다. 이때 무조건
		올림처리 하여 11페이지가 나게 된다.
		만약 totalCount를 double로 형변환 하지 않으면 정수의 결과가 나오게 되므로
		11페이지가 아니라 10페이지가 된다. 따라서 주의해야함!
	*/
	int totalPage = (int)Math.ceil((double)totalCount / pageSize);
	
	/*
		목록에 처음 진입했을 때는 페이지 관련 파라미터가 없는 상태이므로 무조건
		1page로 지정한다. 만약 파라미터 pageNum이 있다면 리케스트 내장객체를 통해
		반아온후 페이지 번호를 지정한다.
		List.jsp => 이와같이 파라미터가 없는 상태일때는 null
		List.jsp?pageNum= => 이와같이 파라미터는 있는데 값이 없을 떄는 빈값으로
		체크된다 따라서 아래 if문은 2개의 조건으로 구성해야한다.
	*/
	int pageNum = 1;
	String pageTemp = request.getParameter("pageNum");
	if (pageTemp != null && !pageTemp.equals(""))
		pageNum = Integer.parseInt(pageTemp); //요청받은 페이지로 수정 (true)
	/*
		false 게시물의 구간을 계산한다 각페이지의 시작번호와 종료번호를
		현재페이지번호와 페이지사이즈를 통해
		계산한 후 DAO로 전달하기 위해 Map컬렉션에 추가한다.
	*/
	//몰록에 출력할 게시물 범위 계산
	int start = (pageNum - 1) * pageSize + 1; //첫게시물 번호
	int end = pageNum * pageSize ; //마지막 게시물 번호
	param.put("start", start);
	param.put("end", end);
	
	/* 페이지 코드 추가 끝 */
	
// 	List<BoardDTO> boardLists = dao.selectList(param);
	List<BoardDTO> boardLists = dao.selectListPage(param); //게시물 목록 받기
	dao.close();
%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>회원제 게시판</title>
	</head>
	<body>
    <jsp:include page="../Common/Link.jsp" />  
    
    <!-- 앞에서 계산해둔 전체페이지 수와 파라미터를 통해 얻어온 현재
    	페이지 변호를 출력한다. -->

    <h2>목록 보기(List) - 현재 페이지 : <%= pageNum %> (전체 : <%= totalPage %>)</h2>
    <form method="get">  
    <table border="1" width="90%">
    <tr>
        <td align="center">
            <select name="searchField"> 
                <option value="title">제목</option> 
                <option value="content">내용</option>
            </select>
            <input type="text" name="searchWord" />
            <input type="submit" value="검색하기" />
        </td>
    </tr>   
    </table>
    </form>
    <table border="1" width="90%">
        <tr>
            <th width="10%">번호</th>
            <th width="50%">제목</th>
            <th width="15%">작성자</th>
            <th width="10%">조회수</th>
            <th width="15%">작성일</th>
        </tr>
	<%
	if (boardLists.isEmpty()) {
	%>
        <tr>
            <td colspan="5" align="center">
                등록된 게시물이 없습니다^^*
            </td>
        </tr>
	<%
	}
	else {
	    int virtualNum = 0; //화면상에서의 게시물 번호
	    
	    //페이지가 적용된 가상번호를 계산하기 위해 생성한 변수
	    int countNum = 0;
	    for (BoardDTO dto : boardLists)
	    {
// 	        virtualNum = totalCount--;   //기존코드
			//현재 페이지 번호를 적용한 가상번호 계산하기
			//전체게시물 수 - (((현재페이지-1)*한페이지출력갯수) + counuNum 증가치)
	        virtualNum = totalCount - (((pageNum - 1) * pageSize) + countNum++);
	%>
	        <tr align="center">
	        <!--  게시물의 가상 번호 -->
	            <td><%= virtualNum %></td>  
	            <td align="left"> 
	                <a href="View.jsp?num=<%= dto.getNum() %>"><%= dto.getTitle() %></a> 
	            </td>
	            <td align="center"><%= dto.getId() %></td>           
	            <td align="center"><%= dto.getVisitcount() %></td>   
	            <td align="center"><%= dto.getPostdate() %></td>    
	        </tr>
	<%
	    }
	}
	%>
	    </table>
	   
	    <table border="1" width="90%">
	        <tr align="right">
	        	<!-- 페이징 처리 -->
	        	<td>
	        		<%= BoardPage.pagingStr(totalCount, pageSize,
	        				blockPage, pageNum, request.getRequestURI()) %>
	        	</td>
	            <td><button type="button" onclick="location.href='Write.jsp';">글쓰기
	                </button></td>
	        </tr>
	    </table>
	</body>

</html>