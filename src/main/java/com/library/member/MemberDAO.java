package com.library.member;

import java.util.List;

public interface MemberDAO {
    void registerMember(MemberVO memberVO) throws Exception;
    MemberVO getMemberById(String memberId) throws Exception;
    
    // --- 다음 두 메서드를 추가합니다! ---
    MemberVO login(String memberId, String password) throws Exception; // 로그인 메서드 추가
    int updateMember(MemberVO member) throws Exception; // 회원 정보 수정 메서드 추가
    // --- 여기까지 추가합니다 ---

    // isMemberIdExists 메서드가 MemberDAOImpl에 있다면 인터페이스에도 추가해야 합니다.
    boolean isMemberIdExists(String memberId) throws Exception;
    
    List<MemberVO> showMembers();
}