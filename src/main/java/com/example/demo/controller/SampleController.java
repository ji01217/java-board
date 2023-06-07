package com.example.demo.controller;

import com.example.demo.service.SampleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Controller
public class SampleController {

    @Autowired
    SampleService sampleService;


    @GetMapping("/hi")
    public @ResponseBody String getGreed(){
        return "Hello World";
    }

    @GetMapping("/sample")
    public @ResponseBody
    List<Map<String, Object>> getSampleAll(){
        return sampleService.getSample();
    }

    @PostMapping("/sample")
    public @ResponseBody Object addSample(@RequestParam Map<String, Object> param){
        sampleService.addSample(param);
        return param;
    }

    @RequestMapping("/view")
    public String getView(){
        return "sample";
    }

}
