//package com.example.spring_ai_ollama.service;
//
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.*;
//import org.springframework.stereotype.Service;
//import org.springframework.web.client.RestTemplate;
//
//import java.util.HashMap;
//import java.util.Map;
//
//@Service
//public class LlamaService {
//
//    @Autowired
//    private RestTemplate restTemplate;
//
//    // Llama inference server URL (FastAPI server running locally)
//    private final String LLAMA_URL = "http://localhost:5000/generate";
//
//    public String generateQuery(String context) {
//        // Prepare payload with context
//        Map<String, String> payload = new HashMap<>();
//        // Here, you can adjust your prompt to instruct the LLM for query generation.
//        payload.put("context", "Given the following database schema context, generate an SQL query to answer the question: \n" + context);
//
//        HttpHeaders headers = new HttpHeaders();
//        headers.setContentType(MediaType.APPLICATION_JSON);
//        HttpEntity<Map<String, String>> entity = new HttpEntity<>(payload, headers);
//
//        ResponseEntity<Map> response = restTemplate.postForEntity(LLAMA_URL, entity, Map.class);
//
//        if (response.getStatusCode() == HttpStatus.OK && response.getBody() != null) {
//            // Assuming the inference server returns the result under the "result" key
//            return response.getBody().get("result").toString();
//        }
//        return "No result generated";
//    }
//}
