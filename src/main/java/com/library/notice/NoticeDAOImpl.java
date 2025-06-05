package com.library.notice;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;


@Repository
public class NoticeDAOImpl implements NoticeDAO {

	private JdbcTemplate jdbcTemplate;

	public NoticeDAOImpl(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}
   private Notice mapRowToNotice(ResultSet rs, int rowNum) throws SQLException {
        Notice post = new Notice();
        post.setNum(rs.getLong("num"));
        post.setTitle(rs.getString("title"));
        post.setContent(rs.getString("content"));
        post.setRegDate(rs.getString("reg_date"));
        post.setViewCount(rs.getInt("view_count"));
        return post;
    }
   

   /**
    * 모든 공지사항을 페이지 단위로 조회
    * @param page 페이지 번호 (1부터 시작)
    * @param pageSize 한 페이지에 표시할 공지사항 수
    * @return 공지사항 목록
    */
   @Override
   public List<Notice> findAll(int page, int pageSize) {
       int offset = (page - 1) * pageSize;
       String sql = "SELECT * FROM notice ORDER BY num DESC LIMIT ? OFFSET ?";
       try {
           return jdbcTemplate.query(sql, this::mapRowToNotice, pageSize, offset);
       } catch (Exception e) {
           e.printStackTrace();
           return List.of();
       }
   }

   /**+
    * 전체 공지사항 수를 조회
    * @return 공지사항 총 개수
    */
   @Override
   public int getTotalNoticeCount() {
       String sql = "SELECT COUNT(*) FROM notice";
       try {
           return jdbcTemplate.queryForObject(sql, Integer.class);
       } catch (Exception e) {
           e.printStackTrace();
           return 0;
       }
   }

   /**
    * 특정 번호의 공지사항을 조회하고 조회수를 증가
    * @param num 공지사항 번호
    * @return Notice 객체 또는 null
    */
   @Override
   public Notice findByNum(Long num) {
       String updateSql = "UPDATE notice SET view_count = view_count + 1 WHERE num = ?";
       String selectSql = "SELECT * FROM notice WHERE num = ?";
       try {
           jdbcTemplate.update(updateSql, num);
           System.out.println(3);
           return jdbcTemplate.queryForObject(selectSql, this::mapRowToNotice, num);
       } catch (Exception e) {
    	   System.out.println(4);
           e.printStackTrace();
           return null;
       }
   }
   
   /**
    * 새 공지사항을 추가
    * @param notice 공지사항 데이터
    */
   @Override
   public void save(Notice notice) {
       String sql = "INSERT INTO notice (title, content, reg_date) VALUES (?, ?, NOW())";
       try {
           jdbcTemplate.update(sql, notice.getTitle(), notice.getContent());
       } catch (Exception e) {
           e.printStackTrace();
       }
   }

   /**
    * 기존 공지사항을 수정
    * @param notice 수정할 공지사항 데이터
    */
   @Override
   public void update(Notice notice) {
       String sql = "UPDATE notice SET title = ?, content = ? WHERE num = ?";
       try {
           jdbcTemplate.update(sql, notice.getTitle(), notice.getContent(), notice.getNum());
       } catch (Exception e) {
           e.printStackTrace();
       }
   }

   /**
    * 공지사항을 삭제
    * @param num 삭제할 공지사항 번호
    */
   @Override
   public void delete(Long num) {
       String sql = "DELETE FROM notice WHERE num = ?";
       try {
           jdbcTemplate.update(sql, num);
       } catch (Exception e) {
           e.printStackTrace();
       }
   }
}