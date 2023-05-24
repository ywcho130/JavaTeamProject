package com.ingang.cartOrder.service;


import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import com.ingang.cart.vo.CartVO;
import com.ingang.cartOrder.mapper.CartOrderMapper;
import com.ingang.cartOrder.vo.CartOrderVO;
import lombok.Setter;

@Service
@Qualifier("cartOrderServiceImpl")
public class CartOrderServiceImpl implements CartOderService {

	@Setter(onMethod_ = @Autowired)
	private CartOrderMapper mapper;
	
	@Override
	public int bookCartOrder(CartOrderVO vo) {
		// TODO Auto-generated method stub
	
		return mapper.bookCartOrder(vo);
	}
	@Override
	public int bookCartOrderDetail(CartOrderVO vo) {
		// TODO Auto-generated method stub
		
		return mapper.bookCartOrderDetail(vo);
	}
	@Override
	public int courseCartOrder(CartOrderVO vo) {
		// TODO Auto-generated method stub
		
		return mapper.courseCartOrder(vo);
	}
	@Override
	public int courseCartOrderDetail(CartOrderVO vo) {
		// TODO Auto-generated method stub
		return mapper.courseCartOrderDetail(vo);
	}

	@Override
	public List<CartVO> getCartList(CartVO vo) {
		
		
		
		return mapper.getCartList(vo);
	}
	@Override
	public int orderDelCart(CartOrderVO vo) {
		// TODO Auto-generated method stub
		return mapper.orderDelCart(vo);
	}

}
