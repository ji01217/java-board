package com.example.demo.service;

import com.example.demo.dto.CommentDTO;
import com.example.demo.repository.CommentMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CommentService {
    private final CommentMapper commentMapper;

    public List<CommentDTO> getComments(Long id) {
        return commentMapper.getComments(id);
    }

    public void create(CommentDTO comment, Long id, String writer) {
        comment.setArticleId(id);
        comment.setWriter(writer);
        commentMapper.create(comment);
    }

    public void edit(CommentDTO comment) {
        commentMapper.edit(comment);
    }

    public void delete(Long id) {
        CommentDTO comment = commentMapper.getCommentById(id);
        comment.deleteComment();
        commentMapper.edit(comment);
    }

    public void createReply(CommentDTO comment, String writer) {
        comment.setWriter(writer);
        commentMapper.create(comment);
    }
}
