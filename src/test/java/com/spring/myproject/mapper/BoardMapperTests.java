package com.spring.myproject.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.spring.myproject.domain.BoardVO;
import com.spring.myproject.domain.Criteria;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {

	@Setter(onMethod_= @Autowired)
	private BoardMapper mapper;
	
	/*
	@Test
	public void testGetList() {
		mapper.getList().forEach(board -> log.info(board));
	}
	
	@Test
	public void TestInsert(){
		
		BoardVO board = new BoardVO();
	    board.setTitle("새로 작성하는 글");
	    board.setContent("새로 작성하는 내용");
	    board.setWriter("newbie");
	    
	    mapper.insert(board);
	    
	    log.info(board);
	}
	
	@Test
	public void TestInsertSelectKey() {
		
		BoardVO board = new BoardVO();
	    board.setTitle("새로 작성하는 글");
	    board.setContent("새로 작성하는 내용");
	    board.setWriter("newbie");
	    
	    mapper.insertSelectKey(board);
	    
	    log.info(board);
	}
	
	@Test
	public void TestRead() {
		
		BoardVO board = mapper.read(3L);
		
		log.info(board);
	}
	
	@Test
	public void TestDelete() {
		
		log.info("DELETE COUNT :" + mapper.delete(45L));
	}
	
	@Test
	public void TestUpdate() {
		
		BoardVO board = new BoardVO();
		board.setBno(59L);
		board.setTitle("수정된 제목");
		board.setContent("수정된 내용");
		board.setWriter("user00");
		
		int count = mapper.update(board);
		log.info("UPDATE COUNT :" + count);
	}
	
	@Test
	public void TestPaging() {
		
		Criteria cri = new Criteria();
		
		List<BoardVO> list = mapper.getListWithPaging(cri);
		
		list.forEach(board -> log.info(board));
	}*/
	
	@Test
	public void TestSearch() {
		
		Criteria cri = new Criteria();
		cri.setKeyword("새로");
		cri.setType("TC");
		
		List<BoardVO> list = mapper.getListWithPaging(cri);
		
		list.forEach(board -> log.info(board));
	}

}
