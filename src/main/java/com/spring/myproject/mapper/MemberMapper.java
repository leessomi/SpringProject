package com.spring.myproject.mapper;

import com.spring.myproject.domain.AuthVO;
import com.spring.myproject.domain.MemberVO;

public interface MemberMapper {

	public int memberJoin(MemberVO member);
	
	public int idCheck(String memberId);
	
	public MemberVO memberLogin(MemberVO member);
	
	public MemberVO myPage(String memberId);
	
	public int memberUpdate(MemberVO member);
	
	public MemberVO read(String memberId);
	
	public int memberAuth(AuthVO aVO);
}
