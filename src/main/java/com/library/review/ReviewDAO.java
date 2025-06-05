package com.library.review;

import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class ReviewDAO {
    
    private JdbcTemplate jdbcTemplate;

    public ReviewDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    // 리뷰 추가
    public void save(Review review) {
        String sql = "INSERT INTO review (book_seq_no, user_id, content, created_at) VALUES (?, ?, ?, ?)";
        jdbcTemplate.update(sql, review.getBookSeqNo(), review.getUserId(), review.getContent(), review.getCreatedAt());
    }

    // 도서의 리뷰 목록 조회
    public List<Review> findByBookSeqNo(Long bookSeqNo) {
        String sql = "SELECT * FROM review WHERE book_seq_no = ? ORDER BY created_at DESC";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            Review review = new Review();
            review.setUserId(rs.getString("user_id"));
            review.setReviewId(rs.getLong("review_id"));
            review.setBookSeqNo(rs.getLong("book_seq_no"));
            review.setContent(rs.getString("content"));
            review.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
            return review;
        }, bookSeqNo);
    }
    
    public long countReview(Long seq_no) {
    	String sql = "SELECT COUNT(*) FROM review WHERE book_seq_no = ?";
    	return jdbcTemplate.queryForObject(sql, Long.class, seq_no);
    }
}