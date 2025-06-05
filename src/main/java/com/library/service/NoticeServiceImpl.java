package com.library.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.library.notice.Notice;
import com.library.notice.NoticeDAO;

@Service
public class NoticeServiceImpl implements NoticeService{
	
	@Autowired
	private NoticeDAO noticeDAO;
	
	public List<Notice> findAll(int page, int pageSize){
		return noticeDAO.findAll(page, pageSize);
	}

	@Override
	public Notice findByNum(Long num) {
		System.out.println(2);
		return noticeDAO.findByNum(num);
	}
	
    public int getTotalNoticeCount() {
        return noticeDAO.getTotalNoticeCount();
    }

	@Override
	public void write(Notice notice) {
		noticeDAO.save(notice);
	}	
	
	@Override
	public void update(Notice notice) {
		noticeDAO.update(notice);
	}

	@Override
	public void delete(Long num) {
		noticeDAO.delete(num);		
	}	
}