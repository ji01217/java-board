<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <title>Profile</title>
</head>
<body>
<jsp:include page="../layout.jsp"/>
<div class="container" style="max-width: 800px; line-height: 200%">
    <div class="card p-3 text-center">
        <h1 class="mb-3 fw-bold">프로필</h1>
        <span>아이디: ${user.id}</span>
        <c:if test="${user.name != null}"><span>이름: ${user.name}</span></c:if>
        <span>생년월일: ${user.birth}</span>
        <span>성별: ${user.gender}</span>
        <c:if test="${user.email != null}"><span>이메일: ${user.email}</span></c:if>
        <c:if test="${user.phone != null}"><span>전화번호: ${user.phone}</span></c:if>
        <div class="d-flex justify-content-center align-items-end">
            <a href="/user/edit">회원정보 수정</a>
            <button class="btn btn-danger ms-3" data-bs-toggle="modal" data-bs-target="#modalBackground">회원 탈퇴</button>
        </div>
    </div>
    <!-- 회원탈퇴 Modal -->
    <div class="modal fade" id="modalBackground" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="exampleModalLabel">비밀번호 입력</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form onsubmit="signOut(event)">
                    <div class="modal-body">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <div class="mb-3">
                            <label for="password" class="form-label">비밀번호</label>
                            <input type="password" id="password" name="password" class="form-control"/>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                        <button type="submit" class="btn btn-danger">회원 탈퇴</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
    function signOut(event) {
        event.preventDefault();
        const password = document.getElementById("password").value;

        if (password == "") {
            alert("비밀번호를 입력해주세요.");
            return false;
        }
        const formData = $(event.target).serialize();
        $.ajax({
            type: "POST",
            url: "/user/signout",
            data: formData,
            success: function () {
                alert("탈퇴가 완료되었습니다.")
                location.href = "/user/login";
            },
            error: function (error) {
                alert(error.message);
            }
        })
    }
</script>
</body>
</html>
