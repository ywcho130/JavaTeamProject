<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멘토링 신청하기</title>
<style type="text/css">
</style>
</head>
<body>
<script type="text/javascript">
$(function(){

	let avaStartDate = $("#avaStartDate").html();
	let avaEndDate = $("#avaEndDate").html();

	
	console.log(avaStartDate);
	console.log(avaEndDate);
	
	  var resDate = document.getElementById("resDate");
	  var resTime = document.getElementById("resTime");
	  // 선택한 날짜를 콘솔에 출력하고, 선택한 날짜와 avaStartDate, avaEndDate를 비교하여 예약 가능 여부를 확인하고 알림을 표시
	  // 만약 선택한 날짜가 예약 가능한 범위를 벗어난다면, 알림을 표시하고 선택한 날짜를 초기화.
	  if (resDate) {
	    resDate.addEventListener("change", function() {
	      console.log(resDate.value); 
	      var selectedDate = new Date(resDate.value);
	      var minDate = new Date(avaStartDate);
	      var maxDate = new Date(avaEndDate);
	      if (selectedDate < minDate || selectedDate > maxDate) {
	        alert("선택한 날짜는 예약이 불가능합니다.");
	        resDate.value = "";
	      };
	    });
	  } else {
	    console.error("'resDate'를 찾을 수 없음")
	  }
	
	  
	};
</script>
<div class="mento" style = "width: 90%; margin: auto; margin-top: 70px; margin-bottom: 50px;">
	<div class="card shadow md-4">
		<div class="card-header py-3"></div>
		<div class="card-body">
<div id="avaStartDate" style="display: none;">
<fmt:formatDate value="${vo.avaStartDate }" pattern="yyyy-MM-dd"/>
</div>
<div id="avaEndDate" style="display: none;">
<fmt:formatDate value="${vo.avaEndDate }" pattern="yyyy-MM-dd"/>
</div>
			<form action="write.do" method="post" id="writeForm">
				
				
				<input type="hidden" name="mid" value="${vo.mid }">
				<input type="hidden" name="aid" value="${login.id }">
				<input type="hidden" name="mno" value="${vo.mno }">
				<input type="hidden" name="field" value="${vo.field }">
				<input type="hidden" name="memberimg" value="${login.memberimg }">
				
					<h4>스케줄 설정 </h4>
					<div class="form-group">
    날짜 선택 <fmt:formatDate value="${vo.avaStartDate }" pattern="yyyy-MM-dd"/>~
				   <fmt:formatDate value="${vo.avaEndDate }" pattern="yyyy-MM-dd"/>:
				    <input type="date" id="resDate" name="resDate" required="required" 
				           min="${vo.avaStartDate}" max="${vo.avaEndDate}">
				    <c:forEach items="${resDateList}" var="reservedDate">
				        <c:if test="${reservedDate eq resDate}">
				            <label style="color: red;">이미 예약이 꽉 찬 날짜입니다.</label>
				        </c:if>
				    </c:forEach>
					</div>
				<div class="form-group">
    시간 선택:
		    <select id="resTime" name="resTime">
		        <option value="" selected disabled>시간선택</option>
		        <!-- foreach로 시간 범위 순회  -->
		        <c:forEach begin="${vo.avaStartTime }" end="${vo.avaEndTime-1 }" var="num">
		        <!-- ${resTime.contains(num)}해당 시간이 이미 예약되어있는지 판단 후 선택 불가능하게 함(disabled) -->
		            <c:choose>
		                <c:when test="${resTime.contains(num)}">
		                    <option value="${num}" disabled>${num}:00~${num+1}:00</option>
		                </c:when>
		                <!-- 예약되지 않은 시간에 대해서는 <option> 요소를 일반적으로 생성하며,
		                     ${num}:00~${num+1}:00와 같이 시간 범위를 표시 -->
		                <c:otherwise>
		                    <option value="${num}">${num}:00~${num+1}:00</option>
		                </c:otherwise>
		            </c:choose>
		        </c:forEach>
		    </select>
		</div>
				<div>			
			
					
				</div>
				
				<div class="form-group">
					<label>멘토에게 한마디</label> <input name="greetings" class="form-control"
						id="greetings">
				</div>
				<div class="form-group">
					<label>수강료</label> <input name="lecFee" id="lecFee" readonly="readonly" value="${vo.lecFee }">
				</div>

				<button class="btn btn-success">신청하기</button>
				<button type="reset" class="btn btn-success">새로입력</button>
				<button type="button" class="btn btn-success"
					onclick="history.back()">취소</button>
			</form>
		</div>
	</div>
</div>



</body>
</html>