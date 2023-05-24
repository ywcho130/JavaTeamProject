package com.ingang.message.controller;


import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ingang.member.vo.MemberVO;
import com.ingang.message.service.MessageService;
import com.ingang.message.vo.MessageVO;
import com.ingang.messageroom.service.MessageRoomService;
import com.ingang.messageroom.vo.MessageRoomVO;

@Controller
@RequestMapping("/message")
public class MessageController {

	@Autowired
	@Qualifier("messageRoomServiceImpl")
	private MessageRoomService messageroomservice;
	@Autowired
	@Qualifier("messageServiceImpl")
	private MessageService messageservice;


	@RequestMapping("/list.do")
	public String list(Model model, HttpServletRequest request) {

		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("login");

		String par1 = request.getParameter("par1");
		long roomno = Long.parseLong(request.getParameter("roomno"));

		model.addAttribute("list", messageservice.list(memberVO.getId(), par1, roomno));
		model.addAttribute("vo", messageroomservice.getvo(roomno));
		messageroomservice.utcservice(roomno, memberVO.getId());
		messageroomservice.adtonull(memberVO.getId());
		request.getSession().setAttribute("unreadCount",
				messageservice.allunreadcount(((MemberVO) request.getSession().getAttribute("login")).getId()));

		return "message/list";
	}

	@PostMapping("/write.do")
	public String write(MessageVO vo, HttpServletRequest request) {

		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("login");
		MessageRoomVO mrvo = new MessageRoomVO();
		long roomno = Long.parseLong(request.getParameter("roomno"));
		String par1 = request.getParameter("par1");
		System.out.println(roomno);
		vo.setRoomno(roomno);
		vo.setSender(memberVO.getId());
		vo.setAccepter(par1);
		mrvo.setLmcontent(vo.getContent());
		mrvo.setRoomno(roomno);
		messageservice.write(vo);
		messageroomservice.increase(roomno, par1, memberVO.getId());
		messageroomservice.updatelmcontent(mrvo);
		return "redirect:list.do?par1=" + par1 + "&roomno=" + roomno;
	}

}
