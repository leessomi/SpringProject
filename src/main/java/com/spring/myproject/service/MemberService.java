package com.spring.myproject.service;

import com.spring.myproject.domain.MemberVO;

public interface MemberService {

	public int memberJoin(MemberVO member);
	
	public int idCheck(String memberId);
	
	public MemberVO memberLogin(MemberVO member);
	
	public MemberVO myPage(String memberId);
	
	public int memberUpdate(MemberVO member);
	
}
