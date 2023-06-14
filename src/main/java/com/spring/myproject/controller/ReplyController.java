package com.spring.myproject.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.spring.myproject.domain.Criteria;
import com.spring.myproject.domain.ReplyPageDTO;
import com.spring.myproject.domain.ReplyVO;
import com.spring.myproject.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RestController
@AllArgsConstructor
@RequestMapping("/replies")
public class ReplyController {

	private ReplyService service;
	
	//댓글 등록
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value="/new", consumes="application/json", produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ReplyVO reply) {
		
		log.info("ReplyVO: " + reply);

		int insertCount = service.register(reply);
		
		return insertCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//댓글 목록
	@GetMapping(value="/pages/{bno}/{page}", produces= {MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<ReplyPageDTO> getList(@PathVariable("page")int page, @PathVariable("bno")Long bno) {
		
		Criteria cri = new Criteria(page, 10);
		
		log.info(cri);
		
		return new ResponseEntity<>(service.getListPage(cri, bno), HttpStatus.OK);
	}
	
	//댓글 조회/삭제
	@GetMapping(value="/{rno}", produces= {MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<ReplyVO> get(@PathVariable("rno")Long rno) {
		
		log.info("get:" + rno);
		
		return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
	}
	
	@PreAuthorize("isAuthenticated()")
	@DeleteMapping(value="/{rno}", produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("rno")Long rno) {
		
		log.info("remove:" + rno);
		
		return service.remove(rno) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//댓글 수정
	@PreAuthorize("principal.username == #reply.replyer")
	@RequestMapping(method={RequestMethod.PUT, RequestMethod.PATCH}, value="/{rno}", consumes="application/json", produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@RequestBody ReplyVO reply, @PathVariable("rno")Long rno) {
		
		reply.setBno(rno);
		
		log.info("rno" + rno);
		log.info("modify" + reply);
		
		return service.modify(reply) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
}
