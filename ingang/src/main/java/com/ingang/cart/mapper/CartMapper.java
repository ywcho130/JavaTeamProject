package com.ingang.cart.mapper;

import java.util.List;
import java.util.Map;

import com.ingang.cart.vo.CartVO;

public interface CartMapper {
	
	public List<CartVO> list(String id);
	
	
	public int addCart(CartVO vo);
	
	public int update(CartVO vo);
	
	public int delete(long cartNo);
	
	public int cartOrder(CartVO vo);

	public int allOrder(CartVO vo);
	
	public int searchBook(Map<String, Object> map);

	public int searchCourse(Map<String, Object> map);
	
	public int overLabBookInc(CartVO vo);
	
	public int deleteAll(String id);	

}
