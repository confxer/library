package com.library.controller;

import com.library.member.MemberVO;
import com.library.qna.Qna;
import com.library.qna.Reply;
import com.library.service.QnaService;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/qna")
public class QnaController {

    private final QnaService qnaService;

    public QnaController(QnaService qnaService) {
        this.qnaService = qnaService;
    }

    // ✅ QnA 목록
    @GetMapping("/list")
    public String list(@RequestParam(value = "page", defaultValue = "1") int page,
                       @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
                       @RequestParam(value = "keyword", required = false) String keyword,
                       @RequestParam(value = "category", required = false) String category,
                       @RequestParam(value = "sort", defaultValue = "latest") String sort,
                       Model model) {

        List<Qna> qnaList = qnaService.getQnasBySearch(keyword, category, sort, page, pageSize);
        int totalCount = qnaService.getTotalCountBySearch(keyword, category);
        int totalPages = (int) Math.ceil((double) totalCount / pageSize);

        model.addAttribute("qnaList", qnaList);
        model.addAttribute("currentPage", page);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("keyword", keyword);
        model.addAttribute("category", category);
        model.addAttribute("sort", sort);

        return "qna/list";
    }

    // ✅ QnA 상세 보기
    @GetMapping("/detail/{id}")
    public String view(@PathVariable("id") int id,
                       @RequestParam(value = "password", required = false) String password,
                       HttpSession session,
                       Model model) {

        Qna qna = qnaService.getQnaById(id);
        if (qna == null) {
            model.addAttribute("errorMessage", "존재하지 않는 Q&A 글입니다.");
            return "qna/detail";
        }

        MemberVO member = (MemberVO) session.getAttribute("loggedInMember");
        boolean isWriter = member != null && qna.getWriter().equals(member.getMemberId());
        boolean isAdmin = member != null && "admin".equalsIgnoreCase(member.getRole());

        // ✅ 비공개 글 접근 제한
        if ("N".equals(qna.getOpenYn()) && !(isAdmin || isWriter)) {
            if (password == null || !password.equals(qna.getPassword())) {
                model.addAttribute("errorMessage", "비공개 글입니다. 비밀번호가 올바르지 않습니다.");
                return "qna/detail";
            }
        }

        List<Reply> replies = qnaService.getRepliesByQnaId(id);
        model.addAttribute("qna", qna);
        model.addAttribute("replies", replies);
        return "qna/detail";
    }

    // ✅ 작성 폼
    @GetMapping("/write")
    public String writeForm(Model model) {
        model.addAttribute("qna", new Qna());
        return "qna/write";
    }

    // ✅ 작성 처리
    @PostMapping("/write")
    public String write(@ModelAttribute Qna qna, HttpSession session) {
        MemberVO member = (MemberVO) session.getAttribute("loggedInMember");
        if (member != null) {
            qna.setWriter(member.getMemberId());
        }
        qnaService.createQna(qna);
        return "redirect:/qna/list";
    }

    // ✅ 수정 폼
    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable("id") int id, HttpSession session, Model model) {
        Qna qna = qnaService.getQnaById(id);
        MemberVO member = (MemberVO) session.getAttribute("loggedInMember");

        boolean isAdmin = member != null && "admin".equalsIgnoreCase(member.getRole());
        boolean isWriter = member != null && qna.getWriter().equals(member.getMemberId());

        if (qna == null || !(isWriter || isAdmin)) {
            model.addAttribute("errorMessage", "수정 권한이 없습니다.");
            return "redirect:/qna/detail/" + id;
        }

        model.addAttribute("qna", qna);
        return "qna/edit";
    }

    // ✅ 수정 처리
    @PostMapping("/edit")
    public String update(@ModelAttribute Qna qna, HttpSession session) {
        MemberVO member = (MemberVO) session.getAttribute("loggedInMember");
        if (member != null) {
            qna.setWriter(member.getMemberId());  // 보안: 클라이언트 조작 방지
        }
        qnaService.updateQna(qna);
        return "redirect:/qna/detail/" + qna.getQnaId();
    }

    // ✅ 삭제 처리
    @PostMapping("/delete/{id}")
    public String delete(@PathVariable("id") int id, HttpSession session) {
        Qna qna = qnaService.getQnaById(id);
        MemberVO member = (MemberVO) session.getAttribute("loggedInMember");

        boolean isAdmin = member != null && "admin".equalsIgnoreCase(member.getRole());
        boolean isWriter = member != null && qna.getWriter().equals(member.getMemberId());

        if (qna != null && (isAdmin || isWriter)) {
            qnaService.deleteQna(id);
        }

        return "redirect:/qna/list";
    }

    // ✅ 관리자 답변 처리
    @PostMapping("/answer/{id}")
    public String answer(@PathVariable("id") int id,
                         @RequestParam("answer") String answer,
                         HttpSession session) {
        MemberVO member = (MemberVO) session.getAttribute("loggedInMember");
        boolean isAdmin = member != null && "admin".equalsIgnoreCase(member.getRole());

        if (!isAdmin) {
            return "redirect:/qna/detail/" + id;
        }

        qnaService.updateAnswer(id, answer);
        return "redirect:/qna/detail/" + id;
    }

    // ✅ 댓글 등록
    @PostMapping("/reply/{id}")
    public String createReply(@PathVariable("id") int id,
                              @ModelAttribute Reply reply,
                              HttpSession session) {
        MemberVO member = (MemberVO) session.getAttribute("loggedInMember");
        if (member != null) {
            reply.setWriter(member.getMemberId());
        }
        reply.setQnaId(id);
        qnaService.createReply(reply);
        return "redirect:/qna/detail/" + id;
    }

    // ✅ 댓글 수정
    @PostMapping("/reply/update/{replyId}")
    public String updateReply(@PathVariable("replyId") int replyId,
                              @ModelAttribute("reply") Reply reply,
                              @RequestParam("qnaId") int qnaId) {
        reply.setReplyId(replyId);
        qnaService.updateReply(reply);
        return "redirect:/qna/detail/" + qnaId;
    }

    // ✅ 댓글 삭제
    @PostMapping("/reply/delete/{replyId}")
    public String deleteReply(@PathVariable("replyId") int replyId,
                              @RequestParam("qnaId") int qnaId) {
        qnaService.deleteReply(replyId);
        return "redirect:/qna/detail/" + qnaId;
    }
}
