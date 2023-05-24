<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>

<head>
  <!-- Basic -->
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <!-- Mobile Metas -->
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <!-- Site Metas -->
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <meta name="author" content="" />
  <link rel="shortcut icon" href="/images/favicon.png" type="">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
  <title> 인강호흡: 메인 </title>
  <style type="text/css">
  .all{
  	height: 445px;
  }
  .detail-box{
  	height: 207px;
  }
  .icon-content{
 	 display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
  }
  .teacher-arrow{
  	padding-left: 10px;
  }
  .h5{
  	margin-bottom: 15px;
  }
  .introduce{
  	margin: 15px 0;
  }
  </style>
  
  <script type="text/javascript">

$(function(){

	$(".cart_login_null").click(function(){

			alert("로그인 후 이용하세요");
		
		});
	
});
</script>
  

  <!-- bootstrap core css -->
  <link rel="stylesheet" type="text/css" href="/css/bootstrap.css" />

  <!--owl slider stylesheet -->
  <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" />
  <!-- nice select  -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/css/nice-select.min.css" integrity="sha512-CruCP+TD3yXzlvvijET8wV5WxxEh5H8P4cmz0RFbKK6FlZ2sYl3AEsKlLPHbniXKSrDdFewhbmBK5skbdsASbQ==" crossorigin="anonymous" />
  <!-- font awesome style -->
  <link href="/css/font-awesome.min.css" rel="stylesheet" />
<!--   <link href="/css/NanumGothic.css" rel="stylesheet" /> -->
  

  <!-- Custom styles for this template -->
  <link href="/css/style.css" rel="stylesheet" />
  <!-- responsive style -->
  <link href="/css/responsive.css" rel="stylesheet" />
  <!-- bootstrap icon -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.3/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>


  
  </head>

