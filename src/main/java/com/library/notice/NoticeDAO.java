package com.library.notice;

import java.util.List;

public interface NoticeDAO {
	List<Notice> findAll(int page, int pageSize);
	Notice findByNum(Long num);
	void save(Notice notice);
	void update(Notice notice);
    void delete(Long num);
	int getTotalNoticeCount();     
}