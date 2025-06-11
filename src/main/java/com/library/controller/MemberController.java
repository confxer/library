package com.library.controller;


import jakarta.servlet.http.HttpSession; // Jakarta EE의 HttpSession 사용

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute; // @ModelAttribute 임포트
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.library.book.Book;
import com.library.borrow.Borrow;
import com.library.member.MemberVO;
import com.library.service.BorrowService;
import com.library.service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {

    private final MemberService memberService;
    
    @Autowired
    private BorrowService borrowService;

    @Autowired
    public MemberController(MemberService memberService) {
        this.memberService = memberService;
    }

    @GetMapping("/login")
    public String showLoginForm() {
        return "member/login";
    }

    @PostMapping("/login")
    public String processLogin( 
    		@RequestParam(value = "memberId") String memberId,
            @RequestParam(value = "password") String password,
            HttpSession session,
            Model model,
            RedirectAttributes redirectAttributes) {
        try {
        	System.out.println("ee");
            MemberVO member = memberService.login(memberId, password);
            if (member != null) {
                // 로그인 성공 시 세션에 MemberVO 객체를 통째로 저장
                session.setAttribute("loggedInMember", member);
                redirectAttributes.addFlashAttribute("message", member.getName() + "님 환영합니다!");	
                return "redirect:/" ;
            } else {
                model.addAttribute("message", "아이디 또는 비밀번호가 일치하지 않습니다.");
                return "member/login";
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("message", "로그인 중 오류가 발생했습니다. 다시 시도해주세요.");
            return "member/login";
        }
    }

    @GetMapping("/logout")
    public String logout(
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        session.invalidate();
        redirectAttributes.addFlashAttribute("message", "로그아웃 되었습니다.");
        return "redirect:/" ;
    }

    @GetMapping("/mypage")
    public String showMyPage(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        MemberVO loggedInMember = (MemberVO) session.getAttribute("loggedInMember");

        if (loggedInMember == null) {
            redirectAttributes.addFlashAttribute("message", "로그인이 필요한 서비스입니다.");
            return "redirect:/member/login";
        }
        try {
            // 현재 로그인된 회원	의 전체 정보를 다시 불러옵니다.
            MemberVO memberInfo = memberService.getMemberById(loggedInMember.getMemberId());
            List<Book> borrows = borrowService.showBorrows(loggedInMember.getMemberId());
            List<Borrow> borrowed = borrowService.showBorrowed(loggedInMember.getMemberId());
            if(loggedInMember.getRole().equals("ADMIN") ) {
            	System.out.println("영자");
            	List<MemberVO> members = memberService.showMembers();
            	List<Borrow> memBor = borrowService.adminBorrow();
            	model.addAttribute("members",members);
            	model.addAttribute("memBor",memBor);
            }
            if (memberInfo != null) {
                model.addAttribute("member", memberInfo);
                model.addAttribute("borrows", borrows);
                model.addAttribute("borrowed", borrowed);
                return "member/mypage";
            } else {
                session.invalidate(); // 정보가 없다면 세션 무효화
                redirectAttributes.addFlashAttribute("message", "회원 정보를 찾을 수 없습니다. 다시 로그인 해주세요.");
                return "redirect:/member/login";
            }
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("message", "회원 정보를 불러오는 중 오류가 발생했습니다.");
            return "redirect:/";
        }
    }

    // --- 회원 정보 수정 기능 추가 ---

    // 1. 회원 정보 수정 폼을 보여주는 GET 메서드
    @GetMapping("/edit")
    public String showEditForm(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        MemberVO loggedInMember = (MemberVO) session.getAttribute("loggedInMember");

        if (loggedInMember == null) {
            redirectAttributes.addFlashAttribute("message", "로그인이 필요한 서비스입니다.");
            return "redirect:/member/login";
        }

        try {
            // 수정 페이지에 보여줄 회원 정보를 불러옵니다.
            MemberVO memberInfo = memberService.getMemberById(loggedInMember.getMemberId());
            if (memberInfo != null) {
                model.addAttribute("member", memberInfo); // 불러온 회원 정보를 Model에 담아 JSP로 전달
                return "member/edit"; // views/member/edit.jsp 반환
            } else {
                session.invalidate();
                redirectAttributes.addFlashAttribute("message", "회원 정보를 찾을 수 없습니다. 다시 로그인 해주세요.");
                return "redirect:/member/login";
            }
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("message", "회원 정보를 불러오는 중 오류가 발생했습니다.");
            return "redirect:/member/mypage"; // 에러 시 마이페이지로 리다이렉트
        }
    }

    // 2. 회원 정보 수정을 처리하는 POST 메서드
    @PostMapping("/update")
    public String updateMemberInfo(@ModelAttribute MemberVO member, HttpSession session,
                                   RedirectAttributes redirectAttributes) {
        // @ModelAttribute는 폼에서 전송된 데이터를 MemberVO 객체에 자동으로 바인딩합니다.
        // 이때, memberId 필드 등은 폼에 숨겨져(hidden) 있거나 읽기 전용(readonly)으로 전달되어야 합니다.

        MemberVO loggedInMember = (MemberVO) session.getAttribute("loggedInMember");

        // *** 중요한 변경 사항: 로그인된 사용자 ID와 폼에서 넘어온 ID 비교
        if (loggedInMember == null || member.getMemberId() == null || !loggedInMember.getMemberId().equals(member.getMemberId())) {
            // System.out.println("보안 검사 실패: 세션 ID: " + (loggedInMember != null ? loggedInMember.getMemberId() : "null") + ", 폼 ID: " + member.getMemberId()); // 디버그용 (필요 없으면 제거하세요)
            redirectAttributes.addFlashAttribute("message", "유효하지 않은 접근입니다.");
            return "redirect:/member/login";
        }

        try {
            // *** 추가된 로직: 현재 로그인된 회원의 status와 role 값을 가져와 member 객체에 설정
            // 이렇게 하면 폼에서 status/role 값이 넘어오지 않아도 기존 값을 유지합니다.
            MemberVO currentMemberData = memberService.getMemberById(loggedInMember.getMemberId());
            if (currentMemberData != null) {
                member.setStatus(currentMemberData.getStatus());
                member.setRole(currentMemberData.getRole());
            } else {
                // 이 경우는 거의 없겠지만, 혹시나 currentMemberData를 불러오지 못했다면
                // 심각한 오류이므로 예외를 던지거나 로그인 페이지로 돌려보낼 수 있습니다.
                redirectAttributes.addFlashAttribute("message", "회원 정보를 불러올 수 없습니다. 다시 로그인 해주세요.");
                return "redirect:/member/login";
            }

            // 비밀번호가 입력되었다면 암호화 처리 (Service 계층에서 담당)
            boolean updateSuccess = memberService.updateMember(member);

            if (updateSuccess) {
                // 세션의 회원 정보도 업데이트된 내용으로 갱신 (가장 중요!)
                // 데이터베이스에서 최신 정보를 다시 불러와 세션에 반영합니다.
                session.setAttribute("loggedInMember", memberService.getMemberById(member.getMemberId()));
                redirectAttributes.addFlashAttribute("message", "회원 정보가 성공적으로 수정되었습니다.");
                return "redirect:/member/mypage"; // 수정 성공 후 마이페이지로 이동
            } else {
                redirectAttributes.addFlashAttribute("message", "회원 정보 수정에 실패했습니다.");
                return "redirect:/member/edit"; // 실패 시 수정 폼으로 다시 이동
            }
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("message", "회원 정보 수정 중 오류가 발생했습니다.");
            return "redirect:/member/edit"; // 오류 시 수정 폼으로 다시 이동
        }
    }
    
    @PostMapping("/admin")
    public String setRole(
    		@RequestParam(value = "role") String role,
    		@RequestParam(value = "id") String id,
    		HttpSession session
    		) {
    	MemberVO member =(MemberVO) session.getAttribute("loggedInMember");
    	memberService.setRole(role, id);
    	if(member.getMemberId().equals(id)) {
    		System.out.println("로그아웃");
    		return "redirect:/member/logout";
    	}
    	System.out.println("그냥ㄱ");
    	return "redirect:/member/mypage";
    }
    
}