<body>

 <div class="hero_area">
    <div class="bg-box">
    <!-- ========================================= 상단 이미지 ========================================= -->
      <img src="/images/pencils-g71b21d0f1_1920.jpg" alt="">
    </div>
    <!-- header section strats -->
    <header class="header_section">
      <div class="container">
        <nav class="navbar navbar-expand-lg custom_nav-container ">
          <a class="navbar-brand" href="/">
            <span>
              인강호흡
            </span>
          </a>

          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class=""> </span>
          </button>
        <c:choose>
		<c:when test="${login==null}">
          <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav  mx-auto ">
              <li class="nav-item">
                <a class="nav-link" href="/notice/list.do">공지사항</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="/book/list.do">교재</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="/course/list.do">강의</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="/mentoring/list.do">멘토링</a>
              </li>
            </ul>
            
            <div class="user_option">
              <a href="/member/myMenu.do?id=${login.id}" class="user_link">
                <i class="fa fa-user" aria-hidden="true"></i>
              </a>
              <a class="cart_link cart_login_null">
                <svg version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 456.029 456.029" style="enable-background:new 0 0 456.029 456.029;" xml:space="preserve">
                  <g>
                    <g>
                      <path d="M345.6,338.862c-29.184,0-53.248,23.552-53.248,53.248c0,29.184,23.552,53.248,53.248,53.248
                   c29.184,0,53.248-23.552,53.248-53.248C398.336,362.926,374.784,338.862,345.6,338.862z" />
                    </g>
                  </g>
                  <g>
                    <g>
                      <path d="M439.296,84.91c-1.024,0-2.56-0.512-4.096-0.512H112.64l-5.12-34.304C104.448,27.566,84.992,10.67,61.952,10.67H20.48
                   C9.216,10.67,0,19.886,0,31.15c0,11.264,9.216,20.48,20.48,20.48h41.472c2.56,0,4.608,2.048,5.12,4.608l31.744,216.064
                   c4.096,27.136,27.648,47.616,55.296,47.616h212.992c26.624,0,49.664-18.944,55.296-45.056l33.28-166.4
                   C457.728,97.71,450.56,86.958,439.296,84.91z" />
                    </g>
                  </g>
                  <g>
                    <g>
                      <path d="M215.04,389.55c-1.024-28.16-24.576-50.688-52.736-50.688c-29.696,1.536-52.224,26.112-51.2,55.296
                   c1.024,28.16,24.064,50.688,52.224,50.688h1.024C193.536,443.31,216.576,418.734,215.04,389.55z" />
                    </g>
                  </g>
                  <g>
                  </g>
                  <g>
                  </g>
                  <g>
                  </g>
                  <g>
                  </g>
                  <g>
                  </g>
                  <g>
                  </g>
                  <g>
                  </g>
                  <g>
                  </g>
                  <g>
                  </g>
                  <g>
                  </g>
                  <g>
                  </g>
                  <g>
                  </g>
                  <g>
                  </g>
                  <g>
                  </g>
                  <g>
                  </g>
                </svg>
              </a>
              <form class="form-inline">
                <button class="btn  my-2 my-sm-0 nav_search-btn" type="submit">
                  <i class="fa fa-search" aria-hidden="true"></i>
                </button>
              </form>
             
              <a href="/member/loginForm.do" class="order_online">
                Login
              </a>
            </div> 
          </div>
          </c:when>
          <c:otherwise>
          <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav  mx-auto ">
              <li class="nav-item">
                <a class="nav-link" href="/notice/list.do">공지사항</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="/book/list.do">교재</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="/course/list.do">강의</a>
              </li>              
               <li class="nav-item">
                <a class="nav-link" href="/mentoring/list.do">멘토링<span class="badge badge-pill badge-danger">${unreadCount}</span></a>
              </li>
            </ul>
            
            <div class="user_option">
              <a href="/member/myMenu.do?id=${login.id}" class="user_link">
                <i class="fa fa-user" aria-hidden="true"></i>
              </a>
              <a class="cart_link" href="/cart/list.do">
                <svg version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 456.029 456.029" style="enable-background:new 0 0 456.029 456.029;" xml:space="preserve">
                  <g>
                    <g>
                      <path d="M345.6,338.862c-29.184,0-53.248,23.552-53.248,53.248c0,29.184,23.552,53.248,53.248,53.248
                   c29.184,0,53.248-23.552,53.248-53.248C398.336,362.926,374.784,338.862,345.6,338.862z" />
                    </g>
                  </g>
                  <g>
                    <g>
                      <path d="M439.296,84.91c-1.024,0-2.56-0.512-4.096-0.512H112.64l-5.12-34.304C104.448,27.566,84.992,10.67,61.952,10.67H20.48
                   C9.216,10.67,0,19.886,0,31.15c0,11.264,9.216,20.48,20.48,20.48h41.472c2.56,0,4.608,2.048,5.12,4.608l31.744,216.064
                   c4.096,27.136,27.648,47.616,55.296,47.616h212.992c26.624,0,49.664-18.944,55.296-45.056l33.28-166.4
                   C457.728,97.71,450.56,86.958,439.296,84.91z" />
                    </g>
                  </g>
                  <g>
                    <g>
                      <path d="M215.04,389.55c-1.024-28.16-24.576-50.688-52.736-50.688c-29.696,1.536-52.224,26.112-51.2,55.296
                   c1.024,28.16,24.064,50.688,52.224,50.688h1.024C193.536,443.31,216.576,418.734,215.04,389.55z" />
                    </g>
                  </g>
                  <g>
                  </g>
                  <g>
                  </g>
                  <g>
                  </g>
                  <g>
                  </g>
                  <g>
                  </g>
                  <g>
                  </g>
                  <g>
                  </g>
                  <g>
                  </g>
                  <g>
                  </g>
                  <g>
                  </g>
                  <g>
                  </g>
                  <g>
                  </g>
                  <g>
                  </g>
                  <g>
                  </g>
                  <g>
                  </g>
                </svg>
              </a>
              <form class="form-inline">
                <button class="btn  my-2 my-sm-0 nav_search-btn" type="submit">
                  <i class="fa fa-search" aria-hidden="true"></i>
                </button>
              </form>
             
              <a href="/member/logOut.do" class="order_online">
                logOut
              </a>
            </div> 
          </div>
          	
          </c:otherwise>
          </c:choose>
        </nav>
      </div>
    </header>
    <!-- end header section -->
    <!-- =========================== header ================================== -->
    
 <!-- slider section -->
    <section class="slider_section ">
      <div id="customCarousel1" class="carousel slide" data-ride="carousel">
        <div class="carousel-inner">
          <div class="carousel-item active">
            <div class="container ">
              <div class="row">
                <div class="col-md-7 col-lg-6 ">
                  <div class="detail-box">
                    <h1>
                	      호흡으로 시작하는 <br>새로운 세상
                    </h1>
                    <p>
                    	  인강호흡은 호흡을 시작으로, 새로운 지식과 실력을<br> 만들어 나갈 수 있는 참된 경험을 제공합니다
                    </p>
                    <div class="btn-box">
                      <a href="/course/list.do" class="btn1">
                        	강의 보러가기
                      </a>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
