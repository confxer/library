package com.library.book;

import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class BookDAO {
	
	private JdbcTemplate jdbcTemplate;

	public BookDAO(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public Book findById(Long seqNo) {
	    String sql = "SELECT * FROM book WHERE seq_no = ?";
	    try {
	        return jdbcTemplate.queryForObject(sql, (rs, rowNum) -> {
	            Book book = new Book();
	            book.setSeqNo(rs.getLong("seq_no"));
	            book.setTitle(rs.getString("title_nm"));
	            book.setAuthor(rs.getString("authr_nm"));
	            book.setPublisher(rs.getString("publisher_nm"));
	            book.setIntroduction(rs.getString("book_intrcn_cn"));
	            book.setPublicationDate(rs.getString("two_pblicte_de"));
	            book.setPortalExists(rs.getString("portal_site_book_exst_at"));
	            return book;
	        }, seqNo);
	    } catch (Exception e) {
	        return null; 
	    }
	}
    
    // 페이지네이션으로 전체 도서 목록 조회
    public List<Book> findAllWithPagination(int offset, int size) {
        String sql = "SELECT * FROM book ORDER BY seq_no LIMIT ? OFFSET ?";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            Book book = new Book();
            book.setSeqNo(rs.getLong("seq_no"));
            book.setTitle(rs.getString("title_nm"));
            book.setAuthor(rs.getString("authr_nm"));
            book.setPublisher(rs.getString("publisher_nm"));
            book.setIntroduction(rs.getString("book_intrcn_cn"));
            book.setPublicationDate(rs.getString("two_pblicte_de"));
            book.setPortalExists(rs.getString("portal_site_book_exst_at"));
            return book;
        }, size, offset);
    }
    
    // 제목으로 도서 검색
    public List<Book> findByTitle(String title) {
        String sql = "SELECT * FROM book WHERE title_nm LIKE ?";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            Book book = new Book();
            book.setSeqNo(rs.getLong("seq_no"));
            book.setTitle(rs.getString("title_nm"));
            book.setAuthor(rs.getString("authr_nm"));
            book.setPublisher(rs.getString("publisher_nm"));
            book.setIntroduction(rs.getString("book_intrcn_cn"));
            book.setPublicationDate(rs.getString("two_pblicte_de"));
            book.setPortalExists(rs.getString("portal_site_book_exst_at"));
            return book;
        }, "%" + title + "%");
    }
    
    // 페이지네이션으로 제목 검색
    public List<Book> findByTitleWithPagination(String title, int offset, int size) {
        String sql = "SELECT * FROM book WHERE title_nm LIKE ? ORDER BY seq_no LIMIT ? OFFSET ?";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            Book book = new Book();
            book.setSeqNo(rs.getLong("seq_no"));
            book.setTitle(rs.getString("title_nm"));
            book.setAuthor(rs.getString("authr_nm"));
            book.setPublisher(rs.getString("publisher_nm"));
            book.setIntroduction(rs.getString("book_intrcn_cn"));
            book.setPublicationDate(rs.getString("two_pblicte_de"));
            book.setPortalExists(rs.getString("portal_site_book_exst_at"));
            return book;
        }, "%" + title + "%", size, offset);
    }
    
    // 전체 도서 수 조회
    public long countAll() {
        String sql = "SELECT COUNT(*) FROM book";
        return jdbcTemplate.queryForObject(sql, Long.class);
    }
    
    // 제목으로 검색된 도서 수 조회
    public long countByTitle(String title) {
        String sql = "SELECT COUNT(*) FROM book WHERE title_nm LIKE ?";
        return jdbcTemplate.queryForObject(sql, Long.class, "%" + title + "%");
    }
    
 // 도서 대출 상태 업데이트
    public void updateBorrowStatus(Long seqNo, String status) {
        String sql = "UPDATE book SET portal_site_book_exst_at = ? WHERE seq_no = ?";
        jdbcTemplate.update(sql, status, seqNo);
    }

}