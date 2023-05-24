package com.ingang.reservation.service;

import java.util.Date;
import java.util.List;

import com.ingang.reservation.vo.ReservationVO;

public interface ReservationService {

	public int write(ReservationVO vo);

	public long findrno(long mno, String id);

	public List<Date> findresdate(long mno);

	public List<Long> findrestime(long mno);

	public long reserved(long roomno);

	public long denied(long roomno);

}
