package com.spring.myproject.mapper;

import java.util.List;
import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import com.spring.myproject.domain.Criteria;
import com.spring.myproject.domain.ReplyVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {

	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	private Long[] bnoArr = {100L, 101L, 102L, 103L, 104L};
	
	/*
	@Test
	public void TestMapper() {
		
		log.info(mapper);
	}
	
	@Test
	public void TestCreate() {
		IntStream.rangeClosed(1, 10).forEach(i -> {
			
			ReplyVO reply = new ReplyVO();
			
			reply.setBno(bnoArr[i % 5]);
			reply.setReply("댓글 테스트 " + i);
			reply.setReplyer("replyer " + i);
			
			mapper.insert(reply);
		});
	}
	
	@Test
	public void TestRead() {
		
		Long rno = 5L;
		
		ReplyVO reply = mapper.read(rno);
		
		log.info(reply);
	}
	
	@Test
	public void TestDelete() {
		
		Long rno = 1L;
		
		mapper.delete(rno);
	}
	
	@Test
	public void TestUpdate() {
		
		Long rno = 5L;
		
		ReplyVO reply = mapper.read(rno);
		reply.setReply("update reply");
		
		int count = mapper.update(reply);
		
		log.info("update count" + count);
	}*/
	
	@Test
	public void TestList() {
		
		Criteria cri = new Criteria();
		
		List<ReplyVO> replies = mapper.getListWithPaging(cri, bnoArr[0]);
		
		replies.forEach(reply -> log.info(reply));
	}
}
