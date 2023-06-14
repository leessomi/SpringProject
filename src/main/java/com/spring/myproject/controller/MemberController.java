package com.spring.myproject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.myproject.domain.MemberVO;
import com.spring.myproject.service.MemberService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping(value="/member")
public class MemberController {

	@Setter(onMethod_ = @Autowired)
	private MemberService service;
	
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		log.info("access Denied: " + auth);
		
		model.addAttribute("msg", "Access Denied");
	}
	
	//회원가입
	@PreAuthorize("permitAll")
	@GetMapping("/join")
	public void join() {
		
		log.info("회원가입 페이지");
	}
	
	@PreAuthorize("permitAll")
	@PostMapping("/join")
	public String join(MemberVO member) {

		int result = service.memberJoin(member);
		
		if(result > 0) {
			return "member/login";
		}
		else {
			return "redirect:join";
		}
	}
	
	//아이디 중복확인
	@GetMapping("/memberIdCk")
	@ResponseBody
	public String memberIdCk(String memberId) {
		
		int result = service.idCheck(memberId);
		
		log.info("result:" + result);
		
		if(result != 0) {
			return "fail"; //중복 아이디 존재
		}else {
			return "success"; //사용가능
		}
		
	}
	
	//로그인
	@GetMapping("/login")
	public void login(String error, String logout, Model model) {
		
		log.info("error: " + error);

		log.info("logout: " + logout);

		if (error != null) {
			model.addAttribute("error", "Login Error -- Check Your Account");
		}

		if (logout != null) {
			model.addAttribute("logout", "Logout!!");
		}

	}
	
	/*
	 * @PostMapping("/login") public String login(HttpServletRequest request,
	 * MemberVO member, RedirectAttributes rttr) {
	 * 
	 * HttpSession session = request.getSession();
	 * 
	 * MemberVO login = service.memberLogin(member);
	 * 
	 * if(login == null) { int result = 0; rttr.addFlashAttribute("result", result);
	 * return "redirect:/member/login"; }
	 * 
	 * session.setAttribute("member", login);
	 * 
	 * return "redirect:/";
	 * 
	 * }
	 */
	 
	//로그아웃
	@GetMapping("/logout")
	public void logout() {
		
		log.info("로그아웃");
	}
	
	//마이페이지
	@GetMapping({"/myPage", "/pageModify"})
	public void myPage(@RequestParam("memberId") String memberId, Model model) {
		
		log.info("/myPage or /pageModify");
		
		model.addAttribute("member", service.myPage(memberId));
		
	}
	
	//마이페이지 수정	
	@PostMapping("/pageModify")
	@PreAuthorize("principal.username == #member.memberId")
	public String pageModify(MemberVO member, RedirectAttributes rttr) {
		
		service.memberUpdate(member);
		rttr.addFlashAttribute("result", "success");
				
		return "redirect:myPage?memberId=" + member.getMemberId();
	}
	
}
