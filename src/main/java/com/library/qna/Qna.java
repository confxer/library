package com.library.qna;

import java.sql.Timestamp;

public class Qna {

    private int qnaId;           // 글 번호 (PK)
    private String title;        // 제목
    private String content;      // 내용
    private String writer;       // 글쓴이
    private Timestamp regDate;   // 등록일
    private Timestamp modifiedDate; // 수정일 추가
    private String status;       // 처리상황 (예: "완료", "대기중")
    private int viewCount;       // 조회수
    private String password;     // 비밀번호 (작성자/관리자 확인용)
    private String openYn;       // 공개여부 (Y/N)
    private String answer;       // 관리자 답변
    private Timestamp answerRegDate;  // 답변 등록일
    private String category;     // 카테고리 추가
    private String deletedYn;    // 삭제여부 (Y/N) 추가

    // 기본 생성자
    public Qna() {}

    // getter / setter

    public int getQnaId() {
        return qnaId;
    }

    public void setQnaId(int qnaId) {
        this.qnaId = qnaId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getWriter() {
        return writer;
    }

    public void setWriter(String writer) {
        this.writer = writer;
    }

    public Timestamp getRegDate() {
        return regDate;
    }

    public void setRegDate(Timestamp regDate) {
        this.regDate = regDate;
    }

    public Timestamp getModifiedDate() {
        return modifiedDate;
    }

    public void setModifiedDate(Timestamp modifiedDate) {
        this.modifiedDate = modifiedDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getViewCount() {
        return viewCount;
    }

    public void setViewCount(int viewCount) {
        this.viewCount = viewCount;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getOpenYn() {
        return openYn;
    }

    public void setOpenYn(String openYn) {
        this.openYn = openYn;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public Timestamp getAnswerRegDate() {
        return answerRegDate;
    }

    public void setAnswerRegDate(Timestamp answerRegDate) {
        this.answerRegDate = answerRegDate;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getDeletedYn() {
        return deletedYn;
    }

    public void setDeletedYn(String deletedYn) {
        this.deletedYn = deletedYn;
    }

	@Override
	public String toString() {
		return "Qna [qnaId=" + qnaId + ", title=" + title + ", content=" + content + ", writer=" + writer + ", regDate="
				+ regDate + ", modifiedDate=" + modifiedDate + ", status=" + status + ", viewCount=" + viewCount
				+ ", password=" + password + ", openYn=" + openYn + ", answer=" + answer + ", answerRegDate="
				+ answerRegDate + ", category=" + category + ", deletedYn=" + deletedYn + "]";
	}
}
