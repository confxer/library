package com.library.qna;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class QnaDAO {
	private JdbcTemplate jdbcTemplate;

	public QnaDAO(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}
   private Qna mapRowToQna(ResultSet rs, int rowNum) throws SQLException {
        Qna qna = new Qna();
        qna.setQnaId(rs.getInt("qna_id"));
        qna.setTitle(rs.getString("title"));
        qna.setContent(rs.getString("content"));
        qna.setWriter(rs.getString("writer"));
        qna.setRegDate(rs.getTimestamp("reg_date"));
        qna.setStatus(rs.getString("status"));
        qna.setViewCount(rs.getInt("view_count"));
        qna.setPassword(rs.getString("password"));
        qna.setOpenYn(rs.getString("open_yn"));
        qna.setCategory(rs.getString("category"));
        qna.setAnswer(rs.getString("answer"));
        qna.setAnswerRegDate(rs.getTimestamp("answer_reg_date"));
        qna.setDeletedYn(rs.getString("deleted_yn"));
        qna.setModifiedDate(rs.getTimestamp("modified_date"));
        return qna;
    }

    // QnA 글 작성
    public int insertQna(Qna qna) {
        String sql = "INSERT INTO qna (title, content, writer, password, status, open_yn, category, reg_date, view_count) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, NOW(), 0)";
        return jdbcTemplate.update(sql,
                qna.getTitle(), qna.getContent(), qna.getWriter(),
                qna.getPassword(), qna.getStatus(), qna.getOpenYn(), qna.getCategory());
    }

    // QnA 글 1개 조회
    public Qna getQnaById(int qnaId) {
        String sql = "SELECT * FROM qna WHERE qna_id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, this::mapRowToQna, qnaId);
        } catch (Exception e) {
            return null;
        }
    }

    // QnA 글 전체 목록 조회
    public List<Qna> getAllQnas() {
        String sql = "SELECT * FROM qna ORDER BY qna_id DESC";
        return jdbcTemplate.query(sql, this::mapRowToQna);   
        }

    // QnA 글 수정
    public int updateQna(Qna qna) {
        String sql = "UPDATE qna SET title = ?, content = ?, status = ?, password = ?, open_yn = ?, category = ? WHERE qna_id = ?";
        return jdbcTemplate.update(sql,
                qna.getTitle(), qna.getContent(), qna.getStatus(),
                qna.getPassword(), qna.getOpenYn(), qna.getCategory(), qna.getQnaId());
    }

    // QnA 글 삭제
    public int deleteQna(int qnaId) {
        String sql = "DELETE FROM qna WHERE qna_id = ?";
        return jdbcTemplate.update(sql, qnaId);
    }

    // QnA 조회수 증가
    public int increaseViewCount(int qnaId) {
        String sql = "UPDATE qna SET view_count = view_count + 1 WHERE qna_id = ?";
        return jdbcTemplate.update(sql, qnaId);
    }

    // QnA 상태 업데이트 (예: "완료", "대기중" 등)
    public int updateStatus(int qnaId, String status) {
        String sql = "UPDATE qna SET status = ? WHERE qna_id = ?";
        return jdbcTemplate.update(sql, status, qnaId);
    }

    // QnA 답변 등록 또는 수정 (answer 컬럼 + answer_reg_date 업데이트)
    public int updateAnswer(int qnaId, String answer) {
        String sql = "UPDATE qna SET answer = ?, answer_reg_date = NOW() WHERE qna_id = ?";
        return jdbcTemplate.update(sql, answer, qnaId);
    }

    // 전체 글 개수 조회 (페이징용)
    public int getTotalCount() {
        String sql = "SELECT COUNT(*) FROM qna";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }

    // 페이징 처리된 글 목록 조회
    public List<Qna> getQnaByPage(int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        String sql = "SELECT * FROM qna WHERE deleted_yn = 'N' ORDER BY qna_id DESC LIMIT ? OFFSET ?";
        return jdbcTemplate.query(sql, this::mapRowToQna, pageSize, offset);
    }

    // 검색 기능 추가 (검색 키워드와 카테고리에 따라 글 조회)
    public List<Qna> getQnasBySearch(String searchKeyword, String searchCategory, int currentPage, int pageSize) {
        List<Object> params = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM qna WHERE deleted_yn = 'N'");

        if (searchKeyword != null && !searchKeyword.isEmpty()) {
            sql.append(" AND (title LIKE ? OR content LIKE ?)");
            params.add("%" + searchKeyword + "%");
            params.add("%" + searchKeyword + "%");
        }
        if (searchCategory != null && !searchCategory.isEmpty()) {
            sql.append(" AND category = ?");
            params.add(searchCategory);
        }
        sql.append(" ORDER BY qna_id DESC LIMIT ? OFFSET ?");
        params.add(pageSize);
        params.add((currentPage - 1) * pageSize);

        return jdbcTemplate.query(sql.toString(), this::mapRowToQna, params.toArray());
    }
    
    // 검색 시 전체 글 개수 조회 (페이징용)
    public int getTotalCountBySearch(String searchKeyword, String searchCategory) {
        List<Object> params = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM qna WHERE deleted_yn = 'N'");

        if (searchKeyword != null && !searchKeyword.isEmpty()) {
            sql.append(" AND (title LIKE ? OR content LIKE ?)");
            params.add("%" + searchKeyword + "%");
            params.add("%" + searchKeyword + "%");
        }
        if (searchCategory != null && !searchCategory.isEmpty()) {
            sql.append(" AND category = ?");
            params.add(searchCategory);
        }

        return jdbcTemplate.queryForObject(sql.toString(), Integer.class, params.toArray());
    }
}
