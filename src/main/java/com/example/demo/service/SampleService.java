package com.example.demo.service;

import com.example.demo.repository.SampleMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service("sampleService")
public class SampleService {

    @Autowired
    SampleMapper sampleMapper;

    /*
        Spring 최신 버전에서는 autowired 를 이용한 di 보다는 생성자를 이용한 di 를 추천하고는 있음
     */
    /*
    public SampleService(SampleRepository sampleRepository) {
        this.sampleRepository = sampleRepository;
    }
     */
    public List<Map<String, Object>> getSample() {
        return sampleMapper.getSample();
    }

    public Object addSample(Map<String, Object> param) {
        return sampleMapper.add(param);
    }
}