<!--           <div class="carousel-item "> -->
<!--             <div class="container "> -->
<!--               <div class="row"> -->
<!--                 <div class="col-md-7 col-lg-6 "> -->
<!--                   <div class="detail-box"> -->
<!--                     <h1> -->
<!--                       Fast Food Restaurant -->
<!--                     </h1> -->
<!--                     <p> -->
<!--                       Doloremque, itaque aperiam facilis rerum, commodi, temporibus sapiente ad mollitia laborum quam quisquam esse error unde. Tempora ex doloremque, labore, sunt repellat dolore, iste magni quos nihil ducimus libero ipsam. -->
<!--                     </p> -->
<!--                     <div class="btn-box"> -->
<!--                       <a href="" class="btn1"> -->
<!--                         Order Now -->
<!--                       </a> -->
<!--                     </div> -->
<!--                   </div> -->
<!--                 </div> -->
<!--               </div> -->
<!--             </div> -->
<!--           </div> -->
<!--           <div class="carousel-item"> -->
<!--             <div class="container "> -->
<!--               <div class="row"> -->
<!--                 <div class="col-md-7 col-lg-6 "> -->
<!--                   <div class="detail-box"> -->
<!--                     <h1> -->
<!--                       Fast Food Restaurant -->
<!--                     </h1> -->
<!--                     <p> -->
<!--                       Doloremque, itaque aperiam facilis rerum, commodi, temporibus sapiente ad mollitia laborum quam quisquam esse error unde. Tempora ex doloremque, labore, sunt repellat dolore, iste magni quos nihil ducimus libero ipsam. -->
<!--                     </p> -->
<!--                     <div class="btn-box"> -->
<!--                       <a href="" class="btn1"> -->
<!--                         Order Now -->
<!--                       </a> -->
<!--                     </div> -->
<!--                   </div> -->
<!--                 </div> -->
<!--               </div> -->
<!--             </div> -->
<!--           </div> -->
        </div>
        <div class="container">
<!--           <ol class="carousel-indicators"> -->
<!--             <li data-target="#customCarousel1" data-slide-to="0" class="active"></li> -->
<!--             <li data-target="#customCarousel1" data-slide-to="1"></li> -->
<!--             <li data-target="#customCarousel1" data-slide-to="2"></li> -->
<!--           </ol> -->
        </div>
      </div>

    </section>
    <!-- end slider section -->
    <!-- ================================== 슬라이드 구역 ================================== -->
    </div>
    
 <!-- offer section -->
  <section class="offer_section layout_padding-bottom">
    <c:if test="${!empty teacher }">
    <div class="offer_container">
      <div class="container ">
      
	      <div class="heading_container heading_center">
	        <h2>
	          인강호흡의 선생님
	        </h2>
	      </div>
      
        <div class="row">
        
        <c:forEach items="${teacher }" var="vo">
          <div class="col-md-6  ">
            <div class="box ">
              <div class="img-box">
              <c:if test="${vo.memberimg == null }">
                <img src="/upload/member/user.png" alt="">
              </c:if>
              <c:if test="${vo.memberimg != null }">
                <img src="${vo.memberimg }" alt="">
              </c:if>
              </div>
              <div class="detail-box">
                <h5 class="h5">
                	${vo.name }
                </h5>
                <div class="introduce">
                  ${vo.introduce }
                </div>
                <a href="/course/list.do?key=n&word=${vo.name }">
                  	강의보러 가기 
                  <i class="fa fa-arrow-right teacher-arrow" style="font-size:1.4em;color:white;"></i>
                </a>
              </div>
            </div>
          </div>
        </c:forEach>
          
        </div>
      </div>
    </div>
    
    </c:if>
  </section>

  <!-- end offer section -->
  <!-- ================================== 할인구간 ================================== -->
  

  <!-- food section -->

  <section class="food_section layout_padding-bottom">
    <div class="container">
      <div class="heading_container heading_center">
        <h2>
          인강호흡의 숨결
        </h2>
      </div>

      <ul class="filters_menu">
