package com.library.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.library.board.BoardDAO;
import com.library.board.BoardDTO;

/**
 * 게시판 관련 비즈니스 로직을 처리하는 서비스 계층
 * DAO와 컨트롤러 사이에서 데이터 처리 및 유효성 검사를 수행
 */
@Service
public class BoardService {
    private final BoardDAO boardDAO;
    
    /**
     * 생성자 주입을 통해 BoardDAO를 초기화
     * @param boardDAO 게시판 DAO 객체
     */
    public BoardService(BoardDAO boardDAO) {
        this.boardDAO = boardDAO;
    }
    
    /**
     * 모든 게시글을 페이지 단위로 조회
     * @param page 페이지 번호 (1부터 시작)
     * @param pageSize 한 페이지에 표시할 게시글 수
     * @return 게시글 목록
     */
    public List<BoardDTO> getAllPosts(int page, int pageSize) {
        return boardDAO.getAllPosts(page, pageSize);
    }
    
    /**
     * 전체 게시글 수를 조회
     * @return 게시글 총 개수
     */
    public int getTotalPostCount() {
        return boardDAO.getTotalPostCount();
    }
    
    /**
     * 특정 ID의 게시글을 조회
     * @param id 게시글 ID
     * @return BoardDTO 객체 또는 null
     */
    public BoardDTO getPostById(int id) {
        return boardDAO.getPostById(id);
    }
    
    /**
     * 새 게시글을 추가
     * @param post 게시글 데이터
     * @throws IllegalArgumentException 제목이나 내용이 비어 있는 경우
     */
    public void createPost(BoardDTO post) {
        if (post.getTitle() == null || post.getTitle().trim().isEmpty() ||
            post.getContent() == null || post.getContent().trim().isEmpty()) {
            throw new IllegalArgumentException("제목과 내용을 모두 입력해야 합니다.");
        }
        boardDAO.insertPost(post);
    }
    
    /**
     * 기존 게시글을 수정
     * @param post 수정할 게시글 데이터
     * @throws IllegalArgumentException 제목이나 내용이 비어 있는 경우
     * @throws IllegalStateException 게시글이 존재하지 않는 경우
     */
    public void updatePost(BoardDTO post) {
        if (post.getTitle() == null || post.getTitle().trim().isEmpty() ||
            post.getContent() == null || post.getContent().trim().isEmpty()) {
            throw new IllegalArgumentException("제목과 내용을 모두 입력해야 합니다.");
        }
        if (boardDAO.getPostById(post.getId()) == null) {
            throw new IllegalStateException("수정하려는 게시글이 존재하지 않습니다.");
        }
        boardDAO.updatePost(post);
    }
    
    /**
     * 게시글을 삭제
     * @param id 삭제할 게시글 ID
     * @throws IllegalStateException 게시글이 존재하지 않는 경우
     */
    public void deletePost(int id) {
        if (boardDAO.getPostById(id) == null) {
            throw new IllegalStateException("삭제하려는 게시글이 존재하지 않습니다.");
        }
        boardDAO.deletePost(id);
    }
}