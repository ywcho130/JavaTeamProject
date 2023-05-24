<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 수강 목록</title>

<style type="text/css">
h1{
	padding-bottom: 8px;
	border-bottom: 4px solid #187FD9;
}
.filters-content{
	width: 100%;
}
a.btn.selected {
	background-color: #187FD9;
	color: white;
}
.sort-btn{
	border: 1px solid black;
}
#pageNavDiv{
	padding: 15px 0;
}
.path {
 margin-top:15px;
 margin-bottom:30px;
  display: flex;
  align-items: center;
  font-size: 14px;
  font-weight: bold;
  color: #333;
}

.path span:not(:last-child)::after {
  content: "";
  display: inline-block;
  margin: 0 10px;
  width: 5px;
  height: 5px;
  border-radius: 50%;
  background-color: #ccc;
}

.path span:last-child {
  color: #666;
}
.row{
	margin-top: 20px; 
}
.layout_padding{
	padding: 10px 0 0 0 ;
}
.not-enough{
    text-align: center;
    margin: 64px 0;
}

</style>

<script type="text/javascript" src="/js/enrollList.js"></script>
<script type="text/javascript">

$(function(){

	// 필요한 변수
	var key = null; // 데이터 sort
	var word = null; // 정렬변경
	var pageNav = $("#pageNavDiv"); // 페이지처리 div
	var page = 1; // 최초 페이지
	var selectedKey = ''; // sort 버튼 선택

	// 정렬 select 변경시 이벤트
	$("#word").change(function(){
		// 변경된 select 가져와서 페이지 표시
		word = $("#word").val();
		showList(page);
	});

	// 정렬 select 변경시 변경 유지
	if("${param.word}") $("#word").val("${param.word}");

	// 학습중 버튼 클릭시 이벤트
	$("#studying").click(function(){
		if (selectedKey === 'studying') { // 처음에 선택 되어 있으면
			// sort 버튼 선택 x로 변경
			$("#studying, #complete").removeClass("selected");
			selectedKey = '';
		} else { // 처음에 선택 안되어 있으면
			// sort 버튼 학습중 선택으로 변경
			$("#studying, #complete").removeClass("selected");
			$(this).addClass("selected");
			selectedKey = 'studying';
		} // end of if else

		// sort 버튼 적용해서 다시 리스트 표시
		key = selectedKey;
		showList(page);
	});

	// 완강 버튼 클릭시 이벤트
	$("#complete").click(function(){
		if (selectedKey === 'complete') { // 처음에 선택 되어 있으면
			// sort 버튼 선택 x로 변경
			$("#studying, #complete").removeClass("selected");
			selectedKey = '';
		} else { // 처음에 선택 안되어 있으면
			// sort 버튼 학습중 선택으로 변경
			$("#studying, #complete").removeClass("selected");
			$(this).addClass("selected");
			selectedKey = 'complete';
		} // end of if else

		// sort 버튼 적용해서 다시 리스트 표시
		key = selectedKey;
		showList(page);
	});

	// 리스트 표시할 div
	var listDiv = $(".listDiv");

	// 페이지 로딩시 최초 리스트 표시
	showList(page);

	// 리스트 표시 함수
	function showList(page){
		// enrollList.list(param, callback, error) - /js/enrollList.js
		enrollList.list(
				{word:word, key:key, page:page}, // param - 넘겨주는 데이터
				function(data){
					// 결과 data에서 list와 pageObject 꺼내기 
					var list = data.list;
					var pageObject = data.pageObject;

					var str ="";

					// 리스트 데이터 없으면 표시할 내용
					if(list == null || list.length == 0){
						listDiv.html("<div class='not-enough'>해당하는 강의가 없습니다.</div>")
						return;
					} // end of if
					
				    // 리스트 데이터 있으면 있는 만큼 데이터 표시
					for(var i=0; i<list.length; i++){
						console.log(list[i]);
						str += "<div class='col-sm-6 col-lg-4 all teacher'>";
						str += "<div class='box'>";
						str += "<div>";
						str += "<div class='img-box'>";
						str += "<img src='"+list[i].image+"' alt=''>";
						str += "</div>";
						str += "<div class='detail-box'>";
						str += "<h5>"+list[i].title+"</h5>";
						str += "<p>";
						// 날짜 형식으로 변경
						date = new Date(list[i].payDate);
						str += "학습시작일 : " + date.getFullYear() + "-" + (date.getMonth() + 1 < 10 ? '0' : '') + (date.getMonth() + 1) + "-" + (date.getDate() < 10 ? '0' : '') + date.getDate() + "<br>";

						if(!list[i].viewDate){
							str += "최근수강일 : - <br>";
						}else{
							date = new Date(list[i].viewDate);
							str += "최근수강일 : " + date.getFullYear() + "-" + (date.getMonth() + 1 < 10 ? '0' : '') + (date.getMonth() + 1) + "-" + (date.getDate() < 10 ? '0' : '') + date.getDate() + "<br>";
						}
						
						str += "학습진행률 : "+list[i].viewRatio+"%";
						str += "</p>";
						str += "<div class='options'>";
						str += "<h6>"+list[i].teacher_name+"</h6>";
						str += "<a href='/course/view.do?no="+list[i].no+"&page=1&perPageNum=10&key=&word='>";
						str += "<i class='fa fa-arrow-right' style='font-size:1.4em;color:white;''></i>";
						str += "</a>";
						str += "</div></div></div></div>";
						str += "</div>";
						
						} // end of for

					// listDiv에 리스트 표시
					listDiv.html(str);

					str = "";
					
					// 페이지네이션 코드 작성 - pageObject 사용
					str = "";
					str += "<ul class='pagination'>";
					str += "<li class='page-item ";
					if(pageObject.startPage == 1) str += "disabled";
					str += "'><a class='page-link' href='#'>Previous</a></li>";
					for(var i = pageObject.startPage; i<=pageObject.endPage; i++){
						str += "<li class='page-item ";
						if(page == i) str += "active";
						str += "'><a class='page-link' href='#'>"+i+"</a></li>";
					}
					str += "<li class='page-item ";
					if(pageObject.endPage == pageObject.totalPage) str += "disabled";
					str += "'><a class='page-link' href='#'>Next</a></li>";
					str += "</ul>";					

					// 페이지처리 div에 페이지처리 표시
					pageNav.html(str);
	
				} // end of function(data)
	
			) // end of enrollList()
			
		}; // end of showList(page)

		
		// 댓글 페이지네이션 이벤트 처리
		$("#pageNavDiv").on("click", "ul>li", function(){
			var goPage = $(this).text();
			// 현재페이지가 아닌경우 페이지 이동
			if(!$(this).hasClass("active")) showList(goPage);
			return false;
		});
	
});
</script>

