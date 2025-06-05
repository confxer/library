package com.library.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.library.review.Review;
import com.library.review.ReviewDAO;

@Service
public class ReviewService {

    @Autowired
    private ReviewDAO reviewDAO;
    
    @Autowired
    private BorrowService borrowService;

    // 리뷰 저장
    public void saveReview(Long bookSeqNo,String userId, String content) {
    	if (!borrowService.hasBorrowed(userId, bookSeqNo)) {
            throw new RuntimeException("You must borrow this book to write a review");
        }
        Review review = new Review();
        review.setBookSeqNo(bookSeqNo);
        review.setUserId(userId);
        review.setContent(content);
        review.setCreatedAt(LocalDateTime.now());
        reviewDAO.save(review);
    }

    // 도서의 리뷰 목록 조회
    public List<Review> getReviewsByBookSeqNo(Long bookSeqNo) {
        return reviewDAO.findByBookSeqNo(bookSeqNo);
    }
    
    public long countReview(Long seqNo) {
    	return reviewDAO.countReview(seqNo);
    }
}