<%@page import="com.ingang.member.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>교재 상세 보기</title>
<link rel="stylesheet" href="/css/review.css">
<style type="text/css">
#updateImo{
	background:#e6e6e6;
}
.title {
	margin-left: 80px;
}

#upBtn {
	margin-left: 80px;
}

.bi {
	margin-left: 20px;
	margin-right: 20px;
}

.img-box {
	display: table-cell;
	vertical-align: middle;
}

.img {
	margin-left: 80px;
	width: 300px;
	height: 380px
}

#data :hover {
	cursor: pointer;
	background: #d3d3d3;
}

.back {
	background: #eeeeee;
	border-radius: auto;
	background-size: auto;
}
.reply-box:hover {
	cursor: pointer;
	background: #eee;
	
}
</style>
<script type="text/javascript" src="/js/bookReview.js"></script>
<script type="text/javascript">
	$(function() {
		$("#qBtn").click(function() {
			alert("품절처리가 완료되었습니다.");
		});
		$("#updateImageShowBtn").click(function() {
			$("#updateImageDiv").show();
		});

		$("#hideBtn").click(function() {
			$("#updateImageDiv").hide();
		});

		$("#orderBtn").click(function() {
			if ("${vo.status}" == "품절") {
				alert("해당 상품은 품절입니다.");
				return;
			}
			let odquantity = $(".quantity-input").val();
			let price = ${vo.price};
			let totalPrice = odquantity * price;
			location = "/order/buy.do?no=" + ${vo.bookNo}+"&odquantity=" + odquantity + "&totalPrice=" + totalPrice;

		});
		// 관련강의로 이동
		$(".dataRow")
				.click(
						function() {
							var no = $(this).find(".cono").text();
							// 		alert("no" + no);
							location = "/course/view.do?no="
									+ no
									+ "&page=${pageObject.page}&perPageNum=${pageObject.perPageNum}"
									+ "&key=${pageObject.key}&word=${pageObject.word}";
						});
		$("#addCartBtn").click(function() {
			// alert("댓글 등록 처리")

			// 품절된 상품일시 alert을 띄우고 리턴
			if ("${vo.status}" == "품절") {
				alert("해당 상품은 품절입니다.");
				return;
			}
			let piNo = 1;
			let bookName = $("#booKName").text();
			let quantity = $(".quantity-input").val();
			let bookNo = $("#bookNo").val();

			// 데이터 수집해서 replyService.write()에 보낸다.
			// 		var cart = {booKNo : $("#bookNo").text(), bookName : $("#booKName").text(), piNo : piNo , quantity : $(".quantity-input").val()};
			console.log(bookNo);
			console.log(bookName);
			console.log(quantity);
			console.log(piNo);

			// 서버로 데이터를 보내서 댓글 등록 시킨다.
				$.ajax({
					async : true,
					type : 'POST',
					data : bookNo,
					url : "/cart/searchBook.do",
					dataType : "json",
					contentType : "application/json",
					success : function(data) {
						
						console.log("bookNo:"+bookNo);
						console.log("quantity:"+quantity);
						
						if (data.cnt > 0) {

							var overLab = confirm('중복 상품이 있어요 수량을 추가 하시겠습니까?');

							if(overLab){
							
							//아이디가 존제할 경우 빨깡으로 , 아니면 파랑으로 처리하는 디자인
							data = {bookNo: bookNo, quantity: quantity}
							console.log("data:"+data);

					        $.ajax({
					            url: "/cart/overLabBookInc.do",
					            contentType : "application/json",
					            dataType : "json",
					            type: "POST",
					            data: JSON.stringify(data)
					            ,
					            
					            success: function(result) {
					              if (result === 1) {
						            
					                location = "/cart/list.do"
					              } else {
					                alert("Failed to update cart.");
					              }
					            }
//				 	            error: function(xhr){
//				 		            console.log(xhr);
//				 		        }
					          });
					          alert("상품이 추가 되었습니다.");
								} else{
		
									
									}

						} else {
							
							
							
							$.ajax({
								url : "/cart/addCart.do",
								type : "post",
								// 서버에 전달해 주는 데이터
								data : {
									bookNo : bookNo,
									bookName : bookName,
									piNo : piNo,
									quantity : quantity
								},
								// 넘겨 주는 데이터의 타입 - json : text
								dataType : "json",
								// 서버의 정상 처리 후 실행하는 함수
								success : function(result) {
									if (result == 100) {

										location.href = "/cart/list.do";
									} else {
										alert("Failed to update cart.");
									}
								}
							}); // $.ajax()의 끝

						}
					},
					error : function(error) {

						alert("error : " + error);
					}
				});



			
				
	
		});

		$(".quantity-btn")
				.click(
						function() {
							const operation = $(this).data('operation');
							const currentQuantity = $(this)
									.parents(".quantity").find(
											".quantity-input").val();
							let cartNo = $(this).parents(".quantity").find(
									".cartNo").val();
							let newQuantity;

							if (operation === 'increment'
									&& currentQuantity < 999) {
								newQuantity = parseInt(currentQuantity) + 1;
							} else if (operation === 'decrement'
									&& currentQuantity > 1) {
								newQuantity = parseInt(currentQuantity) - 1;
							} else {
								alert("실패");
								return;
							}

							$(this).parents(".quantity")
									.find(".quantity-input").val(newQuantity);
						});

		// 리뷰 
		console.log(replyService);

		var no = ${vo.bookNo};
		var replyUL = $(".chat");
		var replyPageFooter = $("#replyPageDiv");
		var checkDn = 0;
		var id = '<%= session.getAttribute("login") != null ? ((MemberVO)session.getAttribute("login")).getId() : "" %>';
		var page = 1;

		// 댓글을 가져와서 출력해 주는 함수 호출 -> 바로 실행. 게시판 글보기 보여 주는 처음 시점
		showList(page)
		
		// 사용 시점 - 게시판 글보기 보여 주는 처음 시점, 댓글 등록 후, 댓글 수정 후, 댓글 삭제 후 -> 함수로 만들고 호출
		function showList(page){
			// replyService.list() 테스트
			replyService.list(
				// 넘어가는 데이터
				{page:page, no:no},
				// 성공했을 때의 함수 - callback 함수
				function(data){
					//alert(data);
					var list = data.list;
					var pageObject = data.pageObject;
					if(id != ''){
						checkDn = data.detailNo;
					}

					// 추가 해야할 li 태그들을 저장하는 변수 선언
					var str = "";

					// 데이터가 없는 경우의 처리
					if(list == null || list.length ==0){
						replyUL.html("<li>댓글이 존재하지 않습니다.</li>"); // 데이터가 없는 경우 출력
						return; // 돌아간다. 아래로 내려가지 않는다.
					}

					// 댓글이 있는 경우의 처리 -> UL태그 안에 들어 갈 li 태그가 작성
					for(var i = 0, len = list.length; i < len; i++){
						//console.log(list[i]);
						str += "<li class='left clearfix' data-rno='"+list[i].rno+"'>";
						str += "<div class= 'reply-box'>";
						str += "<div class='header'>";
						str += "<strong class='primary-font'>"+list[i].id+"</strong>";
						str += "<small class='pull-right text-muted'>";

						// 날짜 형식맞게 출력
						date = new Date(list[i].writeDate);
						str += date.getFullYear() + "-" + (date.getMonth() + 1 < 10 ? '0' : '') + (date.getMonth() + 1) + "-" + (date.getDate() < 10 ? '0' : '') + date.getDate();
						
						str += "</small>";
						str += "</div>";

						// 별점 div
						str += "<div class='review-el-starcover'>";
						str += "<span class='review-el-star'>";
						str += "<div class='decimal-star' style='width: 80px;'>";
						// 비어있는 별 표시
						str += "<div class='decimal-star__empty-cover'>";
						str += '<span class="infd-icon decimal-star__el " data-id="1" style="width:16px;height:16px;"><svg width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16"><path fill="#dee2e6" fill-rule="evenodd" d="M8 1.3c.133 0 .263.037.375.108.113.07.203.17.262.29l1.778 3.637 3.978.583c.131.02.254.075.355.161.101.086.176.199.217.326.041.126.046.262.014.392-.031.13-.098.247-.193.34l-2.878 2.831.68 3.996c.022.131.007.267-.042.39-.05.124-.133.23-.24.31-.107.078-.234.125-.366.134-.132.01-.263-.018-.38-.08L8 12.831l-3.558 1.887c-.117.062-.248.09-.38.08-.132-.01-.259-.056-.365-.134-.107-.079-.19-.186-.24-.31-.05-.123-.065-.258-.043-.39l.68-3.997-2.88-2.83c-.094-.093-.161-.21-.193-.34-.032-.13-.027-.266.014-.393.04-.127.116-.24.217-.326.102-.086.225-.142.356-.16l3.978-.583 1.779-3.637c.059-.12.15-.22.262-.29.112-.07.242-.108.374-.108z" clip-rule="evenodd"></path></svg></span>';
						str += '<span class="infd-icon decimal-star__el " data-id="2" style="width:16px;height:16px;"><svg width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16"><path fill="#dee2e6" fill-rule="evenodd" d="M8 1.3c.133 0 .263.037.375.108.113.07.203.17.262.29l1.778 3.637 3.978.583c.131.02.254.075.355.161.101.086.176.199.217.326.041.126.046.262.014.392-.031.13-.098.247-.193.34l-2.878 2.831.68 3.996c.022.131.007.267-.042.39-.05.124-.133.23-.24.31-.107.078-.234.125-.366.134-.132.01-.263-.018-.38-.08L8 12.831l-3.558 1.887c-.117.062-.248.09-.38.08-.132-.01-.259-.056-.365-.134-.107-.079-.19-.186-.24-.31-.05-.123-.065-.258-.043-.39l.68-3.997-2.88-2.83c-.094-.093-.161-.21-.193-.34-.032-.13-.027-.266.014-.393.04-.127.116-.24.217-.326.102-.086.225-.142.356-.16l3.978-.583 1.779-3.637c.059-.12.15-.22.262-.29.112-.07.242-.108.374-.108z" clip-rule="evenodd"></path></svg></span>';
						str += '<span class="infd-icon decimal-star__el " data-id="3" style="width:16px;height:16px;"><svg width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16"><path fill="#dee2e6" fill-rule="evenodd" d="M8 1.3c.133 0 .263.037.375.108.113.07.203.17.262.29l1.778 3.637 3.978.583c.131.02.254.075.355.161.101.086.176.199.217.326.041.126.046.262.014.392-.031.13-.098.247-.193.34l-2.878 2.831.68 3.996c.022.131.007.267-.042.39-.05.124-.133.23-.24.31-.107.078-.234.125-.366.134-.132.01-.263-.018-.38-.08L8 12.831l-3.558 1.887c-.117.062-.248.09-.38.08-.132-.01-.259-.056-.365-.134-.107-.079-.19-.186-.24-.31-.05-.123-.065-.258-.043-.39l.68-3.997-2.88-2.83c-.094-.093-.161-.21-.193-.34-.032-.13-.027-.266.014-.393.04-.127.116-.24.217-.326.102-.086.225-.142.356-.16l3.978-.583 1.779-3.637c.059-.12.15-.22.262-.29.112-.07.242-.108.374-.108z" clip-rule="evenodd"></path></svg></span>';
						str += '<span class="infd-icon decimal-star__el " data-id="4" style="width:16px;height:16px;"><svg width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16"><path fill="#dee2e6" fill-rule="evenodd" d="M8 1.3c.133 0 .263.037.375.108.113.07.203.17.262.29l1.778 3.637 3.978.583c.131.02.254.075.355.161.101.086.176.199.217.326.041.126.046.262.014.392-.031.13-.098.247-.193.34l-2.878 2.831.68 3.996c.022.131.007.267-.042.39-.05.124-.133.23-.24.31-.107.078-.234.125-.366.134-.132.01-.263-.018-.38-.08L8 12.831l-3.558 1.887c-.117.062-.248.09-.38.08-.132-.01-.259-.056-.365-.134-.107-.079-.19-.186-.24-.31-.05-.123-.065-.258-.043-.39l.68-3.997-2.88-2.83c-.094-.093-.161-.21-.193-.34-.032-.13-.027-.266.014-.393.04-.127.116-.24.217-.326.102-.086.225-.142.356-.16l3.978-.583 1.779-3.637c.059-.12.15-.22.262-.29.112-.07.242-.108.374-.108z" clip-rule="evenodd"></path></svg></span>';
						str += '<span class="infd-icon decimal-star__el " data-id="5" style="width:16px;height:16px;"><svg width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16"><path fill="#dee2e6" fill-rule="evenodd" d="M8 1.3c.133 0 .263.037.375.108.113.07.203.17.262.29l1.778 3.637 3.978.583c.131.02.254.075.355.161.101.086.176.199.217.326.041.126.046.262.014.392-.031.13-.098.247-.193.34l-2.878 2.831.68 3.996c.022.131.007.267-.042.39-.05.124-.133.23-.24.31-.107.078-.234.125-.366.134-.132.01-.263-.018-.38-.08L8 12.831l-3.558 1.887c-.117.062-.248.09-.38.08-.132-.01-.259-.056-.365-.134-.107-.079-.19-.186-.24-.31-.05-.123-.065-.258-.043-.39l.68-3.997-2.88-2.83c-.094-.093-.161-.21-.193-.34-.032-.13-.027-.266.014-.393.04-.127.116-.24.217-.326.102-.086.225-.142.356-.16l3.978-.583 1.779-3.637c.059-.12.15-.22.262-.29.112-.07.242-.108.374-.108z" clip-rule="evenodd"></path></svg></span>';
						str += '</div>';
						// 노란색 별 표시
						str += '<div class="decimal-star__fill-cover" style="width:80px;">';
						str += '<span class="infd-icon decimal-star__el " data-id="1" style="width:16px;height:16px;"><svg width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16"><path fill="#ffc807" fill-rule="evenodd" d="M8 1.3c.133 0 .263.037.375.108.113.07.203.17.262.29l1.778 3.637 3.978.583c.131.02.254.075.355.161.101.086.176.199.217.326.041.126.046.262.014.392-.031.13-.098.247-.193.34l-2.878 2.831.68 3.996c.022.131.007.267-.042.39-.05.124-.133.23-.24.31-.107.078-.234.125-.366.134-.132.01-.263-.018-.38-.08L8 12.831l-3.558 1.887c-.117.062-.248.09-.38.08-.132-.01-.259-.056-.365-.134-.107-.079-.19-.186-.24-.31-.05-.123-.065-.258-.043-.39l.68-3.997-2.88-2.83c-.094-.093-.161-.21-.193-.34-.032-.13-.027-.266.014-.393.04-.127.116-.24.217-.326.102-.086.225-.142.356-.16l3.978-.583 1.779-3.637c.059-.12.15-.22.262-.29.112-.07.242-.108.374-.108z" clip-rule="evenodd"></path></svg></span>';
						if(list[i].score>=2)
						str += '<span class="infd-icon decimal-star__el " data-id="2" style="width:16px;height:16px;"><svg width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16"><path fill="#ffc807" fill-rule="evenodd" d="M8 1.3c.133 0 .263.037.375.108.113.07.203.17.262.29l1.778 3.637 3.978.583c.131.02.254.075.355.161.101.086.176.199.217.326.041.126.046.262.014.392-.031.13-.098.247-.193.34l-2.878 2.831.68 3.996c.022.131.007.267-.042.39-.05.124-.133.23-.24.31-.107.078-.234.125-.366.134-.132.01-.263-.018-.38-.08L8 12.831l-3.558 1.887c-.117.062-.248.09-.38.08-.132-.01-.259-.056-.365-.134-.107-.079-.19-.186-.24-.31-.05-.123-.065-.258-.043-.39l.68-3.997-2.88-2.83c-.094-.093-.161-.21-.193-.34-.032-.13-.027-.266.014-.393.04-.127.116-.24.217-.326.102-.086.225-.142.356-.16l3.978-.583 1.779-3.637c.059-.12.15-.22.262-.29.112-.07.242-.108.374-.108z" clip-rule="evenodd"></path></svg></span>';
						if(list[i].score>=3)
						str += '<span class="infd-icon decimal-star__el " data-id="3" style="width:16px;height:16px;"><svg width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16"><path fill="#ffc807" fill-rule="evenodd" d="M8 1.3c.133 0 .263.037.375.108.113.07.203.17.262.29l1.778 3.637 3.978.583c.131.02.254.075.355.161.101.086.176.199.217.326.041.126.046.262.014.392-.031.13-.098.247-.193.34l-2.878 2.831.68 3.996c.022.131.007.267-.042.39-.05.124-.133.23-.24.31-.107.078-.234.125-.366.134-.132.01-.263-.018-.38-.08L8 12.831l-3.558 1.887c-.117.062-.248.09-.38.08-.132-.01-.259-.056-.365-.134-.107-.079-.19-.186-.24-.31-.05-.123-.065-.258-.043-.39l.68-3.997-2.88-2.83c-.094-.093-.161-.21-.193-.34-.032-.13-.027-.266.014-.393.04-.127.116-.24.217-.326.102-.086.225-.142.356-.16l3.978-.583 1.779-3.637c.059-.12.15-.22.262-.29.112-.07.242-.108.374-.108z" clip-rule="evenodd"></path></svg></span>';
						if(list[i].score>=4)
						str += '<span class="infd-icon decimal-star__el " data-id="4" style="width:16px;height:16px;"><svg width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16"><path fill="#ffc807" fill-rule="evenodd" d="M8 1.3c.133 0 .263.037.375.108.113.07.203.17.262.29l1.778 3.637 3.978.583c.131.02.254.075.355.161.101.086.176.199.217.326.041.126.046.262.014.392-.031.13-.098.247-.193.34l-2.878 2.831.68 3.996c.022.131.007.267-.042.39-.05.124-.133.23-.24.31-.107.078-.234.125-.366.134-.132.01-.263-.018-.38-.08L8 12.831l-3.558 1.887c-.117.062-.248.09-.38.08-.132-.01-.259-.056-.365-.134-.107-.079-.19-.186-.24-.31-.05-.123-.065-.258-.043-.39l.68-3.997-2.88-2.83c-.094-.093-.161-.21-.193-.34-.032-.13-.027-.266.014-.393.04-.127.116-.24.217-.326.102-.086.225-.142.356-.16l3.978-.583 1.779-3.637c.059-.12.15-.22.262-.29.112-.07.242-.108.374-.108z" clip-rule="evenodd"></path></svg></span>';
						if(list[i].score>=5)
						str += '<span class="infd-icon decimal-star__el " data-id="5" style="width:16px;height:16px;"><svg width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16"><path fill="#ffc807" fill-rule="evenodd" d="M8 1.3c.133 0 .263.037.375.108.113.07.203.17.262.29l1.778 3.637 3.978.583c.131.02.254.075.355.161.101.086.176.199.217.326.041.126.046.262.014.392-.031.13-.098.247-.193.34l-2.878 2.831.68 3.996c.022.131.007.267-.042.39-.05.124-.133.23-.24.31-.107.078-.234.125-.366.134-.132.01-.263-.018-.38-.08L8 12.831l-3.558 1.887c-.117.062-.248.09-.38.08-.132-.01-.259-.056-.365-.134-.107-.079-.19-.186-.24-.31-.05-.123-.065-.258-.043-.39l.68-3.997-2.88-2.83c-.094-.093-.161-.21-.193-.34-.032-.13-.027-.266.014-.393.04-.127.116-.24.217-.326.102-.086.225-.142.356-.16l3.978-.583 1.779-3.637c.059-.12.15-.22.262-.29.112-.07.242-.108.374-.108z" clip-rule="evenodd"></path></svg></span>';
						str += '</div>';
						str += '</div>';
						str += '</span>';
						str += '<span class="review-el-starnum">'+list[i].score+'</span>';
						str += '</div>';
						
						str += "<p>"+list[i].content+"</p>";
						str += "</div>";
						str += "</li>";

						// 댓글의 아이디와 세션의 아이디가 같으면 ,checkDn을 0으로 만들어서 재등록 방지
						if(list[i].id == id){
							checkDn = 0;
						}
						
					}

					// 댓글의 데이터 출력
					replyUL.html(str);

					// 페이지네이션 코드 작성하기 - pageObject를 사용해서
					str = "";
					str += "<ul class='pagination'>";
					str += "<li class='page-item ";
					if(pageObject.startPage == 1) str += "disabled";
					str += "'><a class='page-link' href='#'>Previous</a></li>";
					for(var i = pageObject.startPage ; i <= pageObject.endPage; i++){
					  str += "<li class='page-item ";
					  if(page == i) str += "active";
					  str += "'><a class='page-link' href='#'>"+i+"</a></li>";
					}
					str += "<li class='page-item ";
					if(pageObject.endPage == pageObject.totalPage) str += "disabled";
					str += "'><a class='page-link' href='#'>Next</a></li>";
					str += "</ul>";
					// 댓글 페이지 네이션 출력
					replyPageFooter.html(str);
					
				}
			);
		};

		// 모달 창을 보이게 - 댓글 등록 버튼 : 댓글 제목 오른쪽 버튼
		$("#replyWriteBtn").click(function(){
			if(checkDn == 0){
					console.log("구매 먼저");
					return;
				}
			// 댓글 모달창 제목 바꾸기
			$("#replyModalTitle").text("댓글 등록 모달 창");

			// 댓글 번호 숨김
			$("#rnoDiv").hide();

			// 필요 없는 버튼 - 수정, 삭제 숨김
			$("#modalUpdateBtn, #modalDeleteBtn").hide();

			// 필요한 버튼 - 등록 표시
			$("#modalWriteBtn").show();

			// 데이터 지우지
			$("#content").val("");

			
			// 모달 창을 보이게 하자.
			$("#replyModal").modal("show");
		});

		// 댓글 등록에 처리 버튼 - 모달 창에 있는 버튼
		$("#modalWriteBtn").click(function(){
			// alert("댓글 등록 처리")
			
					// ------------------------ 등록 폼 별점 변경 -----------------------------
		// 별 span태그 선택 - 등록 폼
		const emptyCovers = document.querySelectorAll('.update-empty-Star span');
		const fillCovers = document.querySelectorAll('.update-fill-Star span');

		// 별 클릭시 클릭한 만큼 표시(노란별)
		fillCovers.forEach((fillCover) => {
		  fillCover.addEventListener('click', () => {
		    const id = fillCover.getAttribute('data-id');
		    score = id;
		    const width = id * 30;
		    document.getElementById('title-fill-cover').style.width = width+ 'px';
		  });
		});

		// 별 클릭시 클릭한 만큼 표시(회색별)
		emptyCovers.forEach((emptyCover) => {
		  emptyCover.addEventListener('click', () => {
		    const id = emptyCover.getAttribute('data-id');
		    score = id;
		    const width = id * 30;
		    document.getElementById('title-fill-cover').style.width = width+ 'px';
		  });
		});
			
			
			// 데이터 수집해서 replyService.write()에 보낸다.
			var reply = {no : no, content : $("#content").val(), score:score};

			// replyService.write(JSON, func(), func())로 보낸다.
			replyService.write(
				reply,
				function(result){
					// 1. 댓글 리스트를 다시 가져와 표시한다.
					page = 1;
					showList(page);
					// 2. 사용자에게 메시지 전달
					// Contorller에서 encode와 JS에서 decode를 사용해서 처리를 해야 한글을 맞출 수 있다.
// 					if(result) alert(decodeURI(result.replaceAll("+", " ")));
// 					if(result) alert(result);
// 					else alert("댓글 등록이 되었습니다.");
					if(result) $("#messageModal").find(".modal-body").text(result);
					else $("#messageModal").find(".modal-body").text("댓글 등록이 되었습니다.");
					$("#messageModal").modal("show");
					// 3. 모달 창은 닫는다.
					$("#replyModal").modal("hide");
				}
			);
			
			// 모달 창을 안보이게 하자.
			$("#replyModal").modal("hide");
		}); // 댓글 등록 처리의 끝

		// 댓글을 클릭하면 동작되는 이벤트
		// 댓글 한개는 나중에 처리되서 나타난 내용에 해당된다. 이벤트 처리할 당시에는 소스가 없었다.
		// 댓글 전체는 처음부터있었다. 있는 전체에 이벤트 처리 -> on(이벤트, 선택한 객체 안에 객체, 함수)
		$("ul.chat").on("click","li",function(){
			// alert("댓글 한개 클릭");
			// 데이터 수집
			// 클릭한  태그 안에 data-rno=284
			var rno = $(this).data("rno");
			var content = $(this).find("p").text();
			var score = $(this).find(".review-el-starnum").text();
// 			alert(score)
			
			var wid = $(this).find(".primary-font").text();
			console.log(wid);

			if(wid != id) {
				console.log("다른 사람의 글");
				return;
			}
			
			// 모달에 데이터 세팅
			$("#rno").val(rno);
			$("#content").val(content);
			$("#modal-star-num").val(score);
			// 모달창 제목 바꾸기
			$("#replyModalTitle").text("댓글 수정 / 삭제 모달 창");

			// 모달 처리 버튼
			$("#modalWriteBtn").hide();
			$("#modalUpdateBtn, #modalDeleteBtn").show();

			// 댓글 번호 보여지게
			$("#rnoDiv").show();
			
			// 모달 보여주기
			$("#replyModal").modal("show");
			
		});

		// 모달 창안에 수정 버튼 이벤트
		$("#modalUpdateBtn").click(function(){
			// alert("댓글 수정 처리 진행");
			// 데이터 수집 - rno, reply
			var reply = {rno:$("#rno").val(), content:$("#content").val(), score:score};

			replyService.update(reply, function(result){
				// 수정이 성공되면 처리 내용
				// 1. 리스트 데이터를 다시 가져와서 표시한다.
				showList(page);
				// 2. 모달창은 닫는다.
				$("#replyModal").modal("hide");
				// 3. 메시지 모달창에 데이터 세팅하고 보여준다.
				if(result) $("#messageModal").find(".modal-body").text(result);
				else $("#messageModal").find(".modal-body").text("댓글 수정이 되었습니다.");
				$("#messageModal").modal("show");
				
			});
			
		}); // 모달 창안에 수정 버튼 이벤트 끝
		
		// 모달 창안에 삭제 버튼 이벤트
		$("#modalDeleteBtn").click(function(){
			//alert("댓글 삭제 처리 진행");

			// 데이터 수집
			var rno = $("#rno").val();
			
			replyService.delete(rno, function(result){

				// 삭제가 성공되면 처리 내용
				// 1. 리스트 데이터를 다시 가져와서 표시한다. 1 페이지
				page = 1;
				showList(page);
				// 2. 모달창은 닫는다.
				$("#replyModal").modal("hide");
				// 3. 메시지 모달창에 데이터 세팅하고 보여준다.
				if(result) $("#messageModal").find(".modal-body").text(result);
				else $("#messageModal").find(".modal-body").text("댓글 삭제가 되었습니다.");
				$("#messageModal").modal("show");
				
			});
			
		}); // 모달 창안에 수정 버튼 이벤트 끝

		// 댓글 페이지네이션 이벤트
		$("#replyPageDiv").on("click", "ul>li", function(){
			// alert("댓글 페이지 클릭");
			page = $(this).text();
			// alert(page);
// 			if($(this).hasClass("active"))
// 				alert("현재 페이지 입니다.");
// 			else alert("현재 페이지가 아닙니다.");
			// 현재 페이지가 아닌 경우 페이지 이동을 시킨다.
			if(!$(this).hasClass("active"))
				showList(page);
			return false; // 페이지 이동 취소
		});

		// ------------------------ 등록 폼 별점 변경 -----------------------------
		// 별 span태그 선택 - 등록 폼
		const emptyCovers = document.querySelectorAll('.update-empty-Star span');
		const fillCovers = document.querySelectorAll('.update-fill-Star span');

		// 별 클릭시 클릭한 만큼 표시(노란별)
		fillCovers.forEach((fillCover) => {
		  fillCover.addEventListener('click', () => {
		    const id = fillCover.getAttribute('data-id');
		    score = id;
		    const width = id * 30;
		    document.getElementById('title-fill-cover').style.width = width+ 'px';
		  });
		});

		// 별 클릭시 클릭한 만큼 표시(회색별)
		emptyCovers.forEach((emptyCover) => {
		  emptyCover.addEventListener('click', () => {
		    const id = emptyCover.getAttribute('data-id');
		    score = id;
		    const width = id * 30;
		    document.getElementById('title-fill-cover').style.width = width+ 'px';
		  });
		});
		
		// -------------------------- 수정 modal 별점 변경 ---------------------------
		// 별 span태그 선택 - 수정 modal
		const modalEmptyCovers = document.querySelectorAll('.update-empty-Star span');
		const modalFillCovers = document.querySelectorAll('.update-fill-Star span');

		// 별 클릭시 클릭한 만큼 표시(노란별) - 수정 modal
		modalFillCovers.forEach((fillCover) => {
		  fillCover.addEventListener('click', () => {
		    const id = fillCover.getAttribute('data-id');
		    score = id;
		    const width = id * 30;
		    document.getElementById('update-title-fill-cover').style.width = width+ 'px';
		    $("#modal-star-num").text(score);
		  });
		});

		// 별 클릭시 클릭한 만큼 표시(회색별) - 수정 modal
		modalEmptyCovers.forEach((emptyCover) => {
		  emptyCover.addEventListener('click', () => {
		    const id = emptyCover.getAttribute('data-id');
		    score = id;
		    const width = id * 30;
		    document.getElementById('update-title-fill-cover').style.width = width+ 'px';
		    $("#modal-star-num").text(score);
		  });
		});
		
	});
