package com.example.demo.repository;

import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface SampleMapper {
    List<Map<String, Object>> getSample();
    Object add(Map<String, Object> param);
}
