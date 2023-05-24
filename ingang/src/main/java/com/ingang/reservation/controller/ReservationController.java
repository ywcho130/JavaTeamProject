package com.ingang.reservation.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ingang.member.vo.MemberVO;
import com.ingang.mentoring.service.MentoringService;
import com.ingang.mentoring.vo.MentoringVO;
import com.ingang.message.service.MessageService;
import com.ingang.message.vo.MessageVO;
import com.ingang.messageroom.service.MessageRoomService;
import com.ingang.messageroom.vo.MessageRoomVO;
import com.ingang.reservation.service.ReservationService;
import com.ingang.reservation.vo.ReservationVO;

@Controller
@RequestMapping("/reservation")
public class ReservationController {

	@Autowired
	@Qualifier("reservationServiceImpl")
	private ReservationService reservationservice;
	@Autowired
	@Qualifier("messageRoomServiceImpl")
	private MessageRoomService messageroomservice;
	@Autowired
	@Qualifier("mentoringServiceImpl")
	private MentoringService mentoringservice;
	@Autowired
	@Qualifier("messageServiceImpl")
	private MessageService messageservice;


	
	@GetMapping("/write.do")
	public String writeForm(long mno , Model model) {

	    MentoringVO mentoringVO = mentoringservice.getvo(mno);
	    model.addAttribute("vo", mentoringVO);
	    // ArrayList를 쓰는 이유 : 중복값 포함, 순서유지 , 날짜를 동적으로 추가할 수 있음
	    List<Date> avaDateList = new ArrayList<>();
	    // 예약 가능한 시간을 담아와서 모델객체에 보내고 싶은데 아직 구현을 제대로 못하겠다...
	    // 그래서 일단 빈 객체로 보내서 모든 시간대를 선택할 수 있게 했다.
	    model.addAttribute("resDate", avaDateList);
	    List<Long> avaTimeList = new ArrayList<>();
	    List<Long> reservedTimeList = reservationservice.findrestime(mno);
	    // mno에 해당하는 예약가능 시간 조회 후 예약된 시간 리스트에 담기

	    
	    // mentoringVO의 avaStartTime부터 avaEndTime까지 60분 간격으로 반복.
	    for (Long time = mentoringVO.getAvaStartTime(); time <= mentoringVO.getAvaEndTime(); time += 60) {
	    	// reservedTimeList에 현재 시간이 포함되어 있지 않으면 availableTimeList에 해당 시간을 추가
	        if (!reservedTimeList.contains(time)) {
	            avaTimeList.add(time);
	        }
	    }

	    model.addAttribute("resTime", avaTimeList);

	    return "reservation/write";
	}
	
	

	@PostMapping("/write.do")
	public String write(MessageVO msvo,ReservationVO rvo, MessageRoomVO mvo, HttpServletRequest request)
	        throws ParseException {

		// SimpleDateFormat은 날짜와 시간을 원하는 형식으로 포맷팅하거나 파싱하기 위해 사용된다.
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	    Date resDate = sdf.parse(request.getParameter("resDate"));
	    MemberVO memberVO = (MemberVO) request.getSession().getAttribute("login");
	    long mno = Long.parseLong(request.getParameter("mno"));
	    long resTime = Long.parseLong(request.getParameter("resTime"));
	    long rno = reservationservice.findrno(mno, memberVO.getId());

	    if (rno > 0) { // 예약 있으면 - 예약 실행 x
	        return "reservation/cancel";
	    }

	    // 예약 없을떄 - 예약 실행
	    reservationservice.write(rvo);
	    mvo.setMno(mno);
	    mvo.setResDate(resDate);
	    mvo.setLmcontent(request.getParameter("greetings"));
	    mvo.setMemberimg(memberVO.getMemberimg());
	    mvo.setPar1(request.getParameter("aid"));
	    mvo.setPar2(request.getParameter("mid"));
	    mvo.setResTime(resTime);
	    mvo.setField(request.getParameter("field"));
	    mvo.setMemberimg(request.getParameter("memberimg"));
	    messageroomservice.write(mvo);
	    
	    return "redirect:/mentoring/list.do";
	
	}
}
