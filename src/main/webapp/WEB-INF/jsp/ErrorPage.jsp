<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <title>ErrorPage</title>
</head>
<body>
<h1>잘못된 접근입니다. <img src="https://url.kr/6h92kd" width="50px"/></h1>

<h1>Error code: ${code}</h1>
<h2>Error message: ${msg}</h2>
<h3>Timestamp: ${timestamp}</h3>
<a href="/article/list">돌아가기</a>
</body>
</html>
