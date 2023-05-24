<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.dataRow{
	margin-left:80px;
}
#updateBtn{
	float:right;
	margin-right:10px;
}
#deleteBtn{
	float:right;	
}
#listBtn{
	margin-right:10px;
	float:right;	
}
.title{
	font-weight: bold;
}
.modal-header{
	background:#e6e6e6;
}
</style>
<script type="text/javascript">
$(function(){
	$("#updateBtn1").click(function(){
		if(!confirm("수정 하시겠습니까?")) return false;
	});
	$("#deleteBtn").click(function() {
		//alert("클릭함");
		if(!confirm("삭제 하시겠습니까?")) return false;
	});
});

</script>
</head>
<body>
	<div class="card shadow md-4">
		<div class="card-header py-3"><h4>공지사항 상세 보기</h4>
			<c:if test="${login !=null && login.gradeNo ==9 }">
				<a href="delete.do?no=${vo.no }"
					class="btn btn-danger" id="deleteBtn">삭제</a>
				<button type="button" data-toggle="modal" data-target="#update"
					 class="btn btn-secondary" id="updateBtn">수정</button>
			</c:if>
				<a href="list.do" class="btn btn-info" id="listBtn">리스트</a>
			<!-- 수정모달 -->
				<div class="modal" id="update">
					<div class="modal-dialog">
						<div class="modal-content">
						<!-- Modal Header -->
						<div class="modal-header">
							<h4 class="modal-title">공지사항 글 수정</h4>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<!-- Modal Body -->
						<div class="modal-body">
							<form action="update.do" method="post">
								<input type="hidden" name="no" value="${vo.no }">
								<input type="hidden" name="page" value="${param.page }">
								<input type="hidden" name="perPageNum" value="${param.perPageNum }"> 
								<input type="hidden" name="key" value="${param.key }"> 
								<input type="hidden" name="word" value="${param.word }"> 
							<div class="form-group">
								<label>제목</label>
									<input name="title" value="${vo.title }" class="form-control" placeholder="※ 필수로 입력하셔야 합니다." required>								
								<label>내용</label>
									<textarea name="content" cols="50" rows="7"  class="form-control" placeholder="※ 필수로 입력하셔야 합니다." required><c:out value="${vo.content}" /></textarea>
								<label>시작일  / 종료일</label>
									<input name="startDate" value="${vo.startDate }" type="date"  class="form-control" required>
									<input name="endDate" value="${vo.endDate }" type="date" class="form-control" required>								
							</div>	
								<button id="updateBtn1" class="btn btn-success" style="float:right;">수정</button>
								<button type="reset" class="btn btn-danger"  style="float:right;">새로입력</button> 
							</form>
						</div>
						<!-- Modal footer -->
						<div class="modal-footer">
						</div>
						</div>
					</div>
				</div>
			</div>
		<div class="card-body">
			<div class="dataRow"><p style="display:none;">글번호&nbsp;:&nbsp;${vo.no }</p><br/>
				<h3 class="title">${vo.title }</h3>
				<p class="small"><fmt:formatDate value="${vo.updateDate}" pattern="yyyy년MM월dd일"/>&nbsp;&nbsp;조회&nbsp;:&nbsp;${vo.hit }</p><hr/>
			<div>
				<pre><c:out value="${vo.content}" /></pre>
			</div>
			<hr/>
			<p class="small">시작일&nbsp;:&nbsp;<fmt:formatDate value="${vo.startDate}" pattern="yyyy년MM월dd일"/>
			~&nbsp;종료일&nbsp;:&nbsp;<fmt:formatDate value="${vo.endDate}" pattern="yyyy년MM월dd일"/></p>
			</div>
		</div>
	</div>
</body>
</html>