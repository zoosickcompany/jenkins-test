package com.example.demo;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TestController {

  @GetMapping("/test")
  public ResponseEntity<?> test(){
    return ResponseEntity.ok().body("Hello World!");
  }
}
