
package com.library.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.library.book.Book;
import com.library.book.BookDTO;
import com.library.notice.Notice;
import com.library.qna.Qna;
import com.library.service.BookService;
import com.library.service.NoticeService;
import com.library.service.QnaService;

@Controller
public class HomeController {
	
	@Autowired
	private BookService bookService;
	
	@Autowired
	private NoticeService noticeService;
	
	@Autowired
	private QnaService qnaService;
	
	private static final int PAGE_SIZE = 4;
	
    @GetMapping("/")
    public String home(Model model) {
    	List<Book> recommendations = bookService.listRecommendation(); 
    	List<Qna> qnas = qnaService.getQnasBySearch(null, null, null, 1, PAGE_SIZE);
    	List<Notice> notices = noticeService.findAll(1, PAGE_SIZE);
    	model.addAttribute("notices", notices);
    	model.addAttribute("qnas",qnas);
    	model.addAttribute("recommendations", recommendations);
        return "index"; // views/index.jsp 반환
    }

    @GetMapping("/index")
    public String indexPage(Model model) {
        return home(model); // home() 메서드를 호출하여 Model에 데이터를 담고 동일한 JSP를 반환
    }

    @GetMapping("/library")
    public String myLibrary
    	(@RequestParam(value = "page",defaultValue = "1") int page,
        @RequestParam(value = "size",defaultValue = "30") int size,
        Model model) {
	    if (size >= 200) size = 200; // 최대 200개 제한
	    else if (size >= 100) size = 100;
	    else if (size >= 50) size = 50;
	    else size = 30;
	    List<BookDTO> books = bookService.getAllBooks(page, size);
	    long totalBooks = bookService.getTotalBooks();
	    model.addAttribute("books", books);
	    model.addAttribute("totalBooks", totalBooks);
	    model.addAttribute("currentPage", page);
	    model.addAttribute("pageSize", size);
        return "book/list"; 
       
    }
}