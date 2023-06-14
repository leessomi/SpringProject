package com.spring.myproject.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.myproject.domain.AuthVO;
import com.spring.myproject.domain.MemberVO;
import com.spring.myproject.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class MemberServiceImpl implements MemberService {
	
	@Setter(onMethod_ = @Autowired)
	private BCryptPasswordEncoder pwEncoder;

	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	@Transactional
	@Override
	public int memberJoin(MemberVO member) {
		
		String memberId = member.getMemberId();
		String memberPw = member.getMemberPw();
		
		String bcriptPw = pwEncoder.encode(memberPw);
		
		member.setMemberPw(bcriptPw);
		
		AuthVO auth = new AuthVO();
		
		auth.setAuth("ROLE_MEMBER");
		auth.setMemberId(memberId);
		
		mapper.memberJoin(member);
		
		int result = mapper.memberAuth(auth);
		
		return result;
		
	}
	
	@Override
	public int idCheck(String memberId) {
		
		return mapper.idCheck(memberId);
	}
	
	@Override
	public MemberVO memberLogin(MemberVO member) {
		
		log.info("memberLogin.....");
		
		return mapper.memberLogin(member);
	}
	
	@Override
	public MemberVO myPage(String memberId) {
		
		log.info("myPage.....");
		
		return mapper.myPage(memberId);
	}
	
	@Transactional
	@Override
	public int memberUpdate(MemberVO member) {
		
		String memberId = member.getMemberId();
		String memberPw = member.getMemberPw();
		
		String bcriptPw = pwEncoder.encode(memberPw);
		
		member.setMemberPw(bcriptPw);
		
		AuthVO auth = new AuthVO();
		
		auth.setAuth("ROLE_MEMBER");
		auth.setMemberId(memberId);
		
		mapper.memberUpdate(member);
		
		int result = mapper.memberAuth(auth);
		
		return result;
	}
	
}
