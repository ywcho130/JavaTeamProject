<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="jquery-ui.css" rel="stylesheet">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<title>멘토 지원하기 </title>
</head>
<body>
<div class="mento" style = "width: 90%; margin: auto; margin-top: 70px; margin-bottom: 50px;">
	<div class="card shadow md-4">
		<div class="card-header py-3"></div>
		<div class="card-body">
			<form action="write.do" method="post" id="writeForm">
			<!-- 임의로 로그인 -->
			<input type="hidden" name="id" value="${login.id }">
				<div class="form-group">
					<label>분야</label> <select name="field" id="field"
						class="form-control">
						<option value="개발/프로그래밍">개발/프로그래밍</option>
						<option value="학문/외국어">학문/외국어</option>
						<option value="게임개발">게임개발</option>
						<option value="직무/마케팅">직무/마케팅</option>
						<option value="보안">보안</option>
						<option value="커리어">커리어</option>
						<option value="디자인">디자인</option>
						<option value="데이터 사이언스">데이터 사이언스</option>
					</select>
				</div>
				<div class="form-group">
					<label>경력 인증</label> <input name="cer_career" class="form-control"
						id="cer_career">
				</div>
				

				<button class="btn btn-success">지원하기</button>
				<button type="reset" class="btn btn-success">새로입력</button>
				<button type="button" class="btn btn-success"
					onclick="history.back()">취소</button>
			</form>
		</div>
	</div>
</div>

</html>