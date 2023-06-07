package com.example.demo.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class CommentDTO {
    private Long id;
    private String content;
    private Long articleId;
    private String writer;
    private Date createdAt;
    private boolean deleted;
    private Long parentId;
    private int level;

    public void deleteComment() {
        deleted = true;
    }
}