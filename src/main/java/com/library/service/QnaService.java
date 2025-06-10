package com.library.service;

import com.library.qna.Qna;
import com.library.qna.Reply;

import java.util.List;

public interface QnaService {
    // QnA
    void createQna(Qna qna);
    void updateQna(Qna qna);
    void deleteQna(int qnaId);
    Qna getQnaById(int qnaId);
    void writeAnswer(int qnaId, String answerContent);
   
    int getTotalCountBySearch(String keyword, String category);

   
    List<Qna> getQnasBySearch(String keyword, String category, String sort, int page, int pageSize);

    // 답변
    void updateAnswer(int qnaId, String answer);

    // 댓글
    List<Reply> getRepliesByQnaId(int qnaId);
    Reply getReplyById(int replyId);
    void createReply(Reply reply);
    void updateReply(Reply reply);
    void deleteReply(int replyId);
}