<!--         <li class="active" data-filter="*">All</li> -->
        <li class="active" data-filter=".teacher">교재</li>
        <li data-filter=".course">강의</li>
      </ul>

      <div class="filters-content">
        <div class="row grid">
        <c:forEach items="${book }" var="vo">
          <div class="col-sm-6 col-lg-4 all teacher">
            <div class="box">
              <div>
                <div class="img-box">
                  <img src="${vo.fileName }" alt="">
                </div>
                <div class="detail-box">
                  <h5>
                    ${vo.bookName }
                  </h5>
                  <p>
                  	${vo.bookDiv }<br>
                  	${vo.publisher }
                  </p>
                  <div class="options">
                    <h6>
                      ${vo.price } 원
                    </h6>
                    <a href="book/view.do?no=${vo.bookNo }&page=1&perPageNum=8&key=&word=">
                    	<i class="fa fa-arrow-right" style="font-size:1.4em;color:white;"></i>
                    </a>
                  </div>
                </div>
              </div>
            </div>
          </div>
          </c:forEach>
          <c:forEach items="${course }" var="vo">
          
          <div class="col-sm-6 col-lg-4 all course">
            <div class="box">
              <div>
                <div class="img-box">
                  <img src="${vo.image }" alt="">
                </div>
                <div class="detail-box">
                  <h5>
					${vo.title }
                  </h5>
                  <p>
                  	강의 시작일 : <fmt:formatDate value="${vo.startDate }" pattern="yyyy-MM-dd"/><br>
                  	강의 종료일 : <fmt:formatDate value="${vo.endDate }" pattern="yyyy-MM-dd"/><br>
                  	강사명 : ${vo.name }
                  </p>
                  <div class="options">
                    <h6>
                      ${vo.price } 원
                    </h6>
                    <a href="/course/view.do?no=${vo.no }&page=1&perPageNum=10&key=&word=">
                     	<i class="fa fa-arrow-right" style="font-size:1.4em;color:white;"></i>
                    </a>
                  </div>
                </div>
              </div>
            </div>
          </div>
         </c:forEach>
          
        </div>
      </div>
      
      <div class="btn-box">
      	<div class="teacher">
	        <a href="/book/list.do">교재 더보기</a>
      	</div>
      	<div class="course">
	        <a href="/course/list.do">강의 더보기</a>
      	</div>
      </div>
      
    </div>
  </section>

  <!-- end food section -->
  <!-- ================================== 제품 목록 ================================== -->


  <!-- footer section -->
  <footer class="footer_section">
    <div class="container">
      <div class="row">
      
        <div class="col-md-6 footer-col">
          <div class="footer_detail">
            <a href="" class="footer-logo">
              인강호흡
            </a>
             <div class="footer_contact">
            <div class="contact_link_box">
              <a href="#readyModal" onclick="$('#readyModal').modal('show')">
                <i class="fa fa-map-marker" aria-hidden="true"></i>
                <span>
                  경기도 의정부시 의정부2동 신흥로258번길 25 해태프라자2층
                </span>
              </a>
              <a href="#readyModal" onclick="$('#readyModal').modal('show')">
                <i class="fa fa-phone" aria-hidden="true"></i>
                <span>
                  031-846-5888
                </span>
              </a>
              <a href="#readyModal" onclick="$('#readyModal').modal('show')">
                <i class="fa fa-envelope" aria-hidden="true"></i>
                <span>
                  ingang@gmail.com
                </span>
              </a>
            </div>
          </div>
         
          </div>
        </div>
           
        <div class="col-md-2 footer-col">

        </div>
        
        <div class="col-md-4 footer-col">
           
            <div class="footer_social">
              <a href="#readyModal" onclick="$('#readyModal').modal('show')">
                <i class="fa fa-facebook" aria-hidden="true"></i>
              </a>
              <a href="#readyModal" onclick="$('#readyModal').modal('show')">
                <i class="fa fa-twitter" aria-hidden="true"></i>
              </a>
              <a href="#readyModal" onclick="$('#readyModal').modal('show')">
                <i class="fa fa-linkedin" aria-hidden="true"></i>
              </a>
              <a href="#readyModal" onclick="$('#readyModal').modal('show')">
                <i class="fa fa-instagram" aria-hidden="true"></i>
              </a>
              <a href="#readyModal" onclick="$('#readyModal').modal('show')">
                <i class="fa fa-pinterest" aria-hidden="true"></i>
              </a>
            </div>
            
        </div>
        
        
     </div>
      
<!--       <div class="footer-info"> -->
<!--         <p> -->
<!--           &copy; <span id="displayYear"></span> All Rights Reserved By -->
<!--           <a href="https://html.design/">Free Html Templates</a><br><br> -->
<!--           &copy; <span id="displayYear"></span> Distributed By -->
<!--           <a href="https://themewagon.com/" target="_blank">ThemeWagon</a> -->
<!--         </p> -->
<!--       </div> -->
    </div>
  </footer>
  <!-- footer section -->
  
  
	
	<!-- 준비중 div -->
	<div class="modal" id="readyModal">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal body -->
				<div class="modal-body">
					<div class="form-group" id="modal-delete-content">
						<div class="small-modal-content icon-content" id="small-modal-delete-content">
						    <span class="infd-icon"><svg width="56" aria-hidden="true" focusable="false" data-prefix="fal" data-icon="exclamation-triangle" class="svg-inline--fa fa-exclamation-triangle fa-w-18" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"><path fill="#FFA016" d="M270.2 160h35.5c3.4 0 6.1 2.8 6 6.2l-7.5 196c-.1 3.2-2.8 5.8-6 5.8h-20.5c-3.2 0-5.9-2.5-6-5.8l-7.5-196c-.1-3.4 2.6-6.2 6-6.2zM288 388c-15.5 0-28 12.5-28 28s12.5 28 28 28 28-12.5 28-28-12.5-28-28-28zm281.5 52L329.6 24c-18.4-32-64.7-32-83.2 0L6.5 440c-18.4 31.9 4.6 72 41.6 72H528c36.8 0 60-40 41.5-72zM528 480H48c-12.3 0-20-13.3-13.9-24l240-416c6.1-10.6 21.6-10.7 27.7 0l240 416c6.2 10.6-1.5 24-13.8 24z"></path></svg></span>
						    <span class="description">서비스 준비중입니다.</span>
						    
						  </div>
					</div>
				</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-outline-primary" data-dismiss="modal">닫기</button>
				</div>

			</div>
		</div>
	</div>
		
  
  

  <!-- jQery -->
  <script src="/js/jquery-3.4.1.min.js"></script>
  <!-- popper js -->
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous">
  </script>
  <!-- bootstrap js -->
  <script src="/js/bootstrap.js"></script>
  <!-- owl slider -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js">
  </script>
  <!-- isotope js -->
  <script src="https://unpkg.com/isotope-layout@3.0.4/dist/isotope.pkgd.min.js"></script>
  <!-- nice select -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/js/jquery.nice-select.min.js"></script>
  <!-- custom js -->
  <script src="/js/custom.js"></script>

</body>

</html>