package com.ingang.mentoring.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ingang.member.service.MemberService;
import com.ingang.member.vo.MemberVO;
import com.ingang.mentoring.service.MentoringService;
import com.ingang.mentoring.vo.MentoringVO;
import com.ingang.message.service.MessageService;
import com.webjjang.util.PageObject;

@Controller
@RequestMapping("/mentoring")
public class MentoringController {

	// 의존성 주입
	@Autowired 
	// 동일한 타입의 빈이 여러 개 있을 경우에 어떤 빈을 주입할지를 지정하기 위해 사용
	@Qualifier("mentoringServiceImpl") 
	private MentoringService service;
	@Autowired 
	@Qualifier("memberServiceImpl")
	private MemberService memberservice;
	@Autowired
	@Qualifier("messageServiceImpl")
	private MessageService messageservice;

	@RequestMapping("/list.do")
	// @ModelAttribute("pageObject")를 통해 "pageObject"라는 이름으로 모델에 객체를 추가한다. (페이징 처리)
	// 모델에 필요한 데이터를 추가한 후, "mentoring/list"라는 뷰를 반환.
	public String list(@ModelAttribute("pageObject") PageObject pageObject, Model model, HttpServletRequest request) {
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("login");
		model.addAttribute("list", service.list(pageObject));
		model.addAttribute("mento", memberservice.userView(memberVO.getId()));
		model.addAttribute("unreadcount", messageservice.allunreadcount(memberVO.getId()));
		return "mentoring/list";
	}

	@RequestMapping("/flist.do")
	// 파라미터로 String[] checkedValues를 받는다. (분야 체크 항목을 배열로 받아오기)
	public String flist(String[] checkedValues, @ModelAttribute("pageObject") PageObject pageObject, Model model,
			HttpServletRequest request) {
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("login");
		model.addAttribute("flist", service.flist(checkedValues, pageObject));
		model.addAttribute("mento", memberservice.userView(memberVO.getId()));
		model.addAttribute("unreadcount", messageservice.allunreadcount(memberVO.getId()));
		return "mentoring/flist";
	}

	@RequestMapping("/view.do")
	public String view(long mno, Model model, HttpServletRequest request) {
		MemberVO memberVO = (MemberVO) request.getSession().getAttribute("login");
		model.addAttribute("vo", service.view(mno));
		model.addAttribute("mento", memberservice.userView(memberVO.getId()));
		return "mentoring/view";
	}

	@GetMapping("/write.do")
	public String writeForm() {
		return "mentoring/write";
	}

	@PostMapping("/write.do")
	public String write(MentoringVO vo, RedirectAttributes rttr) {
		service.write(vo);

		rttr.addFlashAttribute("msg", "글등록이 되었습니다.");

		return "redirect:list.do";
	}

	@GetMapping("/update.do")
	public String updateForm(long mno, Model model) {
		model.addAttribute("vo", service.view(mno));
		return "mentoring/update";
	}

	@PostMapping("/update.do")
	public String update(MentoringVO vo, RedirectAttributes rttr, HttpServletRequest request) {
		service.update(vo);
		rttr.addFlashAttribute("msg", "글수정이 되었습니다.");
		return "redirect:view.do?mno=" + vo.getMno() + "&mid=" + request.getParameter("mid") + "&page="
				+ request.getParameter("page") + "&perPageNum=" + request.getParameter("perPageNum");
	}

	@GetMapping("/deadline.do")
	public String deadline(long mno, RedirectAttributes rttr) {
		service.deadline(mno);

		rttr.addFlashAttribute("msg", "마감처리 되었습니다.");

		return "redirect:list.do";
	}

}
