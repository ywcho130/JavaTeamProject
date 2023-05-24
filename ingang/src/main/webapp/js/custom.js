// to get current year
//function getYear() {
//    var currentDate = new Date();
//    var currentYear = currentDate.getFullYear();
//    document.querySelector("#displayYear").innerHTML = currentYear;
//}
//
//getYear();


// isotope js
$(window).on('load', function () {

    var $grid = $(".grid").isotope({
        itemSelector: ".all",
        percentPosition: false,
        masonry: {
            columnWidth: ".all"
        },
		filter: ".teacher" // 초기 필터링값
    })
   
	// '.filters_menu .teacher' 요소에 대한 click이벤트 트리거링 후 isotope 필터링 수행
	$grid.isotope({ filter : '.teacher'});
	$('.filters_menu .teacher').addClass('active');
	$('.btn-box .course').hide(); // 초기 강사 필터링에서는 강의버튼 숨김

	// 필터링을 위한 click 이벤트 등록
 	$('.filters_menu li').click(function () {
        $('.filters_menu li').removeClass('active');
        $(this).addClass('active');

        var data = $(this).attr('data-filter');
        $grid.isotope({
            filter: data
        })

		// 필터링 값에 따라 버튼 보이기/숨기기
		if(data === '.teacher'){
			$('.btn-box .teacher').show();
			$('.btn-box .course').hide();
		} else {
			$('.btn-box .teacher').hide();
			$('.btn-box .course').show();
		}
		
    });


});

// nice select
$(document).ready(function() {
    $('select').niceSelect();
  });


// client section owl carousel
$(".client_owl-carousel").owlCarousel({
    loop: true,
    margin: 0,
    dots: false,
    nav: true,
    navText: [],
    autoplay: true,
    autoplayHoverPause: true,
    navText: [
        '<i class="fa fa-angle-left" aria-hidden="true"></i>',
        '<i class="fa fa-angle-right" aria-hidden="true"></i>'
    ],
    responsive: {
        0: {
            items: 1
        },
        768: {
            items: 2
        },
        1000: {
            items: 2
        }
    }
});