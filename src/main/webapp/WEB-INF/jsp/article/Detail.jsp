<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <title>게시글 상세보기</title>
</head>
<body>
<jsp:include page="../layout.jsp"/>
<%--세션에서 로그인된 유저 아이디를 가져옴--%>
<c:set var="loginUserId" value="${sessionScope.id}"/>
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
<div class="container" style="max-width: 800px;">
    <h1 class="mb-3 fw-bold">게시글 상세보기</h1>
    <hr/>
    <div>
        <h2 class="mb-3 fw-bold">${article.title}</h2>
        <p class="text-end"><strong>조회수:</strong> ${article.viewCnt}</p>
        <p class="text-end"><strong>작성자:</strong> ${article.writer}</p>
        <p class="text-end"><strong>작성일시:</strong> <fmt:formatDate value="${article.createdAt}"
                                                                   pattern="yyyy/MM/dd HH:mm"/></p>
        <div>${article.content}</div>
        <c:if test="${file != null}">
            <div class="d-flex justify-content-between bg-danger bg-opacity-10 p-2 pe-3 mb-3"
                 style="border-radius: 10px;">
                <div class="d-flex flex-column">
                    <div>
                            ${file.originalFileName}
                    </div>
                    <div class="text-secondary fst-italic" style="font-size: 12px;">
                            ${file.fileSize}byte
                    </div>
                </div>
                <a class="d-flex align-items-center"
                   href="/download/${file.storedFileName}" download>📥
                </a>
            </div>
        </c:if>
    </div>
    <%--게시글 작성자 아이디와 비교해서 같을 때에만 수정/삭제 버튼을 보여줌--%>
    <c:if test="${article.writer == loginUserId}">
        <div class="d-flex justify-content-end">
            <button onclick="location.href='/article/edit/${id}';" class="btn btn-primary me-1">수정하기</button>
            <button onclick="deleteArticle(${id})" class="btn btn-danger">삭제하기</button>
        </div>
    </c:if>
    <hr/>
    <h4 class="mb-3 fw-bold">댓글(${comments.size()})</h4>
    <c:forEach var="comment" items="${comments}">
        <div id="comment-${comment.id}"
             style="height: 40px;">
            <div class="d-flex justify-content-between align-items-center ms-3">
                <div>
                    <c:if test='${comment.level == 1}'><span
                            style="font-size: 20px; ">↳</span></c:if>
                    <span>${comment.content}</span>
                    <c:if test="${comment.writer == loginUserId}">
                        <span onclick="editComment(${comment.id})" style="cursor: pointer">✏</span>
                        <span onclick="deleteComment(${comment.id})" style="cursor: pointer">🗑</span>
                    </c:if>
                    <c:if test="${comment.level == 0 && loginUserId != null}">
                        <span onclick="replyComment(${comment.id})" style="cursor: pointer">💬</span>
                    </c:if>
                </div>
                <div class="d-flex flex-column align-items-end">
                    <span>작성자: ${comment.writer}</span>
                    <span><fmt:formatDate value="${comment.createdAt}" pattern="yyyy/MM/dd HH:mm"/></span>
                </div>
            </div>
        </div>
        <form onsubmit="editCommentPost(event)">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <input type="hidden" name="id" value="${comment.id}"/>
            <div class="mb-3 input-group" id="comment-edit-${comment.id}" style="display: none; height: 40px;">
                <input class="form-control" placeholder="댓글을 작성해주세요." name="content" value="${comment.content}"/>
                <button class="btn btn-outline-dark">수정하기</button>
            </div>
        </form>
        <form onsubmit="replyCommentPost(event)">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <input type="hidden" name="parentId" value="${comment.id}"/>
            <input type="hidden" name="articleId" value="${article.id}"/>
            <div class="mt-3 ms-3 mb-3 input-group" id="comment-reply-${comment.id}"
                 style="display: none; height: 40px; width: auto">
                <input class="form-control" placeholder="답글을 작성해주세요." name="content"
                       id="comment-reply-${comment.id}-input"/>
                <button class="btn btn-outline-dark">답글달기</button>
            </div>
        </form>
        <hr/>
    </c:forEach>
    <c:if test="${loginUserId != null}">
        <form action="/comment/create" method="post" onsubmit="return checkCommentContent(event)">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <input type="hidden" name="id" value="${article.id}"/>
            <div class="mb-3 input-group">
                <input class="form-control" placeholder="댓글을 작성해주세요." name="content"/>
                <button class="btn btn-outline-dark">댓글 작성</button>
            </div>
        </form>
    </c:if>
    <c:if test="${loginUserId == null}">
        댓글을 작성하려면 <a href="/user/login">로그인</a> 해주세요
    </c:if>
    <div class="d-flex justify-content-end">
        <a href="javascript:void(0)" onclick="goBack()"
           class="link-dark link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover">뒤로가기</a>
    </div>
</div>
<script type="text/javascript">
    const csrfToken = document.getElementsByName('_csrf')[0].value;

    function deleteArticle(id) {
        if (confirm("정말 삭제하시겠습니까?")) {
            $.ajax({
                url: '/article/delete',
                type: "POST",
                data: JSON.stringify({id}),
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-Token': csrfToken,
                },
                success: function () {
                    alert("삭제되었습니다.");
                    location.replace("/article/list");
                },
                error: function (error) {
                    alert("삭제 실패:" + error);
                }
            })
        }
    }

    function deleteComment(id) {
        if (confirm("정말 삭제하시겠습니까?")) {
            $.ajax({
                url: '/comment/delete',
                type: "POST",
                data: JSON.stringify({id}),
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-Token': csrfToken,
                },
                success: function () {
                    alert("삭제되었습니다.");
                    location.reload(true);
                },
                error: function (error) {
                    alert("삭제 실패:" + error);
                }
            })
        }
    }

    function editComment(id) {
        const comment = document.getElementById("comment-" + id);
        const commentInput = document.getElementById("comment-edit-" + id);
        comment.style.display = "none";
        commentInput.style.display = "";
    }

    function editCommentPost(event) {
        event.preventDefault();
        const formData = $(event.target).serialize();
        $.ajax({
            type: "POST",
            url: "/comment/edit/",
            data: formData,
            success: function () {
                location.reload(true);
            },
            error: function (error) {
                console.log(error);
            }
        })
    }

    function replyComment(id) {
        const replyDiv = document.getElementById("comment-reply-" + id);
        const replyInput = document.getElementById("comment-reply-" + id + "-input");
        replyDiv.style.display = "";
        replyInput.focus();
    }

    function replyCommentPost(event) {
        event.preventDefault();
        const formData = $(event.target).serialize();
        $.ajax({
            type: "POST",
            url: "/comment/reply",
            data: formData,
            success: function () {
                location.reload(true);
            },
            error: function (error) {
                console.log(error);
            }
        })
    }

    function goBack() {
        const link = document.referrer;
        if (link.includes('list')) {
            window.history.back();
        } else {
            location.href = "/article/list";
        }
    }

    function checkCommentContent(event) {
        if (event.target.content.value === "") {
            alert("내용을 입력해주세요");
            return false;
        }
        return true;
    }
</script>
</body>
</html>