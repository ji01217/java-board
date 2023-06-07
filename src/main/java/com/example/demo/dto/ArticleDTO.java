package com.example.demo.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;
import java.util.List;

@Getter
@Setter
public class ArticleDTO {
    private Long id;
    private String title;
    private String content;
    private String writer;
    private int viewCnt;
    private boolean deleted;
    private Date createdAt;
    private Date updatedAt;

    private List<CommentDTO> commentList;

    public void read(String userId) {
        if (!writer.equals(userId))
            viewCnt++;
    }

    public void deleteArticle() {
        deleted = true;
    }
}