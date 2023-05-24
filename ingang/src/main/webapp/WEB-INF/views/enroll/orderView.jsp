<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강의 결제 상세내역</title>
<style type="text/css">
.info{
	flex-direction: row;
}
.dataRow{
	padding-right : 0;
	padding-left : 0;
	max-width: 2px;
}
.pno{
	display: none;
}
.tableRow:last-child{
	border-bottom: 1px solid #dee2e6; 
}
.filters-content{
	padding: 20px 0;
}
.red{
	color: red;
	font-weight: 500;
}
.blue{
	color: blue;
	font-weight: 500;
}
.black{
	color:black;
	font-weight: 500;
}
.font{
	color: #888;
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
.layout_padding{
	padding: 10px 0 90px 0;
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
.dt{
	font-weight: 700;
	min-width: 120px;
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
.info{
	margin: 40px 0 20px 0;
}

</style>

<script type="text/javascript">

$(function(){
	// 취소 버튼 이벤트
	$("#cancelDivBtn").click(function(){
		// 체크박스중 선택된것들 가져오기
		const checkboxes = $("input[name='pnoListCheck']:checked");
	  
		if (checkboxes.length === 0) { // 선택된 체크박스가 없을 경우
		  alert("취소할 강의를 선택해주세요.");
		  return;
		}

		// 취소 모달창 열기
		$("#cancelModal").modal("show");
		// 모달창에 데이터 보내기
		showCancelDiv();
	});

	// 모두 선택 체크박스의 변경 이벤트를 감지하여 모든 체크박스 선택 또는 해제
	$("#selectAll").change(function(){
	  const checkboxes = $("input[name='pnoListCheck']:not(:disabled)"); // 비활성화된 체크박스는 제외
	  checkboxes.prop('checked', this.checked);
	  $("#allCancel").val(this.checked ? "1" : "0"); // allCancel 값을 1 또는 0으로 변경
	});

	// 강의 상세내역의 체크박스 변경 이벤트를 감지하여 모두 선택 체크박스 상태 변경
	$("input[name='pnoListCheck']").change(function() {
	  const checkboxes = $("input[name='pnoListCheck']:not(:disabled)"); // 비활성화된 체크박스는 제외
	  const allChecked = checkboxes.length === checkboxes.filter(":checked").length;
	  $("#selectAll").prop("checked", allChecked);
	  $("#allCancel").val("0"); // 체크박스가 변경되면 allCancel 값을 0으로 변경
	});

	// 모든 체크박스가 disabled면 모두선택 체크박스도 disabled
	const checkboxes = $("input[name='pnoListCheck']");
	const allDisabled = checkboxes.length === checkboxes.filter(":disabled").length;
	$("#selectAll").prop("disabled", allDisabled);

	// 모달창의 취소 버튼 클릭 이벤트
	$("#cancelBtn").click(function(){
		// 폼 전송
		$("#cancelForm").submit();
	});

	// 목록으로 버튼 이벤트
	$("#listBtn").click(function(){
		var all = ${param.all};
		
		if(all === 1){ // 관리자 리스트
			location="/enroll/orderListAll.do";
		} else { // 내 리스트
			location="/enroll/orderList.do";
		}
	});

});
</script>

</head>
<body>
	<section class="layout_padding">
		<div class="container">
		<c:if test="${param.all == 0 }">
			<div class="path">
			  <span>Home</span>
			  <span>강의 결제내역</span>
			  <span>결제 상세내역</span>
			</div>
		</c:if>
			
		<c:if test="${param.all == 1 }">
			<div class="path">
			  <span>Home</span>
			  <span>회원 강의 결제내역</span>
			  <span>결제 상세내역</span>
			</div>
		</c:if>
		
			<h1 style="color:#333333">강의 결제 상세내역</h1>
				
				<div class="card info">
					<c:forEach items="${view }" var="vo" begin="0" end="0">
					<div class="col-md-5 font">- 주문번호 : <span class="red">${vo.eno }</span></div>
					<div class="col-md-5 font">- 주문일 : <span class="black"><fmt:formatDate value="${vo.payDate }" pattern="yyyy-MM-dd"/></span></div>
					<div class="col-md-2 font">
					<c:if test="${vo.status == '결제완료' }">
						<span class="blue">${vo.status }</span>
					</c:if>
					<c:if test="${vo.status == '취소' }">
						<span class="red">${vo.status }</span>
					</c:if>
					</div>
					</c:forEach>
				</div>
				
				<div class="filters-content">
				<div class="content-title">
<!-- 					<i class="fa fa-circle-o"></i>  -->
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-align-bottom" viewBox="0 0 16 16">
					  <rect width="4" height="12" x="6" y="1" rx="1"/>
					  <path d="M1.5 14a.5.5 0 0 0 0 1v-1zm13 1a.5.5 0 0 0 0-1v1zm-13"/>
					</svg>결제 강의
				</div>
					<table class="table">
						<thead>
							<tr>
								<th colspan="2">
								<input type="checkbox" id="selectAll" name="selectAll" onclick="toggleCheckbox(this, 'pnoListCheck')"> 모두 선택	
								</th>
								<th>강의명</th>
								<th>결제가격</th>
								<th>결제상태</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${view }" var="vo" varStatus="status">
							<tr class="tableRow">
								<td class="dataRow">
									<input name="pnoListCheck" type="checkbox" value=${vo.pno }  ${vo.payStatus eq '취소' ? 'disabled' : ''}>
								</td>
								<td class="pno">${vo.pno }</td>
								<td><img src="${vo.image }" height="100px"></td>
								<td><a href="/course/view.do?no=${vo.no }&page=1&perpageNum=10&key=&word=">[개강일:<fmt:formatDate value="${vo.startDate }" pattern="yyyy-MM-dd"/>] ${vo.title } - ${vo.teacher_name }</a></td>
								<td class="priceCheck"><fmt:formatNumber value="${vo.price }" pattern="#,###" /> 원</td>
								<td class="${vo.payStatus eq '취소' ? 'red' : 'blue'}">${vo.payStatus }</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>

				<div class="filters-content">
				<div class="content-title">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-align-bottom" viewBox="0 0 16 16">
					  <rect width="4" height="12" x="6" y="1" rx="1"/>
					  <path d="M1.5 14a.5.5 0 0 0 0 1v-1zm13 1a.5.5 0 0 0 0-1v1zm-13"/>
					</svg>결제 정보
				</div>
						
					<c:forEach items="${view }" var="vo" begin="0" end="0">
					<div class="formDiv info">
						<div class="info-content">
							<span class="dt">총 결제금액</span> 
							<span class="dd">
								<span class="blue"><fmt:formatNumber value="${vo.totalprice }" pattern="#,###" /></span> 원
								( 환불금액 : <span class="red"><fmt:formatNumber value="${vo.cancelprice }" pattern="#,###" /></span> 원 )
							</span>
						</div>
						<div class="info-content">
							<span class="dt">결제수단</span> 
							<span class="dd">${vo.payMethod }</span>
						</div>
					</div>
					</c:forEach>
						
				</div>
				
			
			<button type="button" id="listBtn" class="btn btn-outline-primary">목록으로</button>
			<button type="button" id="cancelDivBtn" class="btn btn-outline-danger">결제 취소</button>
			
			<!-- 결제 취소 모달 -->
			<div class="modal" id="cancelModal">
				<div class="modal-dialog">
					<div class="modal-content">
		
						<!-- Modal Header -->
						<div class="modal-header">
							<h4 class="modal-title" id="cancelModalTitle">강의 결제 취소</h4>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
		
						<!-- Modal body -->
						<div class="modal-body">
							<form action="/enroll/delete.do" method="post" id="cancelForm">
								<c:forEach items="${view }" var="vo" varStatus="status">
									<c:if test="${status.index == 0 }">
										<input type="hidden" name="eno" value="${vo.eno }">
									</c:if>
								</c:forEach>
								<input type="hidden" name="pnoList">
								<input type="hidden" name="priceList">
								<input type="hidden" name="allCancel" id="allCancel">
								
							</form>
							<span>결제를 취소 하시겠습니까?</span>
						</div>
		
						<!-- Modal footer -->
						<div class="modal-footer">
							<button type="button" class="btn btn-outline-primary" id="cancelBtn">확인</button>
							<button type="button" class="btn btn-outline-danger" data-dismiss="modal">닫기</button>
						</div>
		
					</div>
				</div>
			</div>
			
		</div>
	</section>
	
	<script>
	// 선택된 체크박스의 pno 값을 숨겨진 input 태그에 할당하여 폼 전송
	function showCancelDiv() {
	const checkAll = document.querySelector("input[name='selectAll']");
	const checkBoxes = document.getElementsByName("pnoListCheck");
	const selectedPnoList = [];
	const selectedPriceList = [];

	// 선택된 체크박스 마다 pno와 price 가져오기
	for (let i = 0; i < checkBoxes.length; i++) {
		if (checkBoxes[i].checked) {
			selectedPnoList.push(checkBoxes[i].value);
	
	  		const priceElement = checkBoxes[i].closest(".tableRow").querySelector(".priceCheck");
	     	if (priceElement) {
	       		selectedPriceList.push(priceElement.textContent.replace(/[^\d]/g, ""));
	    	}        
		}
	}

	if(checkAll.checked){ // 전체선택 체크 되어있으면 1
	$("#allCancel").val("1")
	} else{ // 전체선택 체크 안되어있으면 0
	$("#allCancel").val("0")
	}
	
	// pno 리스트를 폼 안에 있는 hidden input 태그에 할당
	const pnoListInput = document.querySelector("#cancelForm input[name='pnoList']");
	pnoListInput.value = selectedPnoList.join();
	// price 리스트를 폼 안에 있는 hidden input 태그에 할당
	const priceListInput = document.querySelector("#cancelForm input[name='priceList']");
	priceListInput.value = selectedPriceList.join();
		
	}
	
	function toggleCheckbox(checkbox, name) {
		const checkboxes = document.getElementsByName(name);
		for (let i = 0; i < checkboxes.length; i++) {
			checkboxes[i].checked = checkbox.checked && !checkboxes[i].disabled;
		}
	}
  
</script>
	
</body>
</html>