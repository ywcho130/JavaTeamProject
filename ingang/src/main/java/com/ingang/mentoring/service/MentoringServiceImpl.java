package com.ingang.mentoring.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ingang.mentoring.mapper.MentoringMapper;
import com.ingang.mentoring.vo.MentoringVO;
import com.webjjang.util.PageObject;

import lombok.Setter;


@Service
@Qualifier("mentoringServiceImpl")
public class MentoringServiceImpl implements MentoringService{
	
	// MentoringMapper객체를 자동으로 주입하는 어노테이션 Setter
	@Setter(onMethod_ = @Autowired)
	private MentoringMapper mapper;
	
	@Override
	public List<MentoringVO> list(PageObject pageObject) {
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));
		return mapper.list(pageObject);
	}

	@Override
	public MentoringVO view(long mno) {
		// TODO Auto-generated method stub
		return mapper.view(mno);
	}

	@Override
	public List<MentoringVO> flist(String[] checkedValues, PageObject pageObject) {
		// TODO Auto-generated method stub
		return mapper.flist(checkedValues, pageObject);
	}

	@Override
	public int write(MentoringVO vo) {
		// TODO Auto-generated method stub
		return mapper.write(vo);
	}

	@Override
	public int update(MentoringVO vo) {
		// TODO Auto-generated method stub
		return mapper.update(vo);
	}

	@Override
	public int deadline(long mno) {
		// TODO Auto-generated method stub
		return mapper.deadline(mno);
		
	}

	@Override
	public Object viewStartDate(long mno) {
		// TODO Auto-generated method stub
		return mapper.viewStartDate(mno);
	}

	@Override
	public Object viewEndDate(long mno) {
		// TODO Auto-generated method stub
		return mapper.viewEndDate(mno);
	}

	@Override
	public MentoringVO getvo(long mno) {
		// TODO Auto-generated method stub
		return mapper.getvo(mno);
	}

	@Override
	public int timer() {
		// TODO Auto-generated method stub
		return mapper.timer();
	}
	// 보기
	// 등록
	// 수정
	// 삭제

} // end of CourseServiceImpl class
