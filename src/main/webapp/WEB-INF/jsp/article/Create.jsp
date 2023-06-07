<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <title>게시글 작성하기</title>
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
    <h1 class="mb-3 fw-bold">게시글 작성하기</h1>
    <hr/>
    <form action="/article/create" method="post" enctype="multipart/form-data">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <div class="mb-3">
            <input type="text" id="title" name="title" required class="form-control" placeholder="제목"/>
        </div>
        <div class="mb-3">
            <textarea id="editor" name="content" required class="form-control ck-editor__editable"
                      placeholder="내용"></textarea>
        </div>
        <div class="input-group mb-3">
            <label for="uploadFile"></label>
            <input type="file" class="form-control" id="uploadFile" name="uploadFile">
        </div>
        <div class="d-grid">
            <button type="submit" class="btn btn-primary" onclick="submitArticle()">게시하기</button>
        </div>
    </form>
</div>
<script>
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