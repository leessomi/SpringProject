package com.spring.myproject.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.spring.myproject.domain.MemberVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MemberMapperTests {

	@Setter(onMethod_ = {@Autowired})
	private MemberMapper mapper;
	
	/*
	@Test
	public void TestMemberJoin() {
		
		MemberVO member = new MemberVO();
		
		member.setMemberId("test1");
		member.setMemberPw("test1");
		member.setMemberName("test1");
		member.setMemberMail("test1");
		member.setMemberAddr1("test1");
		member.setMemberAddr2("test1");
		member.setMemberAddr3("test1");
		
		mapper.memberJoin(member);
	}
	
	@Test
	public void TestMemberLogin() {
		
		MemberVO member = new MemberVO();
		
		member.setMemberId("ttt");
		member.setMemberPw("ttt");
		
		//member.setMemberId("test123");
		//member.setMemberPw("test123");
		
		mapper.memberLogin(member);
		
		log.info(mapper.memberLogin(member));
	}
	
	@Test
	public void TestMemberIdCk() {
		
		String id = "admin";
		String id2 = "test123";
		mapper.idCheck(id);
		mapper.idCheck(id2);
	}*/
	
	@Test
	public void testRead() {

		MemberVO member = mapper.read("sora");

		log.info(member);

		member.getAuthList().forEach(authVO -> log.info(authVO));

	}
	
}
