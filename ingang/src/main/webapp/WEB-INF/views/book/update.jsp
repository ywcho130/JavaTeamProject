<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.formform{
	margin-left:380px;
	margin-right:700px;
}
</style>
<script type="text/javascript">
$(function() {
 	$("#cancelBtn").click(function() {
 		history.back();
 	});
});
</script>
<meta charset="UTF-8">
<title>교재 수정 폼</title>
</head>
<body class="sub_page">
	<section class="layout_padding">
		<div class="container">
			<h1>교재 수정 폼</h1>
		</div>
		<div class="formform">
			<form action="update.do" method="post">
				<!-- 페이지 정보 세팅 -->
				<input type="hidden" name="page" value="${param.page }">
				<input type="hidden" name="perPageNum" value="${param.perPageNum }">
				<input type="hidden" name="key" value="${param.key}">
				<input type="hidden" name="word" value="${param.word }">
				<div class="form-group">
					<label>책번호</label>
					<input name="bookNo" class="form-control" readonly="readonly" value="${vo.bookNo }">
				</div>
				<div class="form-group">
					<label>교재명</label>
					 <input name="bookName" class="form-control" value="${vo.bookName }" placeholder="※ 필수로 입력하셔야 합니다." required>
				</div>
				<div class="form-group">
					<label>책소개</label>
					<textarea name="bookIntroduce" rows="7" class="form-control" placeholder="※ 필수로 입력하셔야 합니다." required>${vo.bookIntroduce }</textarea>
				</div>
				<div class="form-group">
					<label>과목(영역) ※ 필수로 선택하셔야 합니다.</label>
					<div class="form-check row">
					<label class="radio-inline"><input
						type="radio" name="bookDiv" id="bookDiv" value="JAVA" >JAVA
					</label> <label class="radio-inline"> <input type="radio"
						name="bookDiv" id="" value="Jsp/Servlet" class="form-chek-input">Jsp/Servlet
					</label> <label class="radio-inline"> <input type="radio"
						name="bookDiv" id="bookDiv" value="Spring" class="form-chek-input">Spring
					</label>
					</div>
				</div>
					<div class="form-group">
						<label>출판사</label>
						<input name="publisher" id="publisher" class="form-control" value="${vo.publisher }" placeholder="※ 필수로 입력하셔야 합니다." required>
					</div>
					<div class="form-group">
						<label>수량<span style="font-size:small;"> ※ 숫자 1~4자리만 입력 가능합니다.</span></label> 
						<input name="quantity" id="quantity" class="form-control" value="${vo.quantity}" pattern="[0-9]{1,4}" title="숫자 1~4자리만 입력 가능합니다." placeholder="※ 숫자 1~4자리만 입력 가능합니다." required>
					</div>
					<div class="form-group">
						<label>발행일</label> 
						<input name="pubDate1" id="pubDate1" class="form-control" value="${pubDate }" type="date" required>
					</div>
					<div class="form-group">
						<label>가격</label> 
						<input name="price" id="price" class="form-control" value="${price }" placeholder="※ 숫자만 입력가능합니다." pattern="^[0-9]*$" required>
					</div>
				<button class="btn btn-dark">수정</button>
				<button type="reset" class="btn btn-danger">새로입력</button>
				<button type="button" id="cancelBtn" class="btn btn-info">취소</button>
			</form>
		</div>
	</section>
</body>
</html>