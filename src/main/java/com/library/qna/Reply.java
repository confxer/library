package com.library.qna;

import java.sql.Timestamp;

public class Reply {
    private int replyId;      // 답글 ID (PK)
    private int qnaId;        // 원본 QnA 게시글 ID (FK)
    private String writer;    // 작성자 (예: admin)
    private String content;   // 답글 내용
    private Timestamp regDate; // 작성일시

    // 기본 생성자
    public Reply() {}

    // getter / setter

    public int getReplyId() {
        return replyId;
    }
    public void setReplyId(int replyId) {
        this.replyId = replyId;
    }

    public int getQnaId() {
        return qnaId;
    }
    public void setQnaId(int qnaId) {
        this.qnaId = qnaId;
    }

    public String getWriter() {
        return writer;
    }
    public void setWriter(String writer) {
        this.writer = writer;
    }

    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }

    public Timestamp getRegDate() {
        return regDate;
    }
    public void setRegDate(Timestamp regDate) {
        this.regDate = regDate;
    }
}
