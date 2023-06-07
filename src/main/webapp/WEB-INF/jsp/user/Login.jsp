<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <title>로그인</title>
</head>
<body>
<jsp:include page="../layout.jsp"/>
<div class="container" style="max-width: 800px;">
    <h1 class="mb-3 fw-bold">로그인</h1>
    <hr/>
    <form id="login-form">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <div class="mb-3">
            <label for="id" class="form-label">아이디</label>
            <input type="text" id="id" name="id" required class="form-control"/>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">비밀번호</label>
            <input type="password" id="password" name="password" required class="form-control"/>
        </div>
        <div class="mb-3">
            회원이 아니라면? <a href="signup" class="link-opacity-100">회원가입</a>
        </div>
        <div class="d-grid">
            <button type="submit" class="btn btn-primary">로그인</button>
        </div>
    </form>
</div>
<script>
    const loginForm = document.getElementById('login-form');
    const csrfToken = document.getElementsByName('_csrf')[0].value;
    loginForm.addEventListener('submit', login);

    function login(event) {
        event.preventDefault();

        const id = document.getElementById('id').value;
        const password = document.getElementById('password').value;

        fetch('/user/userlogin', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-Token': csrfToken
            },
            body: JSON.stringify({id, password})
        })
            .then(async response => {
                if (!response.ok) {
                    throw new Error(await response.text());
                }
                // 로그인 성공 시 처리
                console.log('로그인 성공');
                location.href = "/article/list"
                return response.text();
            })
            .catch(error => {
                alert(error.message);
            })
    }
</script>
</body>
</html>