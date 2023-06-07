package com.example.demo.controller;

import com.example.demo.dto.ArticleDTO;
import com.example.demo.dto.CommentDTO;
import com.example.demo.dto.FileDTO;
import com.example.demo.service.ArticleService;
import com.example.demo.service.CommentService;
import com.example.demo.service.FileService;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Role;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/article")
@RequiredArgsConstructor
public class ArticleController {

    private final ArticleService articleService;
    private final FileService fileService;
    private final CommentService commentService;

    // Create 화면
    @GetMapping("/create")
    public String create(HttpSession session) {
        if (session.getAttribute("id") == null) {
            return "redirect:/user/login";
        }
        return "article/Create";
    }

    // Create
    @PostMapping("/create")
    public String create(ArticleDTO article, HttpSession session, FileDTO file, @RequestPart(required = false) MultipartFile uploadFile) {
        // 세션에서 로그인된 사용자의 아이디 가져와서 넘기기
        articleService.create(article, (String) session.getAttribute("id"));
        if (!uploadFile.isEmpty()) {
            fileService.uploadFile(article, file, uploadFile);
        }
        return "redirect:/article/list";
    }

    @GetMapping("/list")
    public String articleList(Model model, @RequestParam(defaultValue = "1") int page) {
        List<ArticleDTO> articleList = articleService.getArticlesByPage(page);
        int totalCount = articleService.getTotalCount();
        model.addAttribute("articles", articleList);
        model.addAttribute("pageCnt", Math.ceil((double) totalCount / 5));
        model.addAttribute("nowPage", page);
        return "article/List";
    }

    @GetMapping("/{id}")
    public String getArticleById(@PathVariable Long id, Model model, HttpSession session) {
        ArticleDTO article = articleService.read(id, (String) session.getAttribute("id"));
        if (article == null) {
            return "redirect:/error";
        }
        List<CommentDTO> comment = commentService.getComments(id);
        FileDTO file = fileService.getFileByArticleId(id);
        model.addAttribute("article", article);
        model.addAttribute("comments", comment);
        model.addAttribute("file", file);
        return "article/Detail";
    }

    @GetMapping("/edit/{id}")
    public String edit(@PathVariable Long id, Model model, HttpSession session) {
        ArticleDTO article = articleService.getArticleById(id);
        if (!session.getAttribute("id").equals(article.getWriter())) {
            return "redirect:/error";
        }
        model.addAttribute("article", article);
        FileDTO file = fileService.getFileByArticleId(id);
        model.addAttribute("file", file);
        return "article/Edit";
    }

    @PostMapping("/edit")
    public String edit(ArticleDTO article, @RequestPart(required = false) MultipartFile uploadFile, @RequestParam(required = false) String deleteFileName, FileDTO file) {
        // 삭제된 파일이 있다면
        if (!deleteFileName.equals("null")) {
            fileService.deleteFile(deleteFileName);
        }
        // 추가된 파일이 있다면
        if (uploadFile != null && !uploadFile.isEmpty()) {
            fileService.uploadFile(article, file, uploadFile);
        }
        // 게시글 수정
        articleService.edit(article);
        return "redirect:/article/" + article.getId();
    }

    @PostMapping("/delete")
    @ResponseBody
    public String delete(@RequestBody Map<String, Long> data) {
        Long id = data.get("id");
        articleService.delete(id);
        return "success";
    }

    @GetMapping("/list/search")
    public String articleSearch(Model model, @RequestParam(defaultValue = "1") int page, @RequestParam String option, @RequestParam String keyword) {
        List<ArticleDTO> articleList = articleService.getArticlesBySearch(page, option, keyword);
        int totalCount = articleList.size();
        model.addAttribute("articles", articleList);
        model.addAttribute("pageCnt", Math.ceil((double) totalCount / 5));
        model.addAttribute("nowPage", page);
        model.addAttribute("keyword", keyword);
        model.addAttribute("option", option);
        return "article/Search";
    }
}
