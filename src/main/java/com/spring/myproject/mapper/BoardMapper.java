package com.spring.myproject.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.myproject.domain.BoardVO;
import com.spring.myproject.domain.Criteria;

public interface BoardMapper {

	//@Select("select * from tbl_board where bno > 0")
	public List<BoardVO> getList();
	
	public void insert(BoardVO board);
	
	public void insertSelectKey(BoardVO board);
	
	public BoardVO read(Long bno);
	
	public int delete(Long bno);
	
	public int update(BoardVO board);
	
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	public int getTotalCount(Criteria cri);
	
	public int viewcount(Long bno);

	public void replyCnt(@Param("bno")Long bno, @Param("amount")int amount);
}
