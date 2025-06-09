package com.library.borrow;

import java.time.LocalDateTime;

public class Borrow {
    private Long borrowId;
    private String userId;
    private Long bookSeqNo;
    private LocalDateTime borrowDate;
    private String status;

    // Getters and Setters
    public Long getBorrowId() { return borrowId; }
    public void setBorrowId(Long borrowId) { this.borrowId = borrowId; }
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }
    public Long getBookSeqNo() { return bookSeqNo; }
    public void setBookSeqNo(Long bookSeqNo) { this.bookSeqNo = bookSeqNo; }
    public LocalDateTime getBorrowDate() { return borrowDate; }
    public void setBorrowDate(LocalDateTime borrowDate) { this.borrowDate = borrowDate; }
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
}
