<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강의 결제</title>
<style type="text/css">
.layout_padding{
	padding: 10px 0 90px 0;
}

.filters-content {
    padding: 20px 0;
}
h1{
	padding-bottom: 8px;
	border-bottom: 4px solid #187FD9;
}
.content-title{
	color: #187FD9;
	font-size: 18px;
	margin-bottom: 5px;
}
.formDiv{
	padding: 10px 0 10px 15px;
	border-top: 2px solid #ccc;
	border-bottom: 2px solid #ccc;
}
.info{
	padding: 10px;
}
.info-content:last-child{
	border-top: 1px solid #eee;
}
.info-content{
	padding: 10px 0;
	display: flex;
}
.dt{
	font-weight: 700;
	min-width: 120px;
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
.card{
    display: flex;
    padding: 10px 12px;
    width: 200px;
    height: 40px;
    letter-spacing: -.3px;
    border: 1px solid #dee2e6;
    background-color: #fff;
}
.input-group{
	max-width: 300px;
	margin: 15px 0;
}

</style>

<script type="text/javascript">

$(function(){
	// 카드번호 입력 자동 포커스
	$("#card1").keyup(function(){ // 1-> 2
		var len = $(this).val().length;
		if(len >= 4){
			$(this).val($(this).val().substring(0,4));
			$("#card2").focus();
		}
	})
	
	// 카드번호 입력 자동 포커스
	$("#card2").keyup(function(){ // 2->3
		var len = $(this).val().length;
		if(len >= 4){
			$(this).val($(this).val().substring(0,4));
			$("#card3").focus();
		}
	})
	
	// 카드번호 입력 자동 포커스
	$("#card3").keyup(function(){ // 3->4
		var len = $(this).val().length;
		if(len >= 4){
			$(this).val($(this).val().substring(0,4));
			$("#card4").focus();
		}
	})
	
	// 결제방법 선택에 따라 보여주는 div다르게
	$("input[name='payMethod']").on("change", function() {
	  var value = $(this).val();
	  if (value === "무통장입금") { // 무통장입금 선택
		$(".pay").css("display", "none");
		$("#depositDiv").css("display", "block");
	  } else if (value === "신용카드") { // 신용카드 선택
		$(".pay").css("display", "none");
		$("#cardDiv").css("display", "block");
		$("#card1").focus();
	  }
	});

	// 할인적용 버튼 클릭
	$("#couponBtn").click(function(){
		$('#readyModal').modal('show');
	})
	
})

</script>
</head>
<body>
	<section class="layout_padding">
		<div class="container">
		
			<div class="path">
			  <span>Home</span>
			  <span>강의결제</span>
			</div>
			
			<h1 style="color:#333333">결제</h1>
			
			<form action="/enroll/enroll.do" method="post">
				<input type="hidden" name=totalprice value="${course.price }">
				<input type="hidden" name=title value="${course.title }">
				<input type="hidden" name=no value="${course.no }">
			
				<div class="filters-content">
				<div class="content-title">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-align-bottom" viewBox="0 0 16 16">
					  <rect width="4" height="12" x="6" y="1" rx="1"/>
					  <path d="M1.5 14a.5.5 0 0 0 0 1v-1zm13 1a.5.5 0 0 0 0-1v1zm-13"/>
					</svg>상품 정보
				</div>
				<table class="table">
					<thead>
						<tr>
							<th>구분</th>
							<th>상품 정보</th>
							<th>상품가격</th>
							<th>할인가격</th>
							<th>할인적용가격</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>강의</td>
							<td>${course.title } - ${course.name }</td>
							<td><fmt:formatNumber value="${course.price }" pattern="#,###" /> 원</td>
							<td>0 원 <button type="button" id="couponBtn" class="btn btn-sm btn-info">쿠폰사용</button></td>
							<td><span style="color: red;"><fmt:formatNumber value="${course.price }" pattern="#,###" /></span> 원</td>
						</tr>
					</tbody>
				</table>
				</div>
				
				<div class="filters-content">
				<div class="content-title">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-align-bottom" viewBox="0 0 16 16">
					  <rect width="4" height="12" x="6" y="1" rx="1"/>
					  <path d="M1.5 14a.5.5 0 0 0 0 1v-1zm13 1a.5.5 0 0 0 0-1v1zm-13"/>
					</svg>구매자 정보
				</div>
					<div class="formDiv info">
						<div class="info-content">
							<span class="dt">이름</span> 
							<span class="dd">${member.name }</span>
						</div>
						<div class="info-content">
							<span class="dt">이메일</span> 
							<span class="dd">${member.email }</span>
						</div>
					</div>
				</div>
				 
				<div class="filters-content">
				<div class="content-title">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-align-bottom" viewBox="0 0 16 16">
					  <rect width="4" height="12" x="6" y="1" rx="1"/>
					  <path d="M1.5 14a.5.5 0 0 0 0 1v-1zm13 1a.5.5 0 0 0 0-1v1zm-13"/>
					</svg>결제수단 선택
				</div>
					<div class="formDiv">
					<div class="form-check-inline">
				      <label class="form-check-label" for="radio1" id="deposit">
				        <input type="radio" class="form-check-input"  name="payMethod" value="무통장입금">무통장입금
				      </label>
				    </div>
				    <div class="form-check-inline">
				      <label class="form-check-label" for="radio2" id="card">
				        <input type="radio" class="form-check-input"  name="payMethod" value="신용카드">신용카드
				      </label>
				    </div>
				    <div class="form-check-inline">
				      <label class="form-check-label">
				        <input type="radio" class="form-check-input" disabled>카카오페이
				      </label>
				    </div>
					</div>
				</div>
				
				<div class="filters-content pay" id="depositDiv" style="display: none;">
				<div class="content-title">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-align-bottom" viewBox="0 0 16 16">
					  <rect width="4" height="12" x="6" y="1" rx="1"/>
					  <path d="M1.5 14a.5.5 0 0 0 0 1v-1zm13 1a.5.5 0 0 0 0-1v1zm-13"/>
					</svg>무통장입금
				</div>
					<table class="table">
						<thead>
							<tr>
								<th>은행명</th>
								<th>계좌번호</th>
								<th>예금주</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>이젠은행</td>
								<td>000-00000-000000</td>
								<td>이젠컴퓨터학원</td>
							</tr>
						</tbody>
					</table>
				</div>

				<div class="filters-content pay" id="cardDiv" style="display: none;">
				<div class="content-title">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-align-bottom" viewBox="0 0 16 16">
					  <rect width="4" height="12" x="6" y="1" rx="1"/>
					  <path d="M1.5 14a.5.5 0 0 0 0 1v-1zm13 1a.5.5 0 0 0 0-1v1zm-13"/>
					</svg>카드결제
				</div>
				<div>카드번호를 입력해 주세요.</div>
				<div class="input-group">
					<input class="card form-control" id="card1"><input class="card form-control" id="card2">
					<input class="card form-control" id="card3"><input class="card form-control" id="card4">
				</div>
				</div>
				
				<div>
					<button class="btn btn-outline-primary">결제하기</button>
					<button type="button" class="btn btn-outline-danger" onclick="history.back()">취소</button>
				</div>
			
			</form>
			
			
			<!-- 준비중 div -->
			<div class="modal" id="readyModal">
				<div class="modal-dialog">
					<div class="modal-content">
		
						<!-- Modal body -->
						<div class="modal-body">
							<div class="form-group" id="modal-delete-content">
								<div class="small-modal-content icon-content" id="small-modal-delete-content">
								    <span class="infd-icon"><svg width="56" aria-hidden="true" focusable="false" data-prefix="fal" data-icon="exclamation-triangle" class="svg-inline--fa fa-exclamation-triangle fa-w-18" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"><path fill="#FFA016" d="M270.2 160h35.5c3.4 0 6.1 2.8 6 6.2l-7.5 196c-.1 3.2-2.8 5.8-6 5.8h-20.5c-3.2 0-5.9-2.5-6-5.8l-7.5-196c-.1-3.4 2.6-6.2 6-6.2zM288 388c-15.5 0-28 12.5-28 28s12.5 28 28 28 28-12.5 28-28-12.5-28-28-28zm281.5 52L329.6 24c-18.4-32-64.7-32-83.2 0L6.5 440c-18.4 31.9 4.6 72 41.6 72H528c36.8 0 60-40 41.5-72zM528 480H48c-12.3 0-20-13.3-13.9-24l240-416c6.1-10.6 21.6-10.7 27.7 0l240 416c6.2 10.6-1.5 24-13.8 24z"></path></svg></span>
								    <span class="description">서비스 준비중입니다.</span>
								    
								  </div>
							</div>
						</div>
		
						<!-- Modal footer -->
						<div class="modal-footer">
							<button type="button" class="btn btn-outline-primary" data-dismiss="modal">닫기</button>
						</div>
		
					</div>
				</div>
			</div>
			
		</div>
	</section>
</body>
</html>