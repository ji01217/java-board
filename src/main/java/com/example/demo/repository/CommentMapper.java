package com.example.demo.repository;

import com.example.demo.dto.CommentDTO;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CommentMapper {
    List<CommentDTO> getComments(Long articleId);

    CommentDTO getCommentById(Long id);

    void create(CommentDTO comment);

    void edit(CommentDTO comment);
}
