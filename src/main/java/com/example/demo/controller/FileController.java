package com.example.demo.controller;

import com.example.demo.dto.FileDTO;
import com.example.demo.service.FileService;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import org.springframework.core.io.Resource;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Paths;
import java.util.UUID;

@Controller
@RequiredArgsConstructor
public class FileController {
    private final FileService fileService;

    @GetMapping("/download/{storedFileName}")
    public ResponseEntity<Resource> downloadFile(@PathVariable String storedFileName) {
        // 파일 정보 조회 (원본 파일 이름과 타입)
        FileDTO file = fileService.getFileByStoredFileName(storedFileName);

        // 파일이 저장된 경로
        String filePath = "C:/upload/" + storedFileName;

        // 파일을 로드하는 Resource 객체 생성
        Resource resource;
        try {
            resource = new UrlResource(Paths.get(filePath).toUri());
        } catch (MalformedURLException e) {
            throw new RuntimeException("파일을 찾을 수 없습니다.", e);
        }

        // 다운로드할 때 사용되는 Content-Disposition 헤더 설정
        String originalFileName = file.getOriginalFileName();
        String encodedFileName;
        try {
            encodedFileName = URLEncoder.encode(originalFileName, StandardCharsets.UTF_8.toString());
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException("파일 이름 인코딩에 실패했습니다.", e);
        }
        String contentDisposition = "attachment; filename=\"" + encodedFileName + "\"";

        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, contentDisposition)
                .contentType(MediaType.parseMediaType(file.getContentType()))
                .body(resource);
    }

    @PostMapping("/image/upload")
    public ModelAndView image(MultipartHttpServletRequest request) throws Exception {
        // CKEditor는 이미지 업로드 후 이미지를 표시하기 위해 uploaded와 url을 json 형식으로 받아야 한다.
        // ModelAndView를 사용하여 json 형식으로 보낸다.
        ModelAndView mav = new ModelAndView("jsonView");

        // CKEditor에서 파일을 보낼 때 upload: [파일] 형식으로 해서 넘어오기 때문에 upload라는 키의 value를 받아서 uploadFile에 저장한다.
        MultipartFile uploadFile = request.getFile("upload");

        String originalFileName = uploadFile.getOriginalFilename();
        String ext = originalFileName.substring(originalFileName.indexOf("."));
        String newFileName = UUID.randomUUID() + ext;
        // 현재 경로(절대 경로)
        String realPath = request.getServletContext().getRealPath("/");
        String savePath = realPath + "upload/" + newFileName;
        // 브라우저에서 이미지 불러오는 경로(상대 경로)
        String uploadPath = "/upload/" + newFileName;

        File file = new File(savePath);
        uploadFile.transferTo(file);

        mav.addObject("uploaded", true);
        mav.addObject("url", uploadPath);

        return mav;
    }
}
