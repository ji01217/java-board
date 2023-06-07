<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <title>검색 결과</title>
</head>
<body>
<jsp:include page="../layout.jsp"/>
<div class="container" style="max-width: 800px;">
    <h1 class="mb-3 fw-bold">'${keyword}'에 대한 ${option} 검색 결과</h1>
    <hr/>
    <div class="d-flex justify-content-end">
        <a href="/article/create"
           class="link-dark link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover">글 작성하기</a>
    </div>
    <table class="table table-striped">
        <thead>
        <tr>
            <th scope="col" style="width: 10%">#</th>
            <th scope="col" style="width: 45%">제목</th>
            <th scope="col" style="width: 15%">작성자</th>
            <th scope="col" style="width: 20%">작성일시</th>
            <th scope="col" style="width: 10%">조회수</th>
        </tr>
        </thead>
        <c:forEach var="article" items="${articles}" varStatus="status">
            <tr>
                <th scope="row">${status.count+(nowPage-1)*5}</th>
                <td><a href="/article/${article.id}">${article.title}</a></td>
                <td>${article.writer}</td>
                <td><fmt:formatDate value="${article.createdAt}" pattern="yyyy/MM/dd HH:mm"/></td>
                <td>${article.viewCnt}</td>
            </tr>
        </c:forEach>
        <c:if test="${empty articles}">
            <tr>
                <td colspan="5">
                    검색된 게시글이 없습니다.
                </td>
            </tr>
        </c:if>
        </tbody>
    </table>
    <div class="d-flex justify-content-end">
        <a href="javascript:location.href='/article/list';"
           class="link-dark link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover">목록으로</a>
    </div>
    <c:if test="${pageCnt > 0}">
        <nav aria-label="Page navigation">
            <ul class="pagination justify-content-center">
                <li class="page-item">
                    <a class="page-link"
                       href="/article/list/search?option=${option}&keyword=${keyword}&page=${nowPage-1}"
                       id="previousBtn">
                        <span>&laquo;</span>
                    </a>
                </li>
                <c:forEach var="page" begin="1" end="${pageCnt}">
                    <li class="page-item"><a class="page-link "
                                             href="/article/list/search?option=${option}&keyword=${keyword}&page=${page}"
                                             id="${page}Btn">${page}</a></li>
                </c:forEach>
                <li class="page-item">
                    <a class="page-link"
                       href="/article/list/search?option=${option}&keyword=${keyword}&page=${nowPage+1}"
                       id="nextBtn">
                        <span>&raquo;</span>
                    </a>
                </li>
            </ul>
        </nav>
    </c:if>
    <form class="d-flex m-auto" onsubmit="searchArticle(event)" style="width: 80%;">
        <div class="input-group mb-3 me-3" style="width: 150px;">
            <label for="search_option"></label>
            <select class="form-select" id="search_option">
                <option value="전체">전체</option>
                <option value="제목">제목</option>
                <option value="내용">내용</option>
                <option value="작성자">작성자</option>
            </select>
        </div>
        <div class="input-group mb-3">
            <input type="text" class="form-control" placeholder="검색어를 입력하세요." id="search_keyword"
                   value="${param.keyword}">
            <button class="btn btn-outline-secondary" type="submit" id="search_button">검색</button>
        </div>
    </form>
</div>
<script type="text/javascript">
    const previousBtn = document.getElementById("previousBtn");
    const nextBtn = document.getElementById("nextBtn");
    for (let page = 1; page < ${pageCnt+1}; page++) {
        if (page === ${nowPage}) {
            document.getElementById(page + "Btn").classList.add("active");
        }
    }
    if ("${pageCnt}" != 0 && "${nowPage}" == 1) {
        previousBtn.classList.add("disabled");
    }
    if (${nowPage} == ${pageCnt}) {
        nextBtn.classList.add("disabled");
    }

    function searchArticle(event) {
        event.preventDefault();
        const searchOption = $("#search_option").val();
        let keyword = $("#search_keyword").val();
        if (keyword == "") {
            alert("검색어를 입력해주세요.");
            return;
        }
        location.href = "/article/list/search?option=" + searchOption + "&keyword=" + keyword;
    }

    const searchOption = "${option}";
    const selectElement = document.getElementById("search_option");
    for (let i = 0; i < selectElement.options.length; i++) {
        if (selectElement.options[i].value === searchOption) {
            selectElement.selectedIndex = i;
            break;
        }
    }
</script>
</body>
</html>