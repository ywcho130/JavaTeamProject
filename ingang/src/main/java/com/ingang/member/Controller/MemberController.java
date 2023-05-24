package com.ingang.member.Controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ingang.member.service.MailSendService;
import com.ingang.member.service.MemberService;
import com.ingang.member.vo.MemberVO;
import com.webjjang.util.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/member")
@Log4j
public class MemberController {

	@Autowired
	@Qualifier("memberServiceImpl")
	private MemberService service;
	
	
	@Autowired
	private MailSendService mailService;

	
	// 로그인폼
	@GetMapping("/loginForm.do")
	public String loginForm() {

		return "member/login";
	}

	// 로그인
	@PostMapping("/login.do")
	public String login(HttpSession session, MemberVO vo,RedirectAttributes redirectAttributes) {
		System.out.println(vo);
		

		MemberVO login = service.login(vo);
		log.info(login);
		if (login == null) {
			String message = "정보를 정확히 입력바랍니다.";
			redirectAttributes.addFlashAttribute("message", message);
			return "redirect:loginForm.do";
		}
		else if(login.getStatus().equals("휴면")) {
			String message = "휴면계정입니다 해제가 필요합니다.";
			redirectAttributes.addFlashAttribute("message", message);
			return "redirect:/";
		}
		else if(login.getStatus().equals("탈퇴")) {
			String message = "탈퇴한계정입니다. 관리자에게 문의하십시오";
			redirectAttributes.addFlashAttribute("message", message);
			return "redirect:/";
		}
		else {
			session.setAttribute("login", login);
			return "redirect:/";
			}
	}

	// 로그아웃
	@GetMapping("/logOut.do")
	public String logOut(HttpSession session,RedirectAttributes redirectAttributes) {
		String message = "로그아웃되었습니다..";
		redirectAttributes.addFlashAttribute("message", message);
		session.removeAttribute("login");
		return "redirect:/";
	}

	// 가입폼
	@GetMapping("/joinForm.do")
	public String joinForm() {

		return "member/join";
	}

	// 가입
	@PostMapping("/join.do")
	public String login(MemberVO vo) {
		System.out.println(vo);
		service.join(vo);

		return "redirect:/";
	}

	// 유저리스트
	@RequestMapping("/userList.do")
	public String userList(@ModelAttribute("pageObject") PageObject pageObject, Model model) {
		model.addAttribute("list", service.userList(pageObject));
		return "member/userList";
	}

	// 마이메뉴
	@GetMapping("/myMenu.do")
	public String myMenu(Model model, MemberVO vo) {
		model.addAttribute("vo", service.myMenu(vo));
		return "member/myMenu";
	}

	// 아이디중복체크
	@RequestMapping("/idcheck.do")
	@ResponseBody
	public Map<Object, Object> idcheck(@RequestBody String id) {

		int count = 0;
		Map<Object, Object> map = new HashMap<Object, Object>();

		count = service.idCheck(id);
		System.out.println(count);
		map.put("cnt", count);

		return map;
	}

	// 내정보
	@GetMapping("/userView.do")
	public String userView(Model model, String id) {
		model.addAttribute("vo", service.userView(id));
		return "member/userView";
	}

	// 약관
	@GetMapping("/check.do")
	public String check() {

		return "member/check";
	}

	// 주소변경
	@PostMapping("/changeAd.do")
	public String changeAd(MemberVO vo) {
		String id = vo.getId();
		service.changeAd(vo);
		return "redirect:userView.do?id=" + id;
	}

	// 비번찾기폼
	@GetMapping("/findPwForm.do")
	public String findPwForm() {

		return "member/findPwForm";

	}
	
	//비번찾기
	@RequestMapping("/findPw.do")
	@ResponseBody
	public Map<String, Object> findPw(@RequestBody String id) {
		System.out.println(id);
		String pw = null;
		Map<String, Object> map = new HashMap<String, Object>();
		pw = service.findPw(id);
		System.out.println(pw);
		map.put("pw", pw);
		return map;

	}
	
