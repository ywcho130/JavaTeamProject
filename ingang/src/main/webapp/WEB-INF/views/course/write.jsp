<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강의 등록 폼</title>

<script type="text/javascript">

// 등록취소
$(function() {
 	$("#cancelBtn").click(function() {
 		history.back();
 	});
});

$(function(){

	var vid = null;
	
	$("#vid").focusout(function(){
		vid = $(this).val();
		console.log(vid);
	    if(player){
	        player.destroy();
	    }
	    onYouTubeIframeAPIReady();
	});
	
    // 2. This code loads the IFrame Player API code asynchronously.
    var tag = document.createElement('script');

    tag.src = "https://www.youtube.com/iframe_api";
    var firstScriptTag = document.getElementsByTagName('script')[0];
    firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

    // 3. This function creates an <iframe> (and YouTube player)
    //    after the API code downloads.
    var player;
    var watchTime = 0; // 누적 시청 시간을 저장할 변수
    
    function onYouTubeIframeAPIReady() {

        if(!vid){
            return; // vid 값이 설정되어 있지 않으면 함수 종료
        }
        
    	  var playerContainer = document.getElementById('player');
    	  var containerWidth = playerContainer.offsetWidth;
    	  var containerHeight = containerWidth * 0.5625; // 16:9 비율로 계산 (640x360)
    	  
      player = new YT.Player('player', {
   		height: containerHeight,
   	    width: containerWidth,
        videoId: vid, // 유튜브 아이디 - db에 저장
        events: {
            'onReady': onPlayerReady,
        }
      });
    }

    // 5. The API calls this function when the player's state changes.
    //    The function indicates that when playing a video (state=1),
    //    the player should play for six seconds and then stop.
    var done = false;
    
    function onPlayerReady(event){
        var duration2 = player.getDuration();
        console.log("duration2 : "+duration2);
        $("#vidlength").val(duration2);
    }
	
});

</script>

</head>
<body>
	<!-- 전체 -->
	<div class="card shadow md-4">
		<div class="card-header py-3">강의 등록 (관리자 권한)</div>
		<div class="card-body">
			<form action="write.do" method="post" enctype="multipart/form-data">
				<div class="row">
				
					<!-- left -->
					<div class="col-md-6">
						<div class="form-group">
							<label>강의명</label>
							<input name="title" class="form-control" id="title">
						</div>
						<div class="form-group">
							<label>담당자</label>
							<input name="teacher" class="form-control" id="teacher">
						</div>
						<div class="form-group">
							<label>내용</label>
							<textarea rows="7" name="content" class="form-control" id="content"></textarea>
						</div>
					</div>
					
					<!-- right -->
					<div class="col-md-6" align="right">
						<div class="form-group">
							<label>이미지</label>
							<input name="imageM" class="form-control" id="imageM" type="file">
						</div>
						<br />
						<div class="form-group">
							<label>동영상</label>
							<input name="vid" class="form-control" id="vid">
						</div>
						<input type="hidden" name="vidlength" class="form-control" id="vidlength" readonly="readonly">
						<br />
						<div class="form-group">
							<label>관련교재</label>			
							<input name="cbno" class="form-control" value="${vo.cbno }">
						</div>
						<br />
						<div class="form-group">
							<label>강의가격</label>
							<input name="price" class="form-control" id="price">
						</div>
					</div>
				</div>
				<div>
					<div class="form-group col-md-4">
						<label>시작일</label>
						<input name="startDate" class="form-control" id="startDate" type="date">
					</div>
					<div class="form-group col-md-4">
						<label>종료일</label>
						<input name="endDate" class="form-control" id="endDate" type="date">
					</div>
					<div class="form-group col-md-2">
						<!-- 작성자(관리자) : 로그인 정보  -->
						<h6>작성자(관리자)</h6>
						<input name="writer" class="form-control" id="writer" value="${login.id }" readonly="readonly">
					</div>
				</div><br/>
				<button class="btn btn-success">등록</button>
				<button type="reset" class="btn btn-dark">새로입력</button>
				<button class="btn btn-warning" type="button" id="cancelBtn">이전</button>
			</form>
		</div>
	</div>
	
	<div id="player" style="display: none;"></div>
	
</body>
</html>