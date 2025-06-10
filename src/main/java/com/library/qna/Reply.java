package com.library.qna;

import java.sql.Timestamp;

public class Reply {
    private int replyId;         // 답글 ID (PK)
    private int qnaId;           // 원본 QnA 게시글 ID (FK)
    private String writer;       // 작성자
    private String content;      // 답글 내용
    private Timestamp regDate;   // 작성일시
    private String writerRole;   // 작성자 역할 (예: "admin", "member") ← ★ 추가

    public Reply() {}

    public Reply(int replyId, int qnaId, String writer, String content, Timestamp regDate) {
        this.replyId = replyId;
        this.qnaId = qnaId;
        this.writer = writer;
        this.content = content;
        this.regDate = regDate;
    }

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

    public String getWriterRole() {
        return writerRole;
    }

    public void setWriterRole(String writerRole) {
        this.writerRole = writerRole;
    }

    @Override
    public String toString() {
        return "Reply{" +
                "replyId=" + replyId +
                ", qnaId=" + qnaId +
                ", writer='" + writer + '\'' +
                ", content='" + content + '\'' +
                ", regDate=" + regDate +
                ", writerRole='" + writerRole + '\'' +
                '}';
    }
}
