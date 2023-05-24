package com.ingang.messageroom.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ingang.member.service.MemberService;
import com.ingang.member.vo.MemberVO;
import com.ingang.messageroom.service.MessageRoomService;
import com.ingang.reservation.service.ReservationService;

@Controller
@RequestMapping("/messageroom")
public class MessageRoomController {
	
	@Autowired
	@Qualifier("messageRoomServiceImpl")
	private MessageRoomService mrservice;
	@Autowired
	@Qualifier("memberServiceImpl")
	private MemberService mbservice;
	@Autowired
	@Qualifier("reservationServiceImpl")
	private ReservationService resservice;
	@RequestMapping("/list.do")
	public String list(String id,Model model, HttpServletRequest request) {
		
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("login");
		
		model.addAttribute("list", mrservice.list(memberVO.getId()));
		model.addAttribute("mento", mbservice.userView(memberVO.getId()));
		
		return "messageroom/list";
	}
	
	@PostMapping("/updatea.do")
	public String updatea(long roomno, RedirectAttributes rttp) {
		
		mrservice.updatea(roomno);
		resservice.reserved(roomno);
		return "redirect:list.do";
		
	}
	@PostMapping("/updatep.do")
	public String updatep(long roomno, RedirectAttributes rttp) {
		
		mrservice.updatep(roomno);
		resservice.reserved(roomno);
		
		return "redirect:list.do";
		
	}
	@PostMapping("/updater.do")
	public String updater(long roomno, RedirectAttributes rttp) {
		
		mrservice.updater(roomno);
		resservice.denied(roomno);
		return "redirect:list.do";
		
	}
	@PostMapping("/updatet.do")
	public String updatet(long roomno) {
		
		mrservice.updatet(roomno);
		
		return "redirect:list.do";
		
	}

}