</head>
<body>
	<section class="layout_padding">
		<div class="container">
		
			<div class="path">
			  <span>Home</span>
			  <span>내 강의실</span>
			</div>
		
			<h1 style="color:#333333">내 강의실</h1>
			<div class="row">
				<div class="col-md-2">
					<form class="from-inline" id="listChangeForm" action="enrollList.do">
						<div class="form-group">
							<select name="word" id="word" class="form-control">
								<option value="title">제목순</option>
								<option value="study">최근 학습순</option>
								<option value="buy">최근 신청순</option>
							</select>
						</div>
					</form>
				</div>
				<div class="col-md-5">
					<div id="word">
						<input type="hidden" name="key" id="key">
						<a id="studying" type="button" class="btn sort-btn" data-key="studying">학습중</a>
						<a id="complete" type="button" class="btn sort-btn" data-key="complete">완강</a>
					</div>
				</div>
			</div>
			
		</div>
	</section>
	
	 <section class="food_section layout_padding-bottom">
    <div class="container">
      <div class="heading_container heading_center">			
			
		      <div class="filters-content">
			
				 <div class="row grid listDiv">
				 
				 
		          </div>
			
			</div>
			
			
			
	</div>
		<div id="pageNavDiv"></div>
	</div>
	</section>		
			
	
</body>
</html>