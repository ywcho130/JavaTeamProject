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
<script type="text/javascript">
$(function(){

	<c:if test="${msg != null}">
		$("#messageModal").modal("show");
	</c:if>

	// 검색 데이터 유지
	<c:if test="${!empty pageObject.word}">
		$("#key").val("${(!empty pageObject.key)?pageObject.key:'t'}");
		$("#word").val("${pageObject.word}");
	</c:if>
	
	$(".dataRow").click(function(){
		var ordNo = $(this).find(".ordNo").text();
		location = "view.do?ordNo=" + ordNo 
		+ "&page=${pageObject.page}&perPageNum=${pageObject.perPageNum}"
		+ "&key=${pageObject.key}&word=${pageObject.word}"
		;
	});

	$(".changeDCBtn").click(function(){
		var ordNo = $(this).closest(".dataRow").find(".ordNo").text();
		$("#modalOrdNo").val(ordNo);
		var dlvCondition = $(this).closest(".dataRow").find(".dlvCondition").text();
		$(".dlvStatus").val([dlvCondition]);
		$("#DCModal").modal("show");
		return false;
	});

	$("#formStatusModifyBtn").click(function(){
		// 폼의 데이터 전송하기 -> 폼객체.submit()
		$("#DCModifyForm").submit();
	});
});
</script>
<style type="text/css">
.dataRow:hover {
	cursor: pointer;
	background: #eee;
}
</style>
<title>주문 리스트</title>
</head>
<body class="sub_page">
	<section class="layout_padding">
		<div class="container">
			<h1>주문 리스트</h1>
			<div class="row">
				<div class="col-md-12">
					<form action="list.do" method="post">
						<input type="hidden" name="perPageNum"
							value="${pageObject.perPageNum }">
						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<select class="form-control" id="key" name="key">
									<option value="t">주문번호</option>
									<option value="c">아이디</option>
									<option value="w">배송상태</option>
<!-- 									<option value="tc">주문번호/아이디</option> -->
<!-- 									<option value="tw">주문번호/배송상태</option> -->
<!-- 									<option value="cw">아이디/배송상태</option> -->
<!-- 									<option value="tcw">모두</option> -->
								</select>
							</div>
							<input type="text" class="form-control" placeholder="Search"
								id="word" name="word">
							<div class="input-group-append">
								<button class="btn btn-success" type="submit">검색</button>
							</div>
						</div>

					</form>
				</div>
			</div>
			<table class="table">
				<thead>
					<tr>
						<th>주문번호</th>
						<th>아이디(이름)</th>
						<th>주문일자/도착일</th>
						<th>교재이미지</th>
						<th>교재제목(구분)</th>
						<th>배송상태</th>
						<th>총 가격</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list }" var="vo">
						<tr class="dataRow">
							<td class="ordNo">${vo.ordNo }</td>
							<td>${vo.id }(${vo.name })</td>
							<td><fmt:formatDate value="${vo.orderDate }"
									pattern="yyyy-MM-dd" />/<br><fmt:formatDate
									value="${vo.arriveDate }" pattern="yyyy-MM-dd" /></td>
							<td><img alt="${vo.fileName }" src="${vo.fileName }" width="120px" height="100px"></td>
							<td>${vo.bookName }(${vo.bookDiv })<br>(${vo.quantity }개)</td>
							<td><span class="dlvCondition">${vo.dlvCondition }</span>
							<button class="changeDCBtn">변경</button></td>
							<td>${vo.totalPrice }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div><pageNav:pageNav listURI="list.do" pageObject="${pageObject }" /></div>
		</div>
		<!-- 배송 상태 변경 Modal -->
		<div id="DCModal" class="modal fade" role="dialog">
			<div class="modal-dialog">

				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">배송 상태 수정</h4>
						<button type="button" class="close" data-dismiss="modal">×</button>
					</div>
					<div class="modal-body">
						<form action="update.do" method="post" id="DCModifyForm">
							<input type="hidden" name="page" value="${pageObject.page }">
							<input type="hidden" name="perPageNum"
								value="${pageObject.perPageNum }"> <input type="hidden"
								name="key" value="${pageObject.key }"> <input type="hidden"
								name="word" value="${pageObject.word }">
							<div class="form-group">
								<label for="ordNo">주문번호</label> <input name="ordNo"
									id="modalOrdNo" readonly="readonly" class="form-control">
							</div>
							<div class="form-group">
								<div>
									<label>배송 상태</label>
								</div>
								<label class="radio-inline"> <input type="radio"
									name="dlvCondition" class="dlvStatus" value="배송준비중">배송준비중
								</label> <label class="radio-inline"> <input type="radio"
									name="dlvCondition" class="dlvStatus" value="배송중">배송중
								</label> <label class="radio-inline"> <input type="radio"
									name="dlvCondition" class="dlvStatus" value="배송완료">배송완료
								</label>
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