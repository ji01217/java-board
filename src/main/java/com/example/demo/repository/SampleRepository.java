package com.example.demo.repository;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class SampleRepository {

    @Autowired
    SqlSessionTemplate sqlSessionTemplate;

    public List<Map<String, Object>> getSample(){
        return sqlSessionTemplate.selectList("sample.getSample", null);
    }
    public Object add(Map<String, Object> param){
        return sqlSessionTemplate.insert("sample.add", param);
    }

}
