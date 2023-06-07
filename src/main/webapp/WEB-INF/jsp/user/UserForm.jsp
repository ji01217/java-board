<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <title>회원가입</title>
</head>
<body>
<jsp:include page="../layout.jsp"/>
<div class="container" style="max-width: 800px;">
    <h1 class="mb-3 fw-bold">${purpose}</h1>
    <hr/>
    <form onsubmit="userPost(event)">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <div class="mb-3">
            <label for="id" class="form-label">아이디</label>
            <input type="text" id="id" name="id" oninput="onIdChange()" class="form-control mb-1" value="${user.id}"/>
            <div class="d-grid">
                <button type="button" onclick="checkDuplicateId()" id="id_btn" disabled
                        class="btn btn-outline-secondary">아이디 중복 확인
                </button>
            </div>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">비밀번호</label>
            <input type="password" id="password" name="password" class="form-control"/>
        </div>
        <div class="mb-3">
            <label for="password_check" class="form-label">비밀번호 확인</label>
            <input type="password" id="password_check" name="password_check" class="form-control"/>
        </div>
        <div class="mb-3">
            <label for="name" class="form-label">이름</label>
            <input type="text" id="name" name="name" class="form-control" value="${user.name}"/>
        </div>
        <div class="mb-3">
            <label for="email" class="form-label">이메일</label>
            <input type="text" id="email" name="email" class="form-control" value="${user.email}"/>
        </div>
        <div class="mb-3">
            <label for="phone" class="form-label">전화번호(ex. 010-1234-1234)</label>
            <input type="text" id="phone" name="phone" class="form-control" value="${user.phone}"/>
        </div>
        <div class="mb-3">
            <label for="birth" class="form-label">생년월일</label>
            <input type="date" id="birth" name="birth" class="form-control" value="${user.birth}"/>
        </div>
        <div class="mb-3">
            <div class="form-label">성별</div>
            <div class="form-check">
                <input type="radio" id="여" name="gender" value="여" checked
                       class="form-check-input"/><label for="여"
                                                        class="form-check-label">여자</label>
            </div>
            <div class="form-check">
                <input type="radio" id="남" name="gender" value="남"
                       class="form-check-input"/><label for="남"
                                                        class="form-check-label">남자</label>
            </div>
        </div>
        <div class="d-grid">
            <button type="submit" class="btn btn-primary">${purpose}</button>
        </div>
    </form>
</div>
<script>
    if ("${purpose}" === "회원정보수정") {
        console.log("실행");
        document.getElementById("id").setAttribute("disabled", "true");
        document.getElementById("${user.gender}").checked = true;
    }

    function checkForm() {
        const id = document.getElementById("id");
        const password = document.getElementById("password").value;
        const password_check = document.getElementById("password_check").value;
        const birth = document.getElementById("birth").value;
        const name = document.getElementById("name").value;
        const email = document.getElementById("email").value;
        const email_check = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
        const phone = document.getElementById("phone").value;
        const phone_check = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}/;

        if (id.value == "") {
            alert("아이디를 입력해주세요.");
            return false;
        }

        if (password == "") {
            alert("비밀번호를 입력해주세요.");
            return false;
        }

        if (password != password_check) {
            alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
            return false;
        }

        if (id.disabled == false) {
            alert("아이디 중복 검사를 진행해주세요.");
            return false;
        }

        if (name == "") {
            alert("이름을 입력해주세요.");
            return false;
        }

        if (email == "") {
            alert("이메일을 입력해주세요.");
            return false;
        }

        if (email_check.test(email) == false) {
            alert("이메일 형식이 올바르지 않습니다.");
            return false;
        }

        if (phone == "") {
            alert("전화번호를 입력해주세요.");
            return false;
        }

        if (phone_check.test(phone) == false) {
            alert("전화번호 형식이 올바르지 않습니다.");
            return false;
        }

        if (birth == "") {
            alert("생년월일을 입력해주세요.");
            return false;
        }

        id.disabled = false;
        return true;
    }

    function onIdChange() {
        const id_btn = document.getElementById("id_btn");
        const id = document.getElementById("id").value;

        if (id == "") {
            id_btn.disabled = true;
        } else {
            id_btn.disabled = false;
        }
    }

    function checkDuplicateId() {
        const id = document.getElementById("id");
        const id_btn = document.getElementById("id_btn");

        // 중복 확인 API 호출
        const url = 'checkDuplicateId/' + id.value;
        fetch(url)
            .then(response => response.json())
            .then(data => {
                if (data == true) {
                    alert("중복된 아이디입니다.");
                    id.value = "";
                    id_btn.disabled = false;
                } else {
                    alert("사용 가능한 아이디입니다.");
                    id_btn.disabled = true;
                    id.disabled = true;
                }
            })
            .catch(error => console.log(error));
    }

    function signupPost(event) {
        // form 데이터를 직렬화하여 변수에 저장
        const formData = $(event.target).serialize();
        // AJAX를 이용하여 form 데이터를 서버로 전송
        $.ajax({
            type: "POST",
            url: "/user/signup",
            data: formData,
            success: function () {
                location.href = "/user/login";
            },
            error: function (error) {
                alert(error.message);
            }
        })
    }

    function editPost(event) {
        // form 데이터를 직렬화하여 변수에 저장
        const formData = $(event.target).serialize();
        // AJAX를 이용하여 form 데이터를 서버로 전송
        $.ajax({
            type: "POST",
            url: "/user/edit",
            data: formData,
            success: function () {
                location.href = "/user/profile";
            },
            error: function (error) {
                alert(error.message);
            }
        });
    }

    function userPost(event) {
        event.preventDefault();
        if (!checkForm()) {
            return;
        }
        if ("${purpose}" == "회원가입") {
            signupPost(event);
        } else {
            editPost(event);
        }

    }
</script>
</body>
</html>