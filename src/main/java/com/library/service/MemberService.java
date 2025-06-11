package com.library.service;

import java.util.List;

import com.library.member.MemberVO;

public interface MemberService {
    // 회원 정보를 받아 DB에 등록하는 메서드 (회원가입)
    void registerMember(MemberVO memberVO) throws Exception;

    // 특정 memberId가 이미 존재하는지 확인하는 메서드 (중복 확인)
    boolean isMemberIdExists(String memberId) throws Exception;

    // 로그인 기능: 아이디와 비밀번호로 회원 정보를 조회
    MemberVO login(String memberId, String password) throws Exception;

    // 회원 ID로 회원 정보 조회
    MemberVO getMemberById(String memberId) throws Exception;

    // --- 여기에 updateMember 메서드를 추가합니다 ---
    // 회원 정보를 업데이트하는 메서드
    boolean updateMember(MemberVO member) throws Exception;
    // --- 여기까지 추가합니다 ---
    List<MemberVO> showMembers();
    void setRole(String role, String id);
}