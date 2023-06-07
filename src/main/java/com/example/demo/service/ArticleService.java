package com.example.demo.service;

import com.example.demo.dto.ArticleDTO;
import com.example.demo.repository.ArticleMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ArticleService {

    private final ArticleMapper articleMapper;

    public void create(ArticleDTO article, String userId) {
        article.setWriter(userId);
        articleMapper.create(article);
    }

    public ArticleDTO getArticleById(Long id) {
        return articleMapper.getArticleById(id);
    }

    public void edit(ArticleDTO article) {
        articleMapper.edit(article);
    }

    public void delete(Long id) {
        ArticleDTO article = articleMapper.getArticleById(id);
        article.deleteArticle();
        articleMapper.edit(article);
    }

    public List<ArticleDTO> getArticlesByPage(int page) {
        int offset = (page - 1) * 5;
        return articleMapper.getArticlesByPage(offset);
    }

    public int getTotalCount() {
        return articleMapper.getTotalCount();
    }

    public List<ArticleDTO> getArticlesBySearch(int page, String option, String keyword) {
        int offset = (page - 1) * 5;
        if (option.equals("전체")) {
            return articleMapper.getArticlesBySearchAll(offset, keyword);
        } else {
            return articleMapper.getArticlesBySearch(offset, option, keyword);
        }
    }

    public ArticleDTO read(Long articleId, String userId) {
        ArticleDTO article = articleMapper.getArticleById(articleId);
        article.read(userId);
        articleMapper.edit(article);
        return article;
    }
}