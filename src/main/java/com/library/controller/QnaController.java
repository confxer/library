package com.library.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.library.qna.Qna;
import com.library.qna.Reply;
import com.library.service.QnaService;

import java.util.List;

@Controller
@RequestMapping("/qna")
public class QnaController {
    private final QnaService qnaService;

    public QnaController(QnaService qnaService) {
        this.qnaService = qnaService;
    }

    // QnA 목록 (페이징, 검색 지원)
    @GetMapping("/list")
    public String list(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int pageSize,
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) String category,
            Model model) {
        List<Qna> qnaList = qnaService.searchQnas(keyword, category, page, pageSize);
        int totalCount = qnaService.getTotalCountBySearch(keyword, category);
        int totalPages = (int) Math.ceil((double) totalCount / pageSize);

        model.addAttribute("qnaList", qnaList);
        model.addAttribute("currentPage", page);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("keyword", keyword);
        model.addAttribute("category", category);

        return "qna/list";
    }

    // QnA 상세 보기 (Reply 포함)
    @GetMapping("/detail/{id}")
    public String view(@PathVariable int id, Model model) {
        Qna qna = qnaService.getQnaById(id);
        List<Reply> replies = qnaService.getRepliesByQnaId(id);

        model.addAttribute("qna", qna);
        model.addAttribute("replies", replies);

        return "qna/detail";
    }
    
    
    // QnA 작성 폼
    @GetMapping("/write")
    public String createForm(Model model) {
        model.addAttribute("qna", new Qna());
        return "qna/write";
    }

    // QnA 작성 처리
    @PostMapping("/write")
    public String create(@ModelAttribute Qna qna) {
        qnaService.createQna(qna);
        return "redirect:/qna/list";
    }

    // QnA 수정 폼
    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable int id, Model model) {
        Qna qna = qnaService.getQnaById(id);
        model.addAttribute("qna", qna);
        return "qna/form";
    }

    // QnA 수정 처리
    @PostMapping("/update/{id}")
    public String update(@PathVariable int id, @ModelAttribute Qna qna) {
        qna.setQnaId(id);
        qnaService.updateQna(qna);
        return "redirect:/qna/list";
    }

    // QnA 삭제
    @PostMapping("/delete/{id}")
    public String delete(@PathVariable int id) {
        qnaService.deleteQna(id);
        return "redirect:/qna/list";
    }

    // QnA 답변 등록
    @PostMapping("/answer/{id}")
    public String answer(@PathVariable int id, @RequestParam String answer) {
        qnaService.updateAnswer(id, answer);
        return "redirect:/qna/detail/" + id;
    }

    // Reply 작성
    @PostMapping("/reply")
    public String createReply(@ModelAttribute Reply reply) {
        qnaService.createReply(reply);
        return "redirect:/qna/detail/" + reply.getQnaId();
    }

    // Reply 수정
    @PostMapping("/reply/update/{replyId}")
    public String updateReply(@PathVariable int replyId, @ModelAttribute Reply reply, @RequestParam int qnaId) {
        reply.setReplyId(replyId);
        qnaService.updateReply(reply);
        return "redirect:/qna/detail/" + qnaId;
    }

    // Reply 삭제
    @PostMapping("/reply/delete/{replyId}")
    public String deleteReply(@PathVariable int replyId, @RequestParam int qnaId) {
        qnaService.deleteReply(replyId);
        return "redirect:/qna/detail/" + qnaId;
    }
}