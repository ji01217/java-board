package com.example.demo.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class FileDTO {
    private Long id;
    private Long articleId;
    private String originalFileName;
    private String storedFileName;
    private String contentType;
    private Long fileSize;
    private boolean deleted;
    private Date createdAt;

    public void deleteFile() {
        deleted = true;
    }
}
