package com.library.board;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDAO {
    private final JdbcTemplate jdbcTemplate;
    
    public BoardDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
    
    private BoardDTO mapRowToBoardDTO(ResultSet rs, int rowNum) throws SQLException {
        BoardDTO post = new BoardDTO();
        post.setId(rs.getInt("id"));
        post.setTitle(rs.getString("title"));
        post.setContent(rs.getString("content"));
        post.setWriter(rs.getString("writer"));
        post.setCreatedAt(rs.getTimestamp("created_at"));
        return post;
    }
    
    public List<BoardDTO> getAllPosts(int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        String sql = "SELECT * FROM board ORDER BY id DESC LIMIT ? OFFSET ?";
        try {
            return jdbcTemplate.query(sql, this::mapRowToBoardDTO, pageSize, offset);
        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        }
    }
    
    public int getTotalPostCount() {
        String sql = "SELECT COUNT(*) FROM board";
        try {
            return jdbcTemplate.queryForObject(sql, Integer.class);
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    public BoardDTO getPostById(int id) {
        String sql = "SELECT * FROM board WHERE id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, this::mapRowToBoardDTO, id);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public void insertPost(BoardDTO dto) {
        String sql = "INSERT INTO board (title, content, writer) values(?, ?, ?)";
        try {
            jdbcTemplate.update(sql, 
                dto.getTitle(),
                dto.getContent(),
                dto.getWriter()
            );
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void updatePost(BoardDTO dto) {
        String sql = "UPDATE board SET title = ?, content = ? WHERE id = ?";
        try {
            jdbcTemplate.update(sql, 
                dto.getTitle(),
                dto.getContent(),
                dto.getId()
            );
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void deletePost(int id) {
        String sql = "DELETE FROM board WHERE id = ?";
        try {
            jdbcTemplate.update(sql, id);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}