<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>교재 리스트</title>

<style type="text/css">
.dataRow {
	min-width:19%;
	width:20%;
	height:440px;
	margin-right: 70px; 
	text-align:center;
	position: relative;
    margin-top: 25px;
    background-color: #ffffff;
    border-radius: 10px;
    color: #ffffff;
    border-radius: 15px;
    overflow: hidden;
    background: linear-gradient(to bottom, #f1f2f3 25px, #222831 25px);	
}
.title{
	text-align:center;
	height:70px;
	margin-top:10px;
}
.dataRow:hover{
		cursor: pointer;
	border:2px solid #00ffba;
}

.img-box{
	background: #f1f2f3; 
    display: -webkit-box;
    display: -ms-flexbox;
    display: flex;
    -webkit-box-pack: center;
    -ms-flex-pack: center;
    justify-content: center;
    -webkit-box-align: center;
    -ms-flex-align: center;
    align-items: center;
    height: 215px;
    border-radius: 0 0 0 45px;
    margin: -1px;
    padding: 25px;
}
.dataRow .img{
	max-width: 150%;
    max-height: 200px;
    -webkit-transition: all .2s;
    transition: all .2s;
}
.price{
	margin-left:30px;
}
.status{
	margin-right:30px;
	background:#33CC33;
}
</style>

<script type="text/javascript">
$(function(){
	$(".dataRow").click(function(){
		var no = $(this).find(".no").text();
		// alert("글번호 : " + no);
		location = "view.do?no=" + no
			+ "&page=${pageObject.page}&perPageNum=${pageObject.perPageNum}"
			+ "&key=${pageObject.key}&word=${pageObject.word}"
		;	
	});

	// 검색 데이터 유지
	<c:if test="${!empty pageObject.word}">
		$("#key").val("${(!empty pageObject.key)?pageObject.key:'t'}");
		$("#word").val("${pageObject.word}");
	</c:if>
	
	// 전체 리스트 버튼
	$("#AllBtn").click(function(){
		location = "list.do?"
			+ "&page=${pageObject.page}&perPageNum=${pageObject.perPageNum}"
			+ "&key=&word=";
		});
	// Java 리스트 버튼
	$("#JavaBtn").click(function(){
		location = "list.do?"
			+ "&page=1&perPageNum=${pageObject.perPageNum}"
			+ "&key=d&word=JAVA";
		});
	// Jsp/Servlet 리스트 버튼
	$("#JspBtn").click(function(){
		location = "list.do?"
			+ "&page=1&perPageNum=${pageObject.perPageNum}"
			+ "&key=d&word=Jsp/Servlet";
		});
	// 스프링 리스트 버튼
	$("#SpringBtn").click(function(){
		location = "list.do?"
			+ "&page=1&perPageNum=${pageObject.perPageNum}"
			+ "&key=d&word=Spring";
		});
});
</script>

</head>
<body>
<div class="card shadow md-4">
<!-- <div class="container"> -->
	<div class="card-body">
	<!-- 관리자만 등록 버튼이 보이게 -->
	<c:if test="${login !=null && login.gradeNo ==9 }">
	<a href="write.do" class="btn btn-dark" style="float:right">교재 등록</a>
	</c:if>
		<div class="row1">
			<div class="col-md-3">
				<form action="list.do" method="post">
					<input type="hidden" name="perPageNum" value="${pageObject.perPageNum }">
					<div class="input-group mb-3">
					  <div class="input-group-prepend">
						  <select class="form-control" id="key" name="key">
						    <option value="t">교재명</option>
						    <option value="d">과목명</option>
						    <option value="td">전체</option>
						  </select>
					  </div>
					  <input type="text" class="form-control" placeholder="Search" id="word" name="word">
					  <div class="input-group-append">
					    <button class="btn btn-success" type="submit">검색</button>
					  </div>
					</div>			
				</form>		
			</div>
			<div>
				<button id="AllBtn" class="btn btn-dark">전체</button>
				<button id="JavaBtn" class="btn btn-secondary">JAVA</button>
				<button id="JspBtn" class="btn btn-primary">Jsp/Servlet</button>
				<button id="SpringBtn" class="btn btn-success">Spring</button>
			</div>		
		</div>
		<div class="row2">
			<div class="col-md-12" style="width:100%; align=center;">
				<c:forEach items="${list }" var="vo">
					<div class="dataRow" style="display: inline-block">
						<div class="no" hidden="hidden">${vo.bookNo }</div>
						<div class="img-box">
						<img alt="이미지" src="${vo.fileName }" class="img">
						</div>
						<div>
						<h4 class="title">${vo.bookName}</h4>
						<p class="p">
						과목명 : ${vo.bookDiv}<br/> 
						발행일 : <fmt:formatDate value="${vo.pubDate}" pattern="yyyy년MM월dd일"/><br/>
						</p>
						<div><span class="price"><fmt:formatNumber value="${vo.price }" pattern="#,###"/>원</span><span class="status"style="margin-left:10px;">${vo.status }</span></div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
		<br/><br/>
		<div>
		<pageNav:pageNav listURI="list.do" pageObject="${pageObject }" />
		</div>
	</div>
</div>
</body>
</html>