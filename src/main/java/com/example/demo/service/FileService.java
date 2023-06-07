package com.example.demo.service;

import com.example.demo.dto.ArticleDTO;
import com.example.demo.dto.FileDTO;
import com.example.demo.repository.FileMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class FileService {
    private final FileMapper fileMapper;

    public void uploadFile(ArticleDTO article, FileDTO file, MultipartFile uploadFile) {
        if (uploadFile != null && !uploadFile.isEmpty()) {
            try {
                // 업로드할 파일 정보 설정
                String originalFilename = uploadFile.getOriginalFilename(); // 원본 파일 이름
                String storedFilename = UUID.randomUUID().toString(); // 중복을 방지하기 위해 저장할 때 사용되는 파일 이름
                String contentType = uploadFile.getContentType();
                long fileSize = uploadFile.getSize();
                // 파일 저장
                byte[] fileBytes = uploadFile.getBytes();
                // 저장할 path 정의
                Path path = Paths.get("C:/upload/" + storedFilename);
                // 파일에 텍스트 작성
                Files.write(path, fileBytes);
                // 파일 정보 DB에 저장
                file.setArticleId(article.getId());
                file.setOriginalFileName(originalFilename);
                file.setStoredFileName(storedFilename);
                file.setContentType(contentType);
                file.setFileSize(fileSize);
                fileMapper.insertFile(file);
            } catch (IOException e) {
                throw new RuntimeException("파일 업로드 실패", e);
            }
        }
    }

    public FileDTO getFileByArticleId(Long articleId) {
        return fileMapper.getFileByArticleId(articleId);
    }

    public FileDTO getFileByStoredFileName(String storedFileName) {
        return fileMapper.getFileByStoredFileName(storedFileName);
    }

    public void deleteFile(String deleteFileName) {
        FileDTO file = getFileByStoredFileName(deleteFileName);
        file.deleteFile();
        fileMapper.editFile(file);
    }
}
