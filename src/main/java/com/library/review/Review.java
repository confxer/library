package com.library.review;

import java.time.LocalDateTime;

public class Review {
	private Long reviewId;
	private Long bookSeqNo;
	private String userId;
	private String content;
	private LocalDateTime createdAt;

	// Getters and Setters
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public Long getReviewId() {
		return reviewId;
	}

	public void setReviewId(Long reviewId) {
		this.reviewId = reviewId;
	}

	public Long getBookSeqNo() {
		return bookSeqNo;
	}

	public void setBookSeqNo(Long bookSeqNo) {
		this.bookSeqNo = bookSeqNo;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}
}