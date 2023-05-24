package com.ingang.reservation.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ingang.reservation.mapper.ReservationMapper;
import com.ingang.reservation.vo.ReservationVO;

import lombok.Setter;

@Service
@Qualifier("reservationServiceImpl")
public class ReservationServiceImpl implements ReservationService {

	@Setter(onMethod_ = @Autowired)
	private ReservationMapper mapper;

	@Override
	public int write(ReservationVO vo) {
		// TODO Auto-generated method stub
		return mapper.write(vo);
	}

	@Override
	public long findrno(long mno, String id) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mno", mno);
		map.put("aid", id);

		return mapper.findrno(map);
	}

	@Override
	public List<Long> findrestime(long mno) {
		// TODO Auto-generated method stub
		return mapper.findrestime(mno);
	}

	@Override
	public List<Date> findresdate(long mno) {
		// TODO Auto-generated method stub
		return mapper.findresdate(mno);
	}

	@Override
	public long reserved(long roomno) {
		// TODO Auto-generated method stub
		return mapper.reserved(roomno);
	}

	@Override
	public long denied(long roomno) {
		// TODO Auto-generated method stub
		return mapper.denied(roomno);
	}


} 
