package com.ingang.message.service;

import java.util.List;

import com.ingang.message.vo.MessageVO;

public interface MessageService {

	public List<MessageVO> list(String id, String par1, long roomno);

	public int write(MessageVO vo);

	public int allunreadcount(String id);

}