	//등급변경
	@PostMapping("/changeGrade.do")
	public String changeGrade(MemberVO vo) {

		service.changeGrade(vo);

		return "redirect:userList.do";
	}
	
	//탈퇴
	@RequestMapping("/userDelete.do")
	public String userDelete(MemberVO vo, RedirectAttributes redirectAttributes, HttpSession session) {
		System.out.println(vo);
		session.removeAttribute("login");
		String message = "탈퇴 완료";
		redirectAttributes.addFlashAttribute("message", message);
		int result = service.userDelete(vo);
		if(result == 1) {
			redirectAttributes.addAttribute("message","탈퇴되었습니다.");
			return "redirect:/";
		}else {
			redirectAttributes.addAttribute("message","비밀번호가 틀렸습니다..");
			return "redirect:myMenu.do?id="+vo.getId();
		}
		

	}
	
	@GetMapping("/changePwForm.do")
	public String changePwForm() {
		
		
		
		return "member/changePwForm";

	}
	
	@PostMapping("/changePw.do")
	public String changePw(MemberVO vo, RedirectAttributes redirectAttributes) {
		System.out.println(vo);
		service.changePw(vo);
		String message = "변경완료";
		redirectAttributes.addFlashAttribute("message", message);
		
		return "redirect:myMenu.do";

	}
	
	@RequestMapping("/mentoPList.do")
	public String mentoPList(Model model ) {
		
		model.addAttribute("vo",service.mentoPList());  
		
		
		return "member/mentoPList";

	}
	
	@RequestMapping("/mentoApp.do")
	public String mentoApp(String id ) {
		
		 service.mentoApp(id);
		
		
		return "redirect:mentoPList.do";

	}


	
	
	
	//카카오관련---------------------------------------------------------------------------------------------------
	
	//카카오 로그인
	@GetMapping("/kakao")
	public String kakaoCallback(@RequestParam String code, Model model, HttpSession session,RedirectAttributes redirectAttributes) {//서버로 코드 가져오기
		int searchId = 0;
		MemberVO vo = null;
		System.out.println(code);
		
		String tokken = service.getKaKaoAccessToken(code);//코드로 토큰
		
		vo = service.createKakaoUser(tokken);//토큰으로 유저정보
		
		System.out.println("카카오에서 유저정보 가져오기" + vo);
		
		searchId = service.searchId(vo);
		
		if (searchId == 0) {
			System.out.println("joinForm" + vo);
			model.addAttribute("vo", vo);
			return "redirect:joinKakaoForm.do?id=" + vo.getId() + "&email=" + vo.getEmail();

		} else {
			MemberVO login =  service.loginKakao(vo);
			if(login.getStatus().equals("휴면")) {
				String message = "휴면계정 관리자에게 문의";
				redirectAttributes.addFlashAttribute("message", message);
				return "redirect:/";
			}else if(login.getStatus().equals("탈퇴")) {
				
				String message = "탈퇴계정 관리자에게 문의";
				redirectAttributes.addFlashAttribute("message", message);
				return "redirect:/";
			}else {
			session.setAttribute("login", login);
			}
		return "redirect:/";
		}
	}
	
	//카카오 가입폼
	@GetMapping("/joinKakaoForm.do")
	public String joinKakaoForm(@ModelAttribute("vo") MemberVO vo, Model model) {

		model.addAttribute("vo", vo);
		return "member/joinKakaoForm";

	}
	
	//카카오 가입
	@PostMapping("/joinKakao.do")
	public String joinKakao(MemberVO vo) {
		System.out.println(vo);
		service.joinKakao(vo);
		return "redirect:/";

	}
	
	//카카오관련 끝---------------------------------------------------------------------------------------------------
	

	//이메일 인증
		@GetMapping("/mailCheck.do")
		@ResponseBody
		public String mailCheck(String email) {
			System.out.println("이메일 인증 요청이 들어옴!");
			System.out.println("이메일 인증 이메일 : " + email);
			return mailService.joinEmail(email);		}
}
