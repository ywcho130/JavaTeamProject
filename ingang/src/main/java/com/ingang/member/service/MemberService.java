package com.ingang.member.service;

import java.util.List;

import com.ingang.member.vo.MemberVO;
import com.webjjang.util.PageObject;

public interface MemberService {
	
	public MemberVO login(MemberVO vo);
	
	public int join(MemberVO vo);
	
	public List<MemberVO> userList(PageObject pageObject);
	
	public MemberVO myMenu(MemberVO vo);
	
	public int idCheck(String id);
	
	public MemberVO userView(String id);
	
	public int changeAd(MemberVO vo);
	
	public String findPw(String id);
	
	public int changeGrade(MemberVO vo);
	
	public String getKaKaoAccessToken(String code);
	
	public MemberVO createKakaoUser(String token);
	
	public int searchId(MemberVO vo);
	
	public int joinKakao(MemberVO VO);
	
	public MemberVO loginKakao(MemberVO vo);
	
	public int userDelete(MemberVO vo);
	
	public int conlog(MemberVO vo);
	
	public int sleepUser();
	
	public int changePw(MemberVO vo);
	
	public int changeMP(String id);
	
	public  List<MemberVO> mentoPList();
	
	public int mentoApp(String id );
	
	public List<MemberVO> teacherList();

}
