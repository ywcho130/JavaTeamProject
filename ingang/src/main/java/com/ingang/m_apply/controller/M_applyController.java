package com.ingang.m_apply.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ingang.m_apply.service.M_applyService;
import com.ingang.m_apply.vo.M_applyVO;
import com.ingang.member.service.MemberService;
import com.webjjang.util.PageObject;

@Controller
@RequestMapping("/m_apply")
public class M_applyController {

	@Autowired
	@Qualifier("m_applyServiceImpl")
	private M_applyService m_applyService;
	
	@Autowired
	@Qualifier("memberServiceImpl")
	private MemberService memberservice;


	@RequestMapping("/list.do")
	public String list(@ModelAttribute("pageObject") PageObject pageObject, Model model) {

		model.addAttribute("list", m_applyService.list(pageObject));

		return "m_apply/list";
	}


	
	@GetMapping("/write.do")
	public String writeForm() {
		return "m_apply/write";
	}
	@PostMapping("/write.do")
	public String write(M_applyVO vo, RedirectAttributes rttr) {
		m_applyService.write(vo);
		memberservice.changeMP(vo.getId());
		
		return "redirect:/mentoring/list.do";
	}
	

}
