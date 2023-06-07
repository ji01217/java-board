<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>통합 JSP 파일</title>
    <%--부트스트랩--%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
</head>
<body>
<%--세션에서 로그인된 유저 아이디를 가져옴--%>
<c:set var="loginUserId" value="${sessionScope.id}"/>
<header>
    <%--네비게이션바--%>
    <nav class="navbar navbar-expand-lg bg-body-tertiary mb-3">
        <div class="container-fluid">
            <a class="navbar-brand" href="/article/list"><img src="http://ajnetworks.co.kr/assets/images/logo2.png"
                                                              alt="logo" height="50"/></a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                    aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="/article/list">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/article/create">Create</a>
                    </li>
                    <c:choose>
                        <c:when test="${loginUserId == null}">
                            <li class="nav-item">
                                <a class="nav-link" href="/user/login">로그인</a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <form id="logoutForm" action="/logout" method="post" style="display:none;">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            </form>
                            <li class="nav-item">
                                <a class="nav-link" href="#" onclick="document.getElementById('logoutForm').submit();">로그아웃</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="/user/profile">프로필</a>
                            </li>
                            <li class="nav-item">
                                <span class="nav-link">${loginUserId}님, 환영합니다.</span>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>
</header>
<script type="text/javascript">
    // 브라우저의 뒤로가기 클릭했을 때 뒤로가면 안되는 페이지 막기
    window.onpageshow = function (event) {
        if (event.persisted || (window.performance && window.performance.navigation.type === 2)) {
            // Back Forward Cache로 브라우저가 로딩될 경우 혹은 브라우저 뒤로가기 했을 경우
            const link = event.currentTarget.location.href;
            if (link.includes('create') || link.includes('edit') || link.includes('signup') || link.includes('login')) {
                location.href = "/article/list";
            }
        }
    }
</script>
<%--jquery--%>
<script src="//code.jquery.com/jquery-3.5.1.min.js"></script>
<%--부트스트랩--%>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"
        integrity="sha384-zYPOMqeu1DAVkHiLqWBUTcbYfZ8osu1Nd6Z89ify25QV9guujx43ITvfi12/QExE"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.min.js"
        integrity="sha384-Y4oOpwW3duJdCWv5ly8SCFYWqFDsfob/3GkgExXKV4idmbt98QcxXYs9UoXAB7BZ"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
        crossorigin="anonymous"></script>
</body>
</html>