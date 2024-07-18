<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>네이버검색API</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script>
		$(function() {
			$('#searchBtn').click(function() {
				$.ajax({
					url : "../NaverSearchAPI.do",
					type : "get",
					data : {
						keyword : $('#keyword').val(),
						startNum : $('#startNum option:selected').val()
					},
					dataType : "json",
					success : suFuncJson,
					error : errFunc
				});
			});
		});
		
		function suFuncJson(d) {
			var str = "";
			$.each(d.items, function(index, item) {
				str += "<ul>";
				str += "	<li>" + (index + 1) + "</li>";
				str += "	<li>" + item.title + "</li>";
				str += "	<li>" + item.description + "</li>";
				str += "	<li>" + item.bloggername + "</li>";
				str += "	<li>" + item.bloggerlink + "</li>";
				str += "	<li>" + item.postdate + "</li>";
				str += "	<li><a href='" + item.link + "' target='_blank'>바로가기</a></li>";
				str += "</ul>";
			});
			$('#searchResult').html(str);
		}
		function errFunc(e) {
			alert("실패: " + e.status);
		}
	</script>
	<style>
		ul{border:2px #cccccc solid;}
	</style>
	</head>
	<body>
		<div>
		   <div>
		       <form id="searchFrm">
		           한 페이지에 10개씩 출력됨 <br />
		           <select id="startNum">
		               <option value="1">1페이지</option>
		               <option value="11">2페이지</option>
		               <option value="21">3페이지</option>
		               <option value="31">4페이지</option>
		               <option value="41">5페이지</option>
		           </select>
		           <input type="text" id="keyword" placeholder="검색어를 입력하세요." />
		           <button type="button" id="searchBtn">검색 요청</button>
		       </form>
		   </div>
		   <div class="row" id="searchResult">
		       여기에 검색 결과가 출력됩니다.
		   </div>
		</div>
	</body>
</html>