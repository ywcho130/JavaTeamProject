package com.ingang.mentoring.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ingang.mentoring.vo.MentoringVO;
import com.webjjang.util.PageObject;

// Mentoring 객체와 관련된 데이터베이스 작업을 수행하는 MentoringMapper 인터페이스
// MyBatis를 사용하여 SQL 쿼리와의 매핑을 담당한다.
public interface MentoringMapper {

	public List<MentoringVO> list(PageObject pageObject);

	public long getTotalRow(PageObject pageObject);

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