</script>
</head>
<body class="sub_page">
	<section class="layout_padding">
		<div class="container">
			<div class="back" id="top">
				<h1 class="title" style="margin-left: 20px;">교재 상세 보기</h1>
				<div class="row">
					<!-- 이미지 -->
					<div class="col-md-6">
						<div>
							<c:if test="${login !=null && login.gradeNo ==9 }">
								<button type="button" data-toggle="modal"
									data-target="#updateImageModal" class="btn btn-danger btn-sm"
									style="font-size: small;" id="upBtn">사진변경</button>
							</c:if>
							<!-- 모달 -->
							<div class="modal" id="updateImageModal">
								<div class="modal-dialog">
									<div class="modal-content">
										<!-- Modal Header -->
										<div class="modal-header" id="updateImo">
											<h4 class="modal-title">교재 사진 변경</h4>
											<button type="button" class="close" data-dismiss="modal">&times;</button>
										</div>

										<!-- Modal Body -->
										<div class="modal-body">
											<form action="updateImage.do" method="post"
												enctype="multipart/form-data">
												<input type="hidden" name="bookNo" value="${vo.bookNo }">
												<input type="hidden" name="page" value="${param.page }">
												<input type="hidden" name="perPageNum"
													value="${param.perPageNum }"> <input type="hidden"
													name="key" value="${param.key }"> <input
													type="hidden" name="word" value="${param.word }"> <input
													type="hidden" name="deleteName" value="${vo.fileName }">
												<div class="form-group">
													<label for="imageFile">바꿀파일</label> <input type="file"
														name="imageFile" id="imageFile" required="required"
														class="form-control">
												</div>
												<button id="updateImageBtn" class="btn btn-success"
													style="float: right;">수정</button>
											</form>
										</div>

										<!-- Modal footer -->
										<div class="modal-footer"></div>
									</div>
								</div>
							</div>
						</div>
						<div class="img-box">
							<input id="bookNo" type="hidden" name="bookNo"
								value="${vo.bookNo }"> <img class="img" alt="번호에 맞는 사진"
								src="${vo.fileName }">
						</div>
					</div>
					<!-- 데이터 -->
					<div class="col-md-6">
						<div class="detail-box">
							<div class="heading_container">
								<h4 style="font-weight: bold;">${vo.bookName }</h4>
								<div><span style="background:#33CC33; color:#ffffff">${vo.status }</span>
									<c:if test="${login !=null && login.gradeNo ==9 }">
										<a
											href="update.do?no=${vo.bookNo }&page=${param.page}&perPageNum=${param.perPageNum}&key=${param.key}&word=${param.word}"
											class="btn btn-secondary btn-sm">정보수정</a>
										<a href="delete.do?no=${vo.bookNo }"
											class="btn btn-danger btn-sm" id="qBtn">품절 처리</a>
									</c:if>
									<a
										href="list.do?&page=${param.page}&perPageNum=${param.perPageNum}&key=${param.key}&word=${param.word}"
										class="btn btn-info btn-sm">리스트</a>
									<button class="btn btn-info btn-sm" id="addCartBtn"
										type="button">담기</button>
									<button id="orderBtn" class="btn btn-info btn-sm">주문</button>
								</div>
							</div>
							<hr width="100%" style="margin-bottom: 20px">
							<p>과목 : ${vo.bookDiv }</p>
							<p>
								발행일 :
								<fmt:formatDate value="${vo.pubDate }" pattern="yyyy년MM월dd일" />
							</p>
							<p>
								출판사 : ${vo.publisher }<br />
							</p>
							<p>정가 : ${vo.price }</p>
							<div class="col-md-3 quantity" style="float: left;">

								<div class="input-group">
									<div class="input-group-prepend">
										<button class="btn btn-outline-primary quantity-btn"
											type="button" data-operation="decrement">-</button>
									</div>

									<input class="form-control quantity-input" value=1 min="1"
										max="999">

									<div class="input-group-append">
										<button class="btn btn-outline-primary quantity-btn"
											type="button" data-operation="increment">+</button>
									</div>
								</div>

							</div>
							<a href="#review1" class="btn btn-outline-success">리뷰</a>
						</div>
					</div>
				</div>
				<hr width="100%">
				<p class="bi" style="font-weight: bold;">
					책소개</p><p class="bi">${vo.bookIntroduce }</p>
				<hr width="100%">
				<!-- 강의목록,리뷰 메인의 강사 강의 버튼느낌으로 바뀌도록 해보기 -->
				<section class="book_list layout_padding-bottom">
					<div class="container">
						<div style="font-weight: bold;">관련 강의</div><br/>
						<div class="filters-content">
							<c:forEach items="${vo1 }" var="vo1">
								<c:if test="${vo1.cbno eq vo.bookNo}">
									<div class="col-sm-6 col-lg-3 cbnocourse" id="data">
										<div class="dataRow">
											<!-- 이미지 -->
											<div class="" style="text-align: center;">
												<div class="no" hidden="hidden">${vo1.cbno }</div>
												<div class="cono" hidden="hidden">${vo1.no }</div>
												<img alt="이미지" src="${vo1.image }">
											</div>
											<!-- 리스트에 들어가야할 데이터 -->
											<div class="detail-box">
												<!-- 책이름 -->

												<div>강의명 : ${vo1.title }</div>
												<p>
													강사 : ${vo1.teacher } <br />시작일 :
													<fmt:formatDate value="${vo1.startDate }"
														pattern="yyyy년MM월dd일" />
													<br />종료일 :
													<fmt:formatDate value="${vo1.endDate }"
														pattern="yyyy년MM월dd일" />
												</p>
											</div>
										</div>
									</div>
									<hr />
								</c:if>
							</c:forEach>
						</div>
						<hr/> <!-- 관련강의와 리뷰 사이의 선 -->
						<!-- 교재 리뷰  -->
						<div class="row">
							<div class="col-lg-12">
								<div class="card">
									<div class="card-header">
										<a id="review1"></a>
										<i class="fa fa-comments fa-fw"></i> Review
										<button id="replyWriteBtn"
											class="btn btn-primary btn-sm float-right">New Review</button>
									</div>
									<div class="card-body">
										<!-- 댓글을 출력하는 UL - 데이터 한개 당 li 태그 한개 -->
										<ul class="chat">
											<li class="left clearfix" data-rno="12">
												<div>
													<div class="header">
														<strong class="primary-font">작성자</strong> <small
															class="pull-right text-muted">2023-03-22</small>
													</div>
													<p>댓글 내용</p>
												</div>
											</li>
										</ul>
										<!-- 댓글을 출력하는 UL 끝 -->
									</div>
									<div class="card-footer" id="replyPageDiv"></div>
								</div>
								<!-- card의 끝 -->

							</div>
						</div>

						<!-- The Modal -->
						<div class="modal" id="replyModal">
							<div class="modal-dialog">
								<div class="modal-content">

									<!-- Modal Header -->
									<div class="modal-header">
										<h4 class="modal-title" id="replyModalTitle">REVIEW Modal</h4>
										<button type="button" class="close" data-dismiss="modal">&times;</button>
									</div>

									<!-- Modal body form tag 는 만들지 않고 데이터 수집용으로만 input, textarea, select 태그 사용
				   					- 등록 : 댓글 내용. 수정 : 댓글 번호(보이게), 댓글 내용 -->
									<div class="modal-body">
										<div class="form-group" id="rnoDiv">
											<label>리뷰 번호</label> <input name="rno" id="rno"
												class="form-control" readonly="readonly">
										</div>
										
										<div class="form-group" id="updateStar" >
						    
						    <div class="decimal-star decimal-star--selectable" style="width: 150px;">
							      <div class="decimal-star__empty-cover update-empty-Star">
							        <span class="starScore infd-icon decimal-star__el e-select-star" data-id="1" style="width:30px;height:30px;">
							    <svg width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16"><path fill="#dee2e6" fill-rule="evenodd" d="M8 1.3c.133 0 .263.037.375.108.113.07.203.17.262.29l1.778 3.637 3.978.583c.131.02.254.075.355.161.101.086.176.199.217.326.041.126.046.262.014.392-.031.13-.098.247-.193.34l-2.878 2.831.68 3.996c.022.131.007.267-.042.39-.05.124-.133.23-.24.31-.107.078-.234.125-.366.134-.132.01-.263-.018-.38-.08L8 12.831l-3.558 1.887c-.117.062-.248.09-.38.08-.132-.01-.259-.056-.365-.134-.107-.079-.19-.186-.24-.31-.05-.123-.065-.258-.043-.39l.68-3.997-2.88-2.83c-.094-.093-.161-.21-.193-.34-.032-.13-.027-.266.014-.393.04-.127.116-.24.217-.326.102-.086.225-.142.356-.16l3.978-.583 1.779-3.637c.059-.12.15-.22.262-.29.112-.07.242-.108.374-.108z" clip-rule="evenodd"></path></svg>
							  </span><span class="starScore infd-icon decimal-star__el e-select-star" data-id="2" style="width:30px;height:30px;">
							    <svg width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16"><path fill="#dee2e6" fill-rule="evenodd" d="M8 1.3c.133 0 .263.037.375.108.113.07.203.17.262.29l1.778 3.637 3.978.583c.131.02.254.075.355.161.101.086.176.199.217.326.041.126.046.262.014.392-.031.13-.098.247-.193.34l-2.878 2.831.68 3.996c.022.131.007.267-.042.39-.05.124-.133.23-.24.31-.107.078-.234.125-.366.134-.132.01-.263-.018-.38-.08L8 12.831l-3.558 1.887c-.117.062-.248.09-.38.08-.132-.01-.259-.056-.365-.134-.107-.079-.19-.186-.24-.31-.05-.123-.065-.258-.043-.39l.68-3.997-2.88-2.83c-.094-.093-.161-.21-.193-.34-.032-.13-.027-.266.014-.393.04-.127.116-.24.217-.326.102-.086.225-.142.356-.16l3.978-.583 1.779-3.637c.059-.12.15-.22.262-.29.112-.07.242-.108.374-.108z" clip-rule="evenodd"></path></svg>
							  </span><span class="starScore infd-icon decimal-star__el e-select-star" data-id="3" style="width:30px;height:30px;">
							    <svg width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16"><path fill="#dee2e6" fill-rule="evenodd" d="M8 1.3c.133 0 .263.037.375.108.113.07.203.17.262.29l1.778 3.637 3.978.583c.131.02.254.075.355.161.101.086.176.199.217.326.041.126.046.262.014.392-.031.13-.098.247-.193.34l-2.878 2.831.68 3.996c.022.131.007.267-.042.39-.05.124-.133.23-.24.31-.107.078-.234.125-.366.134-.132.01-.263-.018-.38-.08L8 12.831l-3.558 1.887c-.117.062-.248.09-.38.08-.132-.01-.259-.056-.365-.134-.107-.079-.19-.186-.24-.31-.05-.123-.065-.258-.043-.39l.68-3.997-2.88-2.83c-.094-.093-.161-.21-.193-.34-.032-.13-.027-.266.014-.393.04-.127.116-.24.217-.326.102-.086.225-.142.356-.16l3.978-.583 1.779-3.637c.059-.12.15-.22.262-.29.112-.07.242-.108.374-.108z" clip-rule="evenodd"></path></svg>
							  </span><span class="starScore infd-icon decimal-star__el e-select-star" data-id="4" style="width:30px;height:30px;">
							    <svg width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16"><path fill="#dee2e6" fill-rule="evenodd" d="M8 1.3c.133 0 .263.037.375.108.113.07.203.17.262.29l1.778 3.637 3.978.583c.131.02.254.075.355.161.101.086.176.199.217.326.041.126.046.262.014.392-.031.13-.098.247-.193.34l-2.878 2.831.68 3.996c.022.131.007.267-.042.39-.05.124-.133.23-.24.31-.107.078-.234.125-.366.134-.132.01-.263-.018-.38-.08L8 12.831l-3.558 1.887c-.117.062-.248.09-.38.08-.132-.01-.259-.056-.365-.134-.107-.079-.19-.186-.24-.31-.05-.123-.065-.258-.043-.39l.68-3.997-2.88-2.83c-.094-.093-.161-.21-.193-.34-.032-.13-.027-.266.014-.393.04-.127.116-.24.217-.326.102-.086.225-.142.356-.16l3.978-.583 1.779-3.637c.059-.12.15-.22.262-.29.112-.07.242-.108.374-.108z" clip-rule="evenodd"></path></svg>
							  </span><span class="starScore infd-icon decimal-star__el e-select-star" data-id="5" style="width:30px;height:30px;">
							    <svg width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16"><path fill="#dee2e6" fill-rule="evenodd" d="M8 1.3c.133 0 .263.037.375.108.113.07.203.17.262.29l1.778 3.637 3.978.583c.131.02.254.075.355.161.101.086.176.199.217.326.041.126.046.262.014.392-.031.13-.098.247-.193.34l-2.878 2.831.68 3.996c.022.131.007.267-.042.39-.05.124-.133.23-.24.31-.107.078-.234.125-.366.134-.132.01-.263-.018-.38-.08L8 12.831l-3.558 1.887c-.117.062-.248.09-.38.08-.132-.01-.259-.056-.365-.134-.107-.079-.19-.186-.24-.31-.05-.123-.065-.258-.043-.39l.68-3.997-2.88-2.83c-.094-.093-.161-.21-.193-.34-.032-.13-.027-.266.014-.393.04-.127.116-.24.217-.326.102-.086.225-.142.356-.16l3.978-.583 1.779-3.637c.059-.12.15-.22.262-.29.112-.07.242-.108.374-.108z" clip-rule="evenodd"></path></svg>
							  </span>
							      </div>
							      <div class="decimal-star__fill-cover update-fill-Star" id="update-title-fill-cover">
							        <span class="starScore infd-icon decimal-star__el e-select-star" data-id="1" style="width:30px;height:30px;">
							    <svg width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16"><path fill="#ffc807" fill-rule="evenodd" d="M8 1.3c.133 0 .263.037.375.108.113.07.203.17.262.29l1.778 3.637 3.978.583c.131.02.254.075.355.161.101.086.176.199.217.326.041.126.046.262.014.392-.031.13-.098.247-.193.34l-2.878 2.831.68 3.996c.022.131.007.267-.042.39-.05.124-.133.23-.24.31-.107.078-.234.125-.366.134-.132.01-.263-.018-.38-.08L8 12.831l-3.558 1.887c-.117.062-.248.09-.38.08-.132-.01-.259-.056-.365-.134-.107-.079-.19-.186-.24-.31-.05-.123-.065-.258-.043-.39l.68-3.997-2.88-2.83c-.094-.093-.161-.21-.193-.34-.032-.13-.027-.266.014-.393.04-.127.116-.24.217-.326.102-.086.225-.142.356-.16l3.978-.583 1.779-3.637c.059-.12.15-.22.262-.29.112-.07.242-.108.374-.108z" clip-rule="evenodd"></path></svg>
							  </span><span class="starScore infd-icon decimal-star__el e-select-star" data-id="2" style="width:30px;height:30px;">
							    <svg width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16"><path fill="#ffc807" fill-rule="evenodd" d="M8 1.3c.133 0 .263.037.375.108.113.07.203.17.262.29l1.778 3.637 3.978.583c.131.02.254.075.355.161.101.086.176.199.217.326.041.126.046.262.014.392-.031.13-.098.247-.193.34l-2.878 2.831.68 3.996c.022.131.007.267-.042.39-.05.124-.133.23-.24.31-.107.078-.234.125-.366.134-.132.01-.263-.018-.38-.08L8 12.831l-3.558 1.887c-.117.062-.248.09-.38.08-.132-.01-.259-.056-.365-.134-.107-.079-.19-.186-.24-.31-.05-.123-.065-.258-.043-.39l.68-3.997-2.88-2.83c-.094-.093-.161-.21-.193-.34-.032-.13-.027-.266.014-.393.04-.127.116-.24.217-.326.102-.086.225-.142.356-.16l3.978-.583 1.779-3.637c.059-.12.15-.22.262-.29.112-.07.242-.108.374-.108z" clip-rule="evenodd"></path></svg>
							  </span><span class="starScore infd-icon decimal-star__el e-select-star" data-id="3" style="width:30px;height:30px;">
							    <svg width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16"><path fill="#ffc807" fill-rule="evenodd" d="M8 1.3c.133 0 .263.037.375.108.113.07.203.17.262.29l1.778 3.637 3.978.583c.131.02.254.075.355.161.101.086.176.199.217.326.041.126.046.262.014.392-.031.13-.098.247-.193.34l-2.878 2.831.68 3.996c.022.131.007.267-.042.39-.05.124-.133.23-.24.31-.107.078-.234.125-.366.134-.132.01-.263-.018-.38-.08L8 12.831l-3.558 1.887c-.117.062-.248.09-.38.08-.132-.01-.259-.056-.365-.134-.107-.079-.19-.186-.24-.31-.05-.123-.065-.258-.043-.39l.68-3.997-2.88-2.83c-.094-.093-.161-.21-.193-.34-.032-.13-.027-.266.014-.393.04-.127.116-.24.217-.326.102-.086.225-.142.356-.16l3.978-.583 1.779-3.637c.059-.12.15-.22.262-.29.112-.07.242-.108.374-.108z" clip-rule="evenodd"></path></svg>
							  </span><span class="starScore infd-icon decimal-star__el e-select-star" data-id="4" style="width:30px;height:30px;">
							    <svg width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16"><path fill="#ffc807" fill-rule="evenodd" d="M8 1.3c.133 0 .263.037.375.108.113.07.203.17.262.29l1.778 3.637 3.978.583c.131.02.254.075.355.161.101.086.176.199.217.326.041.126.046.262.014.392-.031.13-.098.247-.193.34l-2.878 2.831.68 3.996c.022.131.007.267-.042.39-.05.124-.133.23-.24.31-.107.078-.234.125-.366.134-.132.01-.263-.018-.38-.08L8 12.831l-3.558 1.887c-.117.062-.248.09-.38.08-.132-.01-.259-.056-.365-.134-.107-.079-.19-.186-.24-.31-.05-.123-.065-.258-.043-.39l.68-3.997-2.88-2.83c-.094-.093-.161-.21-.193-.34-.032-.13-.027-.266.014-.393.04-.127.116-.24.217-.326.102-.086.225-.142.356-.16l3.978-.583 1.779-3.637c.059-.12.15-.22.262-.29.112-.07.242-.108.374-.108z" clip-rule="evenodd"></path></svg>
							  </span><span class="starScore infd-icon decimal-star__el e-select-star" data-id="5" style="width:30px;height:30px;">
							    <svg width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16"><path fill="#ffc807" fill-rule="evenodd" d="M8 1.3c.133 0 .263.037.375.108.113.07.203.17.262.29l1.778 3.637 3.978.583c.131.02.254.075.355.161.101.086.176.199.217.326.041.126.046.262.014.392-.031.13-.098.247-.193.34l-2.878 2.831.68 3.996c.022.131.007.267-.042.39-.05.124-.133.23-.24.31-.107.078-.234.125-.366.134-.132.01-.263-.018-.38-.08L8 12.831l-3.558 1.887c-.117.062-.248.09-.38.08-.132-.01-.259-.056-.365-.134-.107-.079-.19-.186-.24-.31-.05-.123-.065-.258-.043-.39l.68-3.997-2.88-2.83c-.094-.093-.161-.21-.193-.34-.032-.13-.027-.266.014-.393.04-.127.116-.24.217-.326.102-.086.225-.142.356-.16l3.978-.583 1.779-3.637c.059-.12.15-.22.262-.29.112-.07.242-.108.374-.108z" clip-rule="evenodd"></path></svg>
							  </span>
							      </div>
							    </div>							
							<div id="modal-star-num" style="display: none;"></div>
							<div id="modal-pno" style="display: none;"></div>
							</div>
										
										<div class="form-group">
											<label>리뷰 내용</label>
											<textarea rows="5" class="form-control" name="content"
												id="content" style="resize: none;"></textarea>
										</div>
									</div>

									<!-- Modal footer -->
									<div class="modal-footer">
										<button type="button" class="btn btn-primary"
											id="modalWriteBtn">등록</button>
										<button type="button" class="btn btn-primary"
											id="modalUpdateBtn">수정</button>
										<button type="button" class="btn btn-primary"
											id="modalDeleteBtn">삭제</button>
										<button type="button" class="btn btn-danger"
											data-dismiss="modal">취소</button>
									</div>

								</div>
							</div>
						</div>

			<a href="#top" class="btn btn-outline-dark" style="margin-top:10px;">맨위로</a>
					</div>
				</section>
				<!-- 강의 리스트의 section의 끝 -->
			</div>
		</div>
	</section>
	<!-- 상세보기 의 section의 끝 -->
</body>
</html>