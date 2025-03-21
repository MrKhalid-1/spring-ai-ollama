//package com.example.spring_ai_ollama.controller;
//
//import com.example.spring_ai_ollama.service.ChromaService;
//import com.example.spring_ai_ollama.service.LlamaService;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestBody;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RestController;
//
//import java.util.Map;
//
//@RestController
//@RequestMapping("/chat")
//public class QueryController {
//
//    @Autowired
//    private ChromaService chromaService;
//
//    @Autowired
//    private LlamaService llamaService;
//
//    @PostMapping("/ask")
//    public ResponseEntity<?> askQuery(@RequestBody Map<String, Object> requestBody) {
//        String userQuery = requestBody.get("query").toString();
//        String context = chromaService.fetchContext(userQuery);
//        String generatedQuery = llamaService.generateQuery(context);
//        return ResponseEntity.ok(Map.of("generatedQuery", generatedQuery));
//    }
//}
