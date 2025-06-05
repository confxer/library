package com.library.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping; // import 확인
import org.springframework.web.bind.annotation.PostMapping; // import 확인
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.library.member.MemberVO;
import com.library.service.MemberService;

@Controller
@RequestMapping("/member") // 모든 메서드에 대해 기본 경로로 /member를 사용
public class RegistController { // 주의: MemberController가 아니라 RegistController입니다.

    private final MemberService memberService; // MemberService 주입

    // 생성자 주입 방식으로 의존성을 주입합니다. (권장)
    @Autowired
    public RegistController(MemberService memberService) {
        this.memberService = memberService;
    }

    /**
     * GET 요청: 회원가입 폼 페이지를 보여줍니다.
     * URL: /member/register (GET)
     * View: register.jsp
     */
    @GetMapping("/register") // <-- 이 어노테이션을 추가하거나 주석을 해제하세요!
    public String showRegisterForm() {
        // Spring MVC 설정에 따라 prefix/suffix가 붙어 /WEB-INF/views/register.jsp를 찾습니다.
        return "register";
    }

    /**
     * POST 요청: 회원가입 처리 로직을 수행합니다.
     * URL: /member/register (POST)
     * Form Data: memberId, password, name, email, phoneNumber, address, passwordConfirm
     */
    @PostMapping("/register") // <-- 이 어노테이션을 주석 해제하세요!
    public String registerMember(MemberVO memberVO, String passwordConfirm,
                                 RedirectAttributes redirectAttributes, Model model) {
        // 1. 서버 측 비밀번호 확인
        if (!memberVO.getPassword().equals(passwordConfirm)) {
            model.addAttribute("message", "비밀번호가 일치하지 않습니다.");
            return "register"; // 비밀번호 불일치 시 다시 회원가입 폼으로
        }

        try {
            // 2. 아이디 중복 확인
            if (memberService.isMemberIdExists(memberVO.getMemberId())) {
                model.addAttribute("message", "이미 존재하는 아이디입니다.");
                return "register"; // 아이디 중복 시 다시 회원가입 폼으로
            }

            // 3. 서비스 계층을 통해 회원가입 처리 (비밀번호 암호화 포함)
            memberService.registerMember(memberVO);

            // 회원가입 성공 시 로그인 페이지로 리다이렉트
            // RedirectAttributes는 리다이렉트 후 한 번만 사용할 데이터를 전달할 때 유용합니다.
            redirectAttributes.addFlashAttribute("message", "회원가입이 완료되었습니다. 로그인 해주세요!");
            return "redirect:/member/login"; // 로그인 페이지 URL
        } catch (Exception e) {
            // 예외 발생 시 에러 메시지 처리 및 로그 기록
            e.printStackTrace(); // 실제 운영 환경에서는 로깅 프레임워크(Logback/Log4j) 사용 권장
            model.addAttribute("message", "회원가입 중 오류가 발생했습니다. 다시 시도해주세요.");
            return "register"; // 오류 발생 시 다시 회원가입 폼으로
        }
    }
}