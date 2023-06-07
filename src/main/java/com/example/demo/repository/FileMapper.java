package com.example.demo.repository;

import com.example.demo.dto.FileDTO;
import org.springframework.stereotype.Repository;

@Repository
public interface FileMapper {
    void insertFile(FileDTO file);

    FileDTO getFileByArticleId(Long id);

    FileDTO getFileByStoredFileName(String storedFileName);

    void editFile(FileDTO file);
}
