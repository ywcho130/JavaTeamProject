<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강의 결제 완료</title>

<style type="text/css">
.layout_padding{
	padding: 10px 0 90px 0;
}
.boldText{
	color: black;
	font-weight: bold;
}
h3 {
  color: #666; /* 글자색 */
  font-size: 16px; /* 폰트 크기 */
  font-weight: bold; /* 굵게 */
  text-align: center; /* 가운데 정렬 */
}
.path {
 margin-top:15px;

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
.login-btn {
  background-color: #187FD9; /* 버튼 배경색 */
  color: white; /* 버튼 글자색 */
  border: none; /* 버튼 테두리 없음 */
  padding: 12px 24px; /* 버튼 패딩 */
  text-align: center; /* 버튼 텍스트 가운데 정렬 */
  text-decoration: none; /* 버튼 텍스트에 밑줄 없음 */
  display: inline-block; /* 버튼을 inline 요소로 변경 */
  font-size: 16px; /* 버튼 글자 크기 */
  margin: 4px 0; /* 버튼 마진 */
  cursor: pointer; /* 커서 모양 변경 */
  border-radius: 4px; /* 버튼 모서리 둥글게 */
  flex-basis: calc((100% - 10px) / 2); /* 요소들의 너비를 계산하여 설정 */
  max-width: calc((100% - 10px) / 2); /* 요소들의 최대 너비를 계산하여 설정 */
  box-sizing: border-box; /* padding과 border를 포함한 크기로 지정 */
  transition: background-color 0.3s; /* 배경색 변경 시 부드럽게 */
  
}
.login-btn:hover{
	color: black;
}
.padding{
	padding: 10px 0;
}

</style>
<script type="text/javascript">

$(function(){
	
	$("#viewList").click(function(){
		// 내 결제 리스트로 이동
		location="/enroll/orderList.do";
	});

	$("#viewDetail").click(function(){
		// 방금 결제한 내역으로 이동
		location="/enroll/viewDetail.do?all=0";
	});
	
});

</script>

</head>
<body>

	<section class="layout_padding">
		<div class="container">
		
			<div class="path">
			  <span>Home</span>
			  <span>강의결제</span>
			  <span>강의결제 완료</span>
			</div>
			
			<div class="padding" style="text-align: center;">
			<i class="fa fa-check-circle-o" style="font-size:80px;color:#187FD9;"></i>
			</div>
			
			<div class="padding" style="text-align: center;">
				<h1><span class="boldText">강의 결제 완료</span></h1>
				<h3>결제가 완료되었습니다.</h3>
			</div>
		
			<div class="padding" style="text-align: center;">
				<button type="button" id="viewList" class="btn login-btn">강의 결제 리스트로 이동</button>
				<button type="button" id="viewDetail" class="btn login-btn">결제 상세보기</button>
			</div>
		
		</div>
	</section>

</body>
</html>