package com.library.service;

import java.util.List;

import com.library.notice.Notice;

public interface NoticeService {

	List<Notice> findAll(int page, int pageSize);
	Notice findByNum(Long num);
	void write(Notice notice);
	void update(Notice notice);
	void delete(Long num);
	int getTotalNoticeCount();

}