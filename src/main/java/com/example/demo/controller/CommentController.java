package com.example.demo.controller;

import com.example.demo.dto.CommentDTO;
import com.example.demo.service.CommentService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.Map;

@Controller
@RequestMapping("/comment")
@RequiredArgsConstructor
public class CommentController {

    private final CommentService commentService;

    @PostMapping("/create")
    public String create(CommentDTO comment, HttpSession session, Long id) {
        // 세션에서 로그인된 사용자의 아이디를 가져와서 writer 필드에 설정
        commentService.create(comment, id, (String) session.getAttribute("id"));
        return "redirect:/article/" + id;
    }

    @PostMapping("/edit")
    @ResponseBody
    public String edit(CommentDTO comment) {
        commentService.edit(comment);
        return "success";
    }

    @PostMapping("/delete")
    @ResponseBody
    public String delete(@RequestBody Map<String, Long> data) {
        Long id = data.get("id");
        commentService.delete(id);
        return "success";
    }

    @PostMapping("/reply")
    @ResponseBody
    public String reply(CommentDTO comment, HttpSession session) {
        commentService.createReply(comment, (String) session.getAttribute("id"));
        return "success";
    }
}
