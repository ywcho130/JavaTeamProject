package com.ingang.m_apply.mapper;

import java.util.List;


import com.ingang.m_apply.vo.M_applyVO;
import com.ingang.mentoring.vo.MentoringVO;
import com.webjjang.util.PageObject;

public interface M_applyMapper {

	public List<MentoringVO> list(PageObject pageObject);

	public long getTotalRow(PageObject pageObject);
	
	public int write(M_applyVO vo);


}
