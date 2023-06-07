package com.example.demo.repository;

import com.example.demo.dto.ArticleDTO;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ArticleMapper {

    void create(ArticleDTO articleDTO);

    ArticleDTO getArticleById(Long id);

    void edit(ArticleDTO article);

    List<ArticleDTO> getArticlesByPage(@Param("offset") int offset);

    int getTotalCount();

    List<ArticleDTO> getArticlesBySearch(@Param("offset") int offset, @Param("option") String option, @Param("keyword") String keyword);

    List<ArticleDTO> getArticlesBySearchAll(@Param("offset") int offset, @Param("keyword") String keyword);
}
