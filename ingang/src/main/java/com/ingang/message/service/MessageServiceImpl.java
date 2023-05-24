package com.ingang.message.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ingang.message.mapper.MessageMapper;
import com.ingang.message.vo.MessageVO;

import lombok.Setter;

@Service
@Qualifier("messageServiceImpl")
public class MessageServiceImpl implements MessageService {

	@Setter(onMethod_ = @Autowired)
	private MessageMapper mapper;

	@Override
	public List<MessageVO> list(String id, String par1, long roomno) {
		// HashMap을 사용함으로써 키와 값을 쉽게 매핑하고, 필요한 데이터를 검색하고 전달하는 데 효율적으로 사용할 수 있다.
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("par1", par1);
		map.put("roomno", roomno);

		return mapper.list(map);
	}

	@Override
	public int write(MessageVO vo) {
		// TODO Auto-generated method stub
		return mapper.write(vo);
	}

	@Override
	public int allunreadcount(String id) {
		// TODO Auto-generated method stub
		return mapper.allunreadcount(id);
	}

} // end of CourseServiceImpl class
