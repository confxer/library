package com.library.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.library.board.BoardDTO;
import com.library.service.BoardService;

/**
 * 게시판 관련 요청을 처리하는 컨트롤러
 * BoardService를 통해 비즈니스 로직을 호출하여 게시글을 관리
 */
@Controller
@RequestMapping("/board")
public class BoardController {
    private final BoardService boardService;
    
    private static final int PAGE_SIZE = 30; // 한 페이지에 표시할 게시글 수
    
    /**
     * 생성자 주입을 통해 BoardService를 초기화
     * @param boardService 게시판 서비스 객체
     */
    public BoardController(BoardService boardService) {
        this.boardService = boardService;
    }
    
    /**
     * 게시글 목록을 표시
     * @param page 표시할 페이지 번호 (기본값: 1)
     * @param model 뷰에 전달할 데이터
     * @return 게시글 목록 뷰 이름
     */
    @GetMapping("/list")
    public String listPosts(
            @RequestParam(value = "page",defaultValue = "1") int page,
            Model model) {
        List<BoardDTO> posts = boardService.getAllPosts(page, PAGE_SIZE);
        int totalPosts = boardService.getTotalPostCount();
        int totalPages = (int) Math.ceil((double) totalPosts / PAGE_SIZE);
        
        model.addAttribute("posts", posts);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        return "board/boardList";
    }
    
    /**
     * 특정 게시글의 상세 정보를 표시
     * @param id 게시글 ID
     * @param model 뷰에 전달할 데이터
     * @param redirectAttributes 리다이렉트 시 메시지 전달
     * @return 게시글 상세 뷰 이름
     */
    @GetMapping("/detail/{id}")
    public String viewPost(
            @PathVariable(value ="id") int id,
            Model model,
            RedirectAttributes redirectAttributes) {
        BoardDTO post = boardService.getPostById(id);
        if (post == null) {
            redirectAttributes.addFlashAttribute("message", "게시글을 찾을 수 없습니다.");
            return "redirect:/board";
        }
        model.addAttribute("post", post);
        return "board/boardDetail";
    }
    
    /**
     * 게시글 작성 폼을 표시
     * @param model 뷰에 전달할 데이터
     * @return 게시글 작성 뷰 이름
     */
    @GetMapping("/write")
    public String showWriteForm(Model model) {
        model.addAttribute("post", new BoardDTO());
        return "board/boardWrite";
    }
    
    /**
     * 새 게시글을 생성
     * @param post 게시글 데이터
     * @param redirectAttributes 리다이렉트 시 메시지 전달
     * @return 리다이렉트 URL
     */
    @PostMapping("/write")
    public String createPost(
            @ModelAttribute BoardDTO post,
            RedirectAttributes redirectAttributes) {
        try {
            boardService.createPost(post);
            redirectAttributes.addFlashAttribute("message", "게시글이 등록되었습니다.");
            return "redirect:/board/list";
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("message", e.getMessage());
            return "redirect:/board/write";
        }
    }
    
    /**
     * 게시글 수정 폼을 표시
     * @param id 게시글 ID
     * @param model 뷰에 전달할 데이터
     * @param redirectAttributes 리다이렉트 시 메시지 전달
     * @return 게시글 수정 뷰 이름
     */
    @GetMapping("/edit/{id}")
    public String showEditForm(
            @PathVariable(value = "id") int id,
            Model model,
            RedirectAttributes redirectAttributes) {
        BoardDTO post = boardService.getPostById(id);
        if (post == null) {
            redirectAttributes.addFlashAttribute("message", "게시글을 찾을 수 없습니다.");
            return "redirect:/board/list";
        }
        model.addAttribute("post", post);
        return "board/boardEdit";
    }
    
    /**
     * 게시글을 수정
     * @param post 수정된 게시글 데이터
     * @param redirectAttributes 리다이렉트 시 메시지 전달
     * @return 리다이렉트 URL
     */
    @PostMapping("/edit/{id}")
    public String updatePost(
    		@RequestParam(value = "id") int id,
            @ModelAttribute BoardDTO post,
            RedirectAttributes redirectAttributes) {
        try {
            boardService.updatePost(post);
            redirectAttributes.addFlashAttribute("message", "게시글이 수정되었습니다.");
            return "redirect:/board/list";
        } catch (IllegalArgumentException | IllegalStateException e) {
            redirectAttributes.addFlashAttribute("message", e.getMessage());
            return "redirect:/board/edit?id=" + post.getId();
        }
    }
    
    /**
     * 게시글을 삭제
     * @param id 삭제할 게시글 ID
     * @param redirectAttributes 리다이렉트 시 메시지 전달
     * @return 리다이렉트 URL
     */
    @GetMapping("/delete/{id}")
    public String deletePost(
            @PathVariable(value = "id") int id,
            RedirectAttributes redirectAttributes) {
        try {
            boardService.deletePost(id);
            redirectAttributes.addFlashAttribute("message", "게시글이 삭제되었습니다.");
            return "redirect:/board/list";
        } catch (IllegalStateException e) {
            redirectAttributes.addFlashAttribute("message", e.getMessage());
            return "redirect:/board/list";
        }
    }
}