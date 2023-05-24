<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style type="text/css">
.filters-content {
	background: #ddd;
}

.table {
	background: #eee;
	border-radius: 45px 45px 45px 45px;
	border-collapse: collapse;
}

tr, td, th {
	border-bottom: hidden;
	border-top: hidden;
}

.show {
	border-bottom: thin;
	border-top: medium;
}

.br {
	border: solid 2px;
	height: 1px;
	color: #aaa;
}

#bookTable:hover {
	cursor: pointer;
	background: #ccc;
}
</style>
<title>교재 결제</title>
<script type="text/javascript">

	$(function() {
		// 배송 정보 변경 버튼 클릭
		$(".dlvChangeBtn").click(function(){
			// 모달보여주기
			$("#dlvChangeModal").modal("show");
			// 페이지 이동 막기
			return false;
		});
		
// 		// 모달창 변경 버튼 클릭
		$("#formStatusModifyBtn").click(function(){
			// 원래 정보
			let name = $(".dataRow").find(".name").html();
			// 바꾼 정보
			let cname = $("#modalName").val();
			// 바꾼정보로 세팅
			$(".dataRow").find(".name").html(cname);
			$("#name").val(cname);
			// 원래 정보
			let dlvAdress = $(".dataRow").find(".dlvAdress").html();
			// 바꾼 정보
			let cdlvAdress = $("#modalDlvAdress").val();
			// 바꾼정보로 세팅
			$(".dataRow").find(".dlvAdress").html(cdlvAdress);
			$("#dlvAdress").val(cdlvAdress);

			// 원래 정보
			let tel = $(".dataRow").find(".tel").html();
			// 바꾼 정보
			let ctel = $("#modalTel").val();
			// 바꾼정보로 세팅
			$(".dataRow").find(".tel").html(ctel);
			// 모달창 숨기기
			$("#dlvChangeModal").modal("hide");
			$("#tel").val(ctel);
			
		});
		
		
		// 교재 테이블 클릭
		$("#bookTable").click(function() {
			// 교재번호 가져오기
			var no = $(this).find(".bookNo").text();
			// 교재 view로 보내기
			location = "/book/view.do?no=" + no 
		});

		// 구매버튼 클릭 
		$(".buyBtn").click(function(){
			// 구매 폼 전송
			$("#buyForm").submit();
			alert("구매가 완료 되었습니다.");
		});
		
		
	});
</script>
</head>
<body class="sub_page">
	<section class="layout_padding">
		<div class="container">
			<h1>교제 결제</h1>
			<div class="filters-content">
				<form class="buyForm" action="/order/buy.do" method="post">
					<input type="hidden" name="dlvAdress" id="dlvAdress" value="${member.address }">
					<input type="hidden" name="name" id="name" value="${member.name }">
					<input type="hidden" name="tel" id="tel" value="${member.tel }">
					<table class="table">
						<br />
						<tbody>
							<tr class="dataRow">
								<th width="60%">받는 사람</th>
								<td class="name">${member.name }</td>
								
							</tr>
							<tr class="dataRow">
								<th>배송지</th>
								<td class="dlvAdress">${member.address }</td>
							</tr>
							<tr class="dataRow">
								<th>전화번호</th>
								<td class="tel">${member.tel }</td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
								<th></th>
								<td>
									<button type="button" class="btn btn-secondary dlvChangeBtn"
										style="margin-left: 150px;">배송정보변경</button>
								</td>
							</tr>
						</tfoot>
					</table>
					<div class="br"></div>
					<br />
					<table class="table" id="bookTable">
						<tbody>
							<tr>
								<td style="width: 60%;"><img width="250px" height="250px"
									alt="" src="${book.fileName }"></td>
								<td>
									<h3>${book.bookName }</h3> <br> <br>구분:${book.bookDiv }
									<br>가격:${book.price } <br> <span class="odquantity">개수:${vo.odquantity }
										<input name="odquantity" value="${vo.odquantity }" hidden="" />
								</span>
								</td>
							</tr>
							<tr>
								<td class="bookNo" hidden="">${book.bookNo }<input
									name="bookNo" value="${book.bookNo }" hidden="" />
								</td>

							</tr>
						</tbody>
					</table>
					<div class="br"></div>
					<br />
					<table class="table">
						<tbody>
							<tr>
								<th><h3>최종 결제 금액</h3></th>
							</tr>
							<tr>
								<th>상품 가격</th>
								<td>${book.price }원</td>
							</tr>
							<tr>
								<th>결제수단</th>
								<td><label>결제수단</label> <select name="payMethod"
								class="custom-select mb-3">
								<option selected>결제수단을 선택하세요</option>
								<option value="카드결제">카드결제</option>
								<option value="카카오페이">카카오페이</option>
								<option value="네이버페이">네이버페이</option>
							</select></td>
							</tr>
							<tr class="br"></tr>
							<tr class="show">
								<th><h3>총 결제 금액</h3></th>
								<td><h3>${vo.totalPrice }원</h3> <input name="totalPrice"
									value="${vo.totalPrice }" hidden="" /></td>
							</tr>
						</tbody>
					</table>
					<div class="">
						<div class="box"></div>
					</div>

					<button class="btn btn-primary buyBtn"
						style="margin: auto; width: 1110px; height: 50px;">결제하기</button>

				</form>
			</div>
		</div>
		<!-- 배송 정보 수정 모달창  -->
		<div id="dlvChangeModal" class="modal fade" role="dialog">
			<div class="modal-dialog">

				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">배송 정보 변경</h4>
						<button type="button" class="close" data-dismiss="modal">×</button>
					</div>
					<div class="modal-body">
						<form action="buy.do" method="get" id="CDModifyForm">
							<div class="form-group">
								<label for="name">받는사람</label> <input name="name" id="modalName"
									class="form-control" value="${member.name }">
							</div>
							<div class="form-group">
								<label for="dlvAdress">배송지</label> <input name="dlvAdress"
									id="modalDlvAdress" class="form-control"
									value="${member.address }">
							</div>
							<div class="form-group">
								<label for="tel">전화번호</label> <input name="tel" id="modalTel"
									class="form-control" value="${member.tel }">
							</div>

						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default"
							id="formStatusModifyBtn">변경</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					</div>
				</div>


			</div>
		</div>
	</section>
</body>
</html>