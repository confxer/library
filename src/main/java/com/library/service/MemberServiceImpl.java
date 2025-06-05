package com.library.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.library.member.MemberDAO;
import com.library.member.MemberVO;

@Service // 이 클래스가 서비스 계층임을 나타냅니다.
public class MemberServiceImpl implements MemberService {

    private final MemberDAO memberDAO; // MemberDAO 의존성 주입

    @Autowired
    public MemberServiceImpl(MemberDAO memberDAO) {
        this.memberDAO = memberDAO;
    }

    @Override
    public void registerMember(MemberVO memberVO) throws Exception {
        // 실제 구현 로직
        memberDAO.registerMember(memberVO);
    }

    @Override
    public boolean isMemberIdExists(String memberId) throws Exception {
        // 실제 구현 로직
        return memberDAO.isMemberIdExists(memberId);
    }

    @Override
    public MemberVO login(String memberId, String password) throws Exception {
        // 실제 구현 로직
        return memberDAO.getMemberById(memberId); // 실제 비밀번호 검증 로직 추가 필요
    }

    @Override
    public MemberVO getMemberById(String memberId) throws Exception {
        // 실제 구현 로직
        return memberDAO.getMemberById(memberId);
    }

    // --- 새로 추가하고 구현해야 할 메서드 ---
    @Override
    public boolean updateMember(MemberVO member) throws Exception {
        // 회원 정보 업데이트 로직을 여기에 구현합니다.
        // 일반적으로 DAO를 호출하여 DB 업데이트를 수행합니다.
        int updatedRows = memberDAO.updateMember(member); // MemberDAO에 updateMember 메서드가 있어야 합니다.
        return updatedRows > 0; // 1개 이상의 행이 업데이트되면 true 반환
    }
    // --- 여기까지 추가합니다 ---
}