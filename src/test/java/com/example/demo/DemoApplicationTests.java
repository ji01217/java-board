package com.example.demo;

import com.example.demo.repository.SampleMapper;
import com.example.demo.repository.SampleRepository;
import com.sun.scenario.effect.impl.prism.ps.PPSOneSamplerPeer;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;

import static org.junit.Assert.*;

@RunWith(SpringRunner.class)
@SpringBootTest
public class DemoApplicationTests {

    @Autowired
    SampleRepository sampleRepository;

    @Autowired
    SampleMapper sampleMapper;

    Map<String, Object> sample = new HashMap<>();

    @Before
    public void initSample(){
        sample.put("userName", "foo");
        sampleRepository.add(sample);
    }

    @Test
    public void contextLoads() {
        assertNotNull("repository load test", sampleRepository);
        assertNotNull("mapper load test", sampleMapper);
    }

    @Test
    public void equlasResultTest() {
        assertEquals("mapper's result equlas repository's result test"
                , sampleMapper.getSample().size(), sampleRepository.getSample().size());
    }


    @Test
    public void beforeWorkEveryTimeTest(){
        Map<String, Object> another = new HashMap<>();
        another.put("userName", "bar");
        sampleRepository.add(another);
        assertNotEquals("@Before insert everytime test", 2, sampleMapper.getSample().size());
    }


}
