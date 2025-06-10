package com.library.service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.library.book.Book;
import com.library.book.BookDAO;
import com.library.borrow.Borrow;
import com.library.borrow.BorrowDAO;
import com.library.member.MemberDAO;

@Service
public class BorrowService {

    @Autowired
    private BorrowDAO borrowDAO;

    @Autowired
    private MemberDAO memberDAO;
    
    @Autowired
    private BookDAO bookDAO;
    
    // 대출 정보 저장
    public void saveBorrow(String userId, Long bookSeqNo) {
        try {
			if (memberDAO.getMemberById(userId) == null) {
			    throw new RuntimeException("Invalid user ID: " + userId);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
        Borrow borrow = new Borrow();
        borrow.setUserId(userId);
        borrow.setBookSeqNo(bookSeqNo);
        borrow.setBorrowDate(LocalDateTime.now());
        borrowDAO.save(borrow);
    }

    // 대출 여부 확인
    public boolean hasBorrowed(String userId, Long bookSeqNo) {
        return borrowDAO.existsByUserIdAndBookSeqNo(userId, bookSeqNo);
    }
    
    public List<Book> showBorrows(String userId){
    	List<Borrow> borrows = borrowDAO.showList(userId);
    	List<Book> books = new ArrayList<>();
    	for(Borrow borrow: borrows) {
    		Book book = bookDAO.findById(borrow.getBookSeqNo());
    		books.add(book);
    	}
    	return books;
    }
    
    public List<Borrow> showBorrowed(String userId){
    	return borrowDAO.showList(userId);
    }
    
   public void returnBook(Long seqNo, Long borrowId) {
	   borrowDAO.updateReturn(seqNo, borrowId);
   }
   
   public List<Borrow> adminBorrow(){
	   return borrowDAO.adminManage();
   }
}