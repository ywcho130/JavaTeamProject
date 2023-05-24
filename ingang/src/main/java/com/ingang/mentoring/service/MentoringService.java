package com.ingang.mentoring.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ingang.mentoring.vo.MentoringVO;
import com.webjjang.util.PageObject;

//멘토링 관련 기능을 추상화하고 이를 구현한 클래스에서 실제 동작을 구현해야한다.
//추상화를 하는 이유 : 복잡성을 감소시키고 모듈화, 재사용성, 유연성, 확장성, 팀 작업 등을 향상시키는 중요한 개념이다.
//추상화를 통해 개발자는 핵심 개념과 기능에 집중하고, 더 효과적이고 유지보수 가능한 소프트웨어를 개발할 수 있다.
public interface MentoringService {
	

	public List<MentoringVO> list(PageObject pageObject);
	
	public List<MentoringVO> flist(@Param("checkedValues") String[] checkedValues, @Param("pageObject") PageObject pageObject);

	public MentoringVO view(long mno);
	
	public int write(MentoringVO vo);
	
	public int update(MentoringVO vo);

	public int deadline(long mno);

	public Object viewStartDate(long mno);

	public Object viewEndDate(long mno);

	public MentoringVO getvo(long mno);

	public int timer();

}
