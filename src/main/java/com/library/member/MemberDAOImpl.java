package com.library.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.Timestamp; // Timestamp 임포트
import java.util.Date; // Date 임포트
import java.util.List;

@Repository
public class MemberDAOImpl implements MemberDAO {

    private final JdbcTemplate jdbcTemplate;

    @Autowired
    public MemberDAOImpl(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    @Override
    public MemberVO getMemberById(String memberId) throws Exception {
        String sql = "SELECT * FROM member WHERE member_id = ?";
        try {
        	System.out.println(memberId);
        	return jdbcTemplate.queryForObject(sql, (rs, rowNum) ->{
        		MemberVO member = new MemberVO();
        		member.setAddress(rs.getString("address"));
        		member.setEmail(rs.getString("email"));
        		member.setMemberId(rs.getString("member_id"));
        		member.setName(rs.getString("name"));
        		member.setPassword(rs.getString("password"));
        		member.setPhone(rs.getString("phone"));
        		Timestamp regTimestamp = rs.getTimestamp("regDate");
        	    member.setRegDate(regTimestamp != null ? new Date(regTimestamp.getTime()) : null);
                member.setRole(rs.getString("role"));
                member.setStatus(rs.getString("status"));
                System.out.println(member.toString());
        		return member;
        	}, memberId	);
		} catch (Exception e) {
			return null;
		}
    }

    @Override
    public  MemberVO login(String memberId, String password) throws Exception {
    	String sql = "select * from member where member_id = ? and password = ?";
    	try {
        	return jdbcTemplate.queryForObject(sql, (rs, rowNum) ->{
        		MemberVO member = new MemberVO();
        		member.setAddress(rs.getString("address"));
        		member.setEmail(rs.getString("email"));
        		member.setMemberId(rs.getString("member_id"));
        		member.setName(rs.getString("name"));
        		member.setPassword(rs.getString("password"));
        		member.setPhone(rs.getString("phone"));
        		Timestamp regTimestamp = rs.getTimestamp("regDate");
        	    member.setRegDate(regTimestamp != null ? new Date(regTimestamp.getTime()) : null);
                member.setRole(rs.getString("role"));
                member.setStatus(rs.getString("status"));
                System.out.println(member.toString());
        		return member;
        	}, memberId, password);
		} catch (Exception e) {
			return null;
		}
    }

    @Override
    public int updateMember(MemberVO member) throws Exception {
        String sql = "UPDATE member SET name = ?, email = ?, phone = ?, address = ?, role = ?, status = ?";
        boolean updatePassword = (member.getPassword() != null && !member.getPassword().isEmpty());

        if (updatePassword) {
            sql += ", password = ?";
        }
        sql += " WHERE member_id = ?";

        Object[] params;
        if (updatePassword) {
            params = new Object[]{
                member.getName(), member.getEmail(), member.getPhone(), member.getAddress(),
                member.getRole(), member.getStatus(),
                member.getPassword(),
                member.getMemberId()
            };
        } else {
            params = new Object[]{
                member.getName(), member.getEmail(), member.getPhone(), member.getAddress(),
                member.getRole(), member.getStatus(),
                member.getMemberId()
            };
        }
        return jdbcTemplate.update(sql, params);
    }

    @Override
    public void registerMember(MemberVO memberVO) throws Exception {
        String sql = "INSERT INTO member (member_id, password, name, email, phone, address, role, status, regDate) VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW())";

        jdbcTemplate.update(sql,
                memberVO.getMemberId(),
                memberVO.getPassword(),
                memberVO.getName(),
                memberVO.getEmail(),
                memberVO.getPhone(),
                memberVO.getAddress(),
                memberVO.getRole() != null ? memberVO.getRole() : "USER",
                memberVO.getStatus() != null ? memberVO.getStatus() : "ACTIVE"
        );
    }

    @Override
    public boolean isMemberIdExists(String memberId) throws Exception {
        String sql = "SELECT COUNT(*) FROM member WHERE member_id = ?";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, memberId);
        return count != null && count > 0;
    }

	@Override
	public List<MemberVO> showMembers() {
		String sql = "select * from member";
		return jdbcTemplate.query(sql, (rs, rowNum) ->{
			MemberVO member = new MemberVO();
    		member.setAddress(rs.getString("address"));
    		member.setEmail(rs.getString("email"));
    		member.setMemberId(rs.getString("member_id"));
    		member.setName(rs.getString("name"));
    		member.setPassword(rs.getString("password"));
    		member.setPhone(rs.getString("phone"));
    		Timestamp regTimestamp = rs.getTimestamp("regDate");
    	    member.setRegDate(regTimestamp != null ? new Date(regTimestamp.getTime()) : null);
            member.setRole(rs.getString("role"));
            member.setStatus(rs.getString("status"));
			return member;
		});
	}

	@Override
	public void setRole(String role, String id) {
		String sql = "update member set role = ? where member_id = ?";
		jdbcTemplate.update(sql,role,id);
		
	}
}