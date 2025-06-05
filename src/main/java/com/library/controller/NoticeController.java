package com.library.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.library.notice.Notice;
import com.library.service.NoticeService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/notice")
public class NoticeController {

        @Autowired
        public NoticeService noticeService;
        
        private static final int PAGE_SIZE = 30;
    
        @GetMapping("/list")
        public String list(
                @RequestParam(value = "page",defaultValue = "1") int page,
                Model model) {
            List<Notice> notices = noticeService.findAll(page, PAGE_SIZE);
            int totalNotices = noticeService.getTotalNoticeCount();
            int totalPages = (int) Math.ceil((double) totalNotices / PAGE_SIZE);

            model.addAttribute("noticelist", notices);
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", totalPages);
            return "notice/list";
        }
        @GetMapping("/detail/{num}")
        public String detail(@PathVariable(value= "num", required = false) Long num, Model model) {
        	System.out.println(1);
             Notice notice = noticeService.findByNum(num);
             model.addAttribute("notice", notice);
            return "notice/detail";
        }

        @GetMapping("/write")
        public String writeform(){
            return "notice/write";
        }
        
        @PostMapping("write")
        public String writeSubmit(Notice notice, HttpSession session) {
            noticeService.write(notice);
            return "redirect:/notice/list";
        }
        
        @GetMapping("/edit")
        public String update(@RequestParam(value="num") Long num, Model model) {
            Notice notice= noticeService.findByNum(num);
            model.addAttribute("notice", notice);
            return "notice/edit";
        }
        
        @PostMapping("/edit")
        public String updatesubmit(@ModelAttribute Notice notice) {
            noticeService.update(notice);
            return "redirect:/notice/detail/"+notice.getNum();
        }
        
        @PostMapping("/delete")
        public String delete(@RequestParam("num")Long num) {
            noticeService.delete(num);
            return "redirect:/notice/list ";
        }
                
        @GetMapping("/admin-login")
        public String adminloginForm() {
            return "notice/admin-login";
        }
        
        @PostMapping("/admin-login")
        public String adminloginSubmit(
                @RequestParam(value = "username") String username,
                @RequestParam(value = "password") String password,
                HttpSession session, Model model
                ) {
            if("admin".equals(username)&&"9876".equals(password)) {
                session.setAttribute("isAdmin", true);
                return "redirect:/notice/list";
            }else {
                model.addAttribute("error", "너 누구야?");
                return "notice/admin-login";
            }                       
        }    
        
        @GetMapping("/admin-logout")
        public String logout(HttpSession session, RedirectAttributes redirectAttributes) {
            session.invalidate();
            redirectAttributes.addFlashAttribute("logoutmessage", "관리자가 나갔습니다.");      
            return "redirect:/notice/list";
        }
}