<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유저상세정보</title>
<!--   <meta name="viewport" content="width=device-width, initial-scale=1"> -->
<!--   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"> -->
<!--   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script> -->
<!--   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script> -->
<style type="text/css">
.dataRow:hover {
	background: #eee;
	cursor: pointer;
}

 
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
function myFunction() {
	  var x = document.getElementById("myText");
	  if (x.style.display === "none") {
	    x.style.display = "block";
	  } else {
	    x.style.display = "none";
	  }
	}
</script>



</head>
<body>
	<img alt="" src="">
	<div class="card shadow md-4">
		<div class="card-header py-3">게시판 글보기</div>
		<div class="card-body">
			<table class="table">
				<tbody>
					<tr>

						<th>이미지</th>
						<td><img alt="" src=""></td>
					</tr>
					<tr>
						<th>아이디</th>
						<td>${vo.id }</td>
					</tr>
					<tr>
						<th>이름</th>
						<td>${vo.name }</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td>${vo.email }</td>
					</tr>
					<tr>
						<th>등록일</th>
						<td>${vo.regDate}</td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td>${vo.tel}</td>
					</tr>
					
					<tr>
						<th>맨토</th>
						<td>${vo.mento }</td>
					</tr>

					<tr>
						<th>상태</th>
						<td>${vo.status }</td>
					</tr>

					<tr>
						<th>등급</th>
						<td>${vo.gradeName }</td>
					</tr>

					<tr>
						<th>주소</th>
						<td>${vo.address }
							<button onclick="myFunction()">수정</button>

						<div id="myText" style="display:none;"> 
						<form action="changeAd.do" method="post">
						주소<input name="address"> <input type="hidden" name="id" value=${vo.id}><button>입력</button>
						</form>
						
						</div>
							</td>

					</tr>
				</tbody>
			</table>


		</div>
	</div>




</body>
</html>