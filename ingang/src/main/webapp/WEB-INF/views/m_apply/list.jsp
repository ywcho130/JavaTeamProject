<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멘토 지원자 목록</title>
</head>
<body>
<div class="mento" style = "width: 90%; margin: auto; margin-top: 70px; margin-bottom: 50px;">
	<table class="table">
				<thead>
					<tr>
						<th>번호</th>
						<th>분야</th>
						<th>경력 인증</th>
						<th>아이디</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list }" var="vo">
						<tr class="dataRow">
							<td class="mno">${vo.ano }</td>
							<td>${vo.field }</td>
							<td>${vo.cer_career }</td>
							<td class="id">${vo.id }</td>
						</tr>
					</c:forEach>
					
				</tbody>
			</table>
<div>
				<pageNav:pageNav listURI="list.do" pageObject="${pageObject }" />
			</div>
			</div>
			
</body>
</html>