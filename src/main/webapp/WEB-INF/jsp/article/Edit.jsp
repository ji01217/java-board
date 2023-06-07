<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <title>게시글 수정하기</title>
    <script src="https://cdn.ckeditor.com/ckeditor5/37.0.1/classic/ckeditor.js"></script>
    <script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/translations/ko.js"></script>
    <script src="https://ckeditor.com/apps/ckfinder/3.5.0/ckfinder.js"></script>
    <style>
        .ck-editor__editable {
            height: 400px;
        }
    </style>
</head>
<body>
<jsp:include page="../layout.jsp"/>
<div class="container" style="max-width: 800px;">
    <h1 class="mb-3 fw-bold">게시글 수정하기</h1>
    <hr/>
    <form onsubmit="editArticle(event)">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <input type="hidden" name="id" value="${article.id}" id="articleId"/>
        <div class="mb-3">
            <input type="text" id="title" name="title" required value="${article.title}" class="form-control"
                   placeholder="제목"/>
        </div>
        <div class="mb-3">
            <textarea id="editor" name="content" required class="form-control ck-editor__editable"
                      placeholder="내용">${article.content}</textarea>
        </div>
        <div class="input-group mb-3" style="display: ${(empty file)? "":"none"};" id="fileInput">
            <label for="uploadFile"></label>
            <input type="file" class="form-control" id="uploadFile" name="uploadFile">
        </div>
        <c:if test="${!empty file}">
            <div class="bg-danger bg-opacity-10 p-2 ps-3 pe-3 mb-3" style="border-radius: 10px;"
                 id="fileDiv">
                <span>${file.originalFileName}</span>
                <span onclick="deleteFile('${file.storedFileName}')" style="cursor: pointer">🗑</span>
            </div>
        </c:if>
        <div class="d-grid">
            <button type="submit" class="btn btn-primary" onclick="submitArticle()">수정하기</button>
        </div>
        <div class="d-flex justify-content-end">
            <a href="javascript:window.history.back();"
               class="link-dark link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover">뒤로가기</a>
        </div>
    </form>
</div>
<script type="text/javascript">
    const csrfToken = document.getElementsByName('_csrf')[0].value;
    const articleId = document.getElementById('articleId').value;
    const fileInput = document.getElementById('fileInput');
    const fileDiv = document.getElementById('fileDiv');
    let deleteFileName = null;

    function deleteFile(storedFileName) {
        deleteFileName = storedFileName;
        fileDiv.style.display = "none";
        fileInput.style.display = "";
    }

    function editArticle(event) {
        event.preventDefault();
        let formData = new FormData(event.target);
        formData.append('deleteFileName', deleteFileName);
        $.ajax({
            type: "POST",
            url: "/article/edit",
            data: formData,
            processData: false,
            contentType: false,
            success: function () {
                location.href = "/article/" + articleId;
            },
            error: function (error) {
                console.log(error);
            }
        })
    }

    let editor;
    const articleContent = document.getElementById('editor');
    ClassicEditor.create(document.querySelector('#editor'), {
        language: "ko",
        ckfinder: {
            uploadUrl: '/image/upload'
        },
        mediaEmbed: {
            previewsInData: true
        },
        link: {
            decorators: {
                openInNewTab: {
                    mode: 'manual',
                    label: 'Open in a new tab',
                    attributes: {
                        target: '_blank',
                        rel: 'noopener noreferrer'
                    }
                }
            }
        }
    }).then(
        newEditor => {
            editor = newEditor;
        }
    ).catch(error => {
        console.log(error);
    });

    function submitArticle() {
        articleContent.value = editor.getData();
    }
</script>
</body>
</html>