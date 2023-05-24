package com.ingang.member.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import com.ingang.member.mapper.MemberMapper;
import com.ingang.member.vo.MemberVO;
import com.webjjang.util.PageObject;

@Service
@Qualifier("memberServiceImpl")
public class MemberServiceImpl implements MemberService{
	
	@Inject
	private MemberMapper mapper;
	
	//로그인
	@Override
	public MemberVO login(MemberVO vo) {
		System.out.println("서비스"+vo);
		mapper.conlog(vo);
		System.out.println("conlog");
		return mapper.login(vo);
	}
	
	//회원가입
	@Override
	public int join(MemberVO vo) {
		
		return mapper.join(vo);
	}
	
	//유저리스트
	@Override
	public List<MemberVO> userList(PageObject pageObject) {
		// TODO Auto-generated method stub
		
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));
		return mapper.userList(pageObject);
	}
	
	//마이메뉴
	@Override
	public MemberVO myMenu(MemberVO vo) {
		// TODO Auto-generated method stub
		return mapper.myMenu(vo);
	}
	
	//아이디중복
	@Override
	public int idCheck(String id) {
		int cnt = mapper.idCheck(id);
		System.out.println("cnt: " + cnt);
		return cnt;
	}
	
	//유저 상세정보
	@Override
	public MemberVO userView(String id) {
		// TODO Auto-generated method stub
		return mapper.userView(id);
	}
	
	//주소변경
	@Override
	public int changeAd(MemberVO vo) {
		// TODO Auto-generated method stub
		return mapper.changeAd(vo);
	}
	
	//비번찾기
	@Override
	public String findPw(String id) {
		// TODO Auto-generated method stub
		return mapper.findPw(id);
	}
	
	//등급변경
	@Override
	public int changeGrade(MemberVO vo) {
		// TODO Auto-generated method stub
		return mapper.changeGrade(vo);
	}	
	
	//카카오관련---------------
	//카카오 토큰 가져오기
	public String getKaKaoAccessToken(String code){
        String access_Token="";
        String refresh_Token ="";
        String reqURL = "https://kauth.kakao.com/oauth/token";

        try{
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            //POST 요청을 위해 기본값이 false인 setDoOutput을 true로
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);

            //POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&client_id=4b4340562db2d9ce54a6e0d8bb473c6a"); // TODO REST_API_KEY 입력
            sb.append("&redirect_uri=http://localhost/member/kakao"); // TODO 인가코드 받은 redirect_uri 입력
            sb.append("&code=" + code);
            bw.write(sb.toString());
            bw.flush();

            //결과 코드가 200이라면 성공
            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);
            //요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);

            //Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);

            access_Token = element.getAsJsonObject().get("access_token").getAsString();
            refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();

            System.out.println("access_token : " + access_Token);
            System.out.println("refresh_token : " + refresh_Token);

            br.close();
            bw.close();
        }catch (IOException e) {
            e.printStackTrace();
        }

        return access_Token;
    }
	
	//카카오 토큰으로 유저정보 가져오기
	public MemberVO createKakaoUser(String token) {

        String reqURL = "https://kapi.kakao.com/v2/user/me";
       
        MemberVO vo = null;
        //access_token을 이용하여 사용자 정보 조회
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            conn.setRequestProperty("Authorization", "Bearer " + token); //전송할 header 작성, access_token전송

            //결과 코드가 200이라면 성공
            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);

            //요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);

            //Gson 라이브러리로 JSON파싱
            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);

            Long id = element.getAsJsonObject().get("id").getAsLong();
            boolean hasEmail = element.getAsJsonObject().get("kakao_account").getAsJsonObject().get("has_email").getAsBoolean();
            String email = "";
            if (hasEmail) {
                email = element.getAsJsonObject().get("kakao_account").getAsJsonObject().get("email").getAsString();
            }
            vo = new MemberVO();
            System.out.println("id : " + id);
            System.out.println("email : " + email);
            String strId = Long.toString(id);
            vo.setId(strId);
            vo.setEmail(email);
            br.close();
           
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println("서비스" + vo);
        return vo;
    }
	
	
	//카카오 가입여부
	@Override
	public int searchId(MemberVO vo) {
		// TODO Auto-generated method stub
		return mapper.searchId(vo);
	}
	
	
	//카카오가입
	@Override
	public int joinKakao(MemberVO vo) {
		// TODO Auto-generated method stub
		return mapper.joinKakao(vo);
	}
	
	//카카오로그인
	@Override
	public MemberVO loginKakao(MemberVO vo) {
		// TODO Auto-generated method stub
		return mapper.loginKakao(vo);
	}
	//카카오관련---------------끝
	
	//탈퇴
	@Override
	public int userDelete(MemberVO vo) {
		// TODO Auto-generated method stub
		return mapper.userDelete(vo);
	}
	
	//최근접속일
	@Override
	public int conlog(MemberVO vo) {
		// TODO Auto-generated method stub
		return mapper.conlog(vo);
	}
	
	//휴면으로전환
	@Override
	public int sleepUser() {
		// TODO Auto-generated method stub
		return mapper.sleepUser();
	}
	//------------------멘토관련
	//멘토 신청
	@Override
	public int changeMP(String id) {
		// TODO Auto-generated method stub
		return mapper.changeMP(id);
	}
	
	//멘토신청리스트
	@Override
	public List<MemberVO> mentoPList() {
		// TODO Auto-generated method stub
		return mapper.mentoPList();
	}

	//멘토승낙
	@Override
	public int mentoApp(String id) {
		// TODO Auto-generated method stub
		return mapper.mentoApp(id);
	}
	//------------------멘토관련 끝
	
	//비번 번경
	@Override
	public int changePw(MemberVO vo) {
		// TODO Auto-generated method stub
		return mapper.changePw(vo);
	}

	@Override
	public List<MemberVO> teacherList() {
		// TODO Auto-generated method stub
		return mapper.teacherList();
	}
	
	

}
