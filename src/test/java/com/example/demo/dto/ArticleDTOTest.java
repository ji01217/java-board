package com.example.demo.dto;

import org.junit.Test;

import static org.hamcrest.core.Is.is;
import static org.junit.Assert.*;

public class ArticleDTOTest {


    @Test
    public void writerArticleReadTest(){
        ArticleDTO article = new ArticleDTO();
        article.setWriter("foo");
        article.setViewCnt(1);

        article.read("foo");
        assertThat("작성자가 조회 시 조회 카운트 미 갱신 테스트", article.getViewCnt(), is(1));
        article.read("bar");
        assertThat("작성자가 조회 시 조회 카운트 미 갱신 테스트", article.getViewCnt(), is(2));

    }

}