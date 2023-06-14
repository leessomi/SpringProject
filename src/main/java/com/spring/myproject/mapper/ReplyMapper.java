package com.spring.myproject.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.myproject.domain.Criteria;
import com.spring.myproject.domain.ReplyVO;

public interface ReplyMapper {

	public int insert(ReplyVO reply);
	
	public ReplyVO read(Long bno);
	
	public int delete(Long bno);
	
	public int deleteAll(Long bno);
	
	public int update(ReplyVO reply);
	
	public List<ReplyVO> getListWithPaging(@Param("cri")Criteria cri, @Param("bno")Long bno);
	
	public int getCountByBno(Long bno);
}
