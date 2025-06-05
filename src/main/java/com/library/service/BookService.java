package com.library.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.library.book.Book;
import com.library.book.BookDAO;
import com.library.book.BookDTO;
import com.library.review.Review;

@Service
public class BookService {
	
	@Autowired
	private BookDAO bookDAO;
	
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private BorrowService borrowService;
	
    // 전체 도서 목록 조회 (페이지네이션 지원)
    public List<BookDTO> getAllBooks(int page, int size) {
        int offset = (page - 1) * size; // 1-based 페이지 번호를 0-based 오프셋으로 변환
        return bookDAO.findAllWithPagination(offset, size).stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    // 도서 세부 정보 조회
    public BookDTO getBookById(Long seqNo) {
        Book book = bookDAO.findById(seqNo);
        if (book == null) {
            throw new RuntimeException("Book not found with seq_no: " + seqNo);
        }
        return convertToDTO(book);
    }

    // Book -> BookDTO 변환
    private BookDTO convertToDTO(Book book) {
        return new BookDTO(
            book.getSeqNo(),
            book.getTitle(),
            book.getAuthor(),
            book.getPublisher(),
            book.getIntroduction(),
            book.getPublicationDate(),
            book.getPortalExists(),
            book.getReviewCount()
        );
    }
    
    // 도서 검색 (페이지네이션 지원)
    public List<BookDTO> searchBooks(String title, int page, int size) {
        int offset = (page - 1) * size; // 1-based 페이지 번호를 0-based 오프셋으로 변환
        return bookDAO.findByTitleWithPagination(title, offset, size).stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }
    
    // 전체 도서 수 조회
    public long getTotalBooks() {
        return bookDAO.countAll();
    }
    
    // 검색된 도서 수 조회
    public long getTotalBooksByTitle(String title) {
        return bookDAO.countByTitle(title);
    }
    
    // 도서 대출
    public void borrowBook(Long seqNo, String memberId) {
        borrowService.saveBorrow(memberId, seqNo);
    }
    
    // 도서의 리뷰 목록 조회
    public List<Review> getReviewsByBookSeqNo(Long bookSeqNo) {
        return reviewService.getReviewsByBookSeqNo(bookSeqNo);
    }
}