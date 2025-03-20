//package com.example.spring_ai_ollama.service;
//
//import org.springframework.stereotype.Service;
//import com.example.spring_ai_ollama.model.QueryRequest;
//import java.io.BufferedReader;
//import java.io.IOException;
//import java.io.InputStreamReader;
//
//@Service
//public class AIService {
//    private static final String OLLAMA_MODEL = "llama3";
//
//    public String generateSQL(QueryRequest request) {
//        try {
//            ProcessBuilder builder = new ProcessBuilder(
//                    "ollama", "run", OLLAMA_MODEL,
//                    "Generate an SQL query for: " + request.getQuestion()
//            );
//
//            builder.redirectErrorStream(true);
//            Process process = builder.start();
//
//            BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
//            StringBuilder response = new StringBuilder();
//            String line;
//
//            while ((line = reader.readLine()) != null) {
//                response.append(line).append("\n");
//            }
//
//            process.waitFor();
//            return response.toString().trim();
//        } catch (IOException | InterruptedException e) {
//            return "Error generating query: " + e.getMessage();
//        }
//    }
//}
