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
<title>공지사항 등록 폼</title>
</head>
<body class="sub_page">
	<section class="layout_padding">
		<div class="container">
			<h1>공지사항 글 등록 폼</h1>
		</div>
		<div class="formform">
			<form action="write.do" method="post">
				<div class="form-group">
					<label>제목</label>
					 <input name="title" class="form-control" placeholder="※ 필수로 입력하셔야 합니다.">
				</div>
				<div class="form-group">
					<label>내용</label>
					<textarea name="content" cols="50" rows="7"  class="form-control" placeholder="※ 필수로 입력하셔야 합니다." required></textarea>
				</div>
				<div class="form-group">
					<label>시작일</label>
					 <input name="startDate" class="form-control" type="date">
				</div>
				<div class="form-group">
					<label>종료일</label>
					 <input name="endDate" class="form-control" type="date">
				</div>
				<button class="btn btn-dark">등록</button>
				<button type="reset" class="btn btn-danger">새로입력</button>
				<button type="button" id="cancelBtn" class="btn btn-info">취소</button>
			</form>
		</div>
	</section>
</body>
</html>