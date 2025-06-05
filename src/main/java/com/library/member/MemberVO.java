package com.library.member;

import java.util.Date; // Date 클래스를 사용합니다.

public class MemberVO {
    private String memberId;
    private String password;
    private String name;
    private String email;
    private String role;
    private Date regDate; // 타입을 LocalDateTime에서 Date로 변경
    private String status;
    private String phone;
    private String address;

    // 1. 기본 생성자
    public MemberVO() {
    }

    // 2. 모든 필드를 매개변수로 받는 생성자
    public MemberVO(String memberId, String password, String name, String email, String role,
                    Date regDate, String status, String phone, String address) {
        this.memberId = memberId;
        this.password = password;
        this.name = name;
        this.email = email;
        this.role = role;
        this.regDate = regDate;
        this.status = status;
        this.phone = phone;
        this.address = address;
    }

    // --- Getter와 Setter 메서드 시작 ---

    public String getMemberId() {
        return memberId;
    }

    public void setMemberId(String memberId) {
        this.memberId = memberId;
    }

    public String getPassword() { // password 필드의 Getter
        return password;
    }

    public void setPassword(String password) { // password 필드의 Setter
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Date getRegDate() { // regDate 필드의 Getter
        return regDate;
    }

    public void setRegDate(Date regDate) { // regDate 필드의 Setter
        this.regDate = regDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    // --- Getter와 Setter 메서드 끝 ---

    // toString() 메서드
    @Override
    public String toString() {
        return "MemberVO{" +
               "memberId='" + memberId + '\'' +
               ", password='[PROTECTED]'" +
               ", name='" + name + '\'' +
               ", email='" + email + '\'' +
               ", role='" + role + '\'' +
               ", regDate=" + regDate +
               ", status='" + status + '\'' +
               ", phone='" + phone + '\'' +
               ", address='" + address + '\'' +
               '}';
    }
}