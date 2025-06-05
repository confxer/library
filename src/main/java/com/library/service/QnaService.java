package com.library.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.library.qna.Qna;
import com.library.qna.QnaDAO;
import com.library.qna.Reply;
import com.library.qna.ReplyDAO;

import java.util.List;

@Service
public class QnaService {
    private final QnaDAO qnaDAO;
    private final ReplyDAO replyDAO;

    public QnaService(QnaDAO qnaDAO, ReplyDAO replyDAO) {
        this.qnaDAO = qnaDAO;
        this.replyDAO = replyDAO;
    }

    @Transactional
    public int createQna(Qna qna) {
        return qnaDAO.insertQna(qna);
    }

    @Transactional
    public Qna getQnaById(int qnaId) {
        qnaDAO.increaseViewCount(qnaId);
        return qnaDAO.getQnaById(qnaId);
    }

    public List<Qna> getAllQnas() {
        return qnaDAO.getAllQnas();
    }

    @Transactional
    public int updateQna(Qna qna) {
        return qnaDAO.updateQna(qna);
    }

    @Transactional
    public int deleteQna(int qnaId) {
        return qnaDAO.deleteQna(qnaId);
    }

    @Transactional
    public int updateAnswer(int qnaId, String answer) {
        int updated = qnaDAO.updateAnswer(qnaId, answer);
        if (updated > 0) {
            qnaDAO.updateStatus(qnaId, "완료");
        }
        return updated;
    }

    public List<Qna> getQnaByPage(int page, int pageSize) {
        return qnaDAO.getQnaByPage(page, pageSize);
    }

    public int getTotalCount() {
        return qnaDAO.getTotalCount();
    }

    public List<Qna> searchQnas(String searchKeyword, String searchCategory, int currentPage, int pageSize) {
        return qnaDAO.getQnasBySearch(searchKeyword, searchCategory, currentPage, pageSize);
    }

    public int getTotalCountBySearch(String searchKeyword, String searchCategory) {
        return qnaDAO.getTotalCountBySearch(searchKeyword, searchCategory);
    }

    public List<Reply> getRepliesByQnaId(int qnaId) {
        return replyDAO.getRepliesByQnaId(qnaId);
    }

    @Transactional
    public int createReply(Reply reply) {
        return replyDAO.insertReply(reply);
    }

    @Transactional
    public int updateReply(Reply reply) {
        return replyDAO.updateReply(reply);
    }

    @Transactional
    public int deleteReply(int replyId) {
        return replyDAO.deleteReply(replyId);
    }
}