//package com.example.spring_ai_ollama.controller;
//
//import dev.langchain4j.store.embedding.faiss.FaissEmbeddingStore;
//import org.springframework.ai.ollama.OllamaClient;
//import org.springframework.web.bind.annotation.*;
//
//@RestController
//@RequestMapping("/api/chat")
//public class AIChatController {
//
//    private final FaissEmbeddingStore vectorStore;
//    private final OllamaClient ollamaClient;
//
//    public AIChatController(FaissEmbeddingStore vectorStore, OllamaClient ollamaClient) {
//        this.vectorStore = vectorStore;
//        this.ollamaClient = ollamaClient;
//    }
//
//    @PostMapping("/ask")
//    public String askAI(@RequestParam String question) {
//        // Retrieve schema from vector store
//        String schema = vectorStore.toString();
//
//        // Generate SQL query using Ollama
//        String prompt = "Given the database schema:\n" + schema +
//                "\nGenerate an optimized SQL query for: " + question +
//                "\nReturn only the SQL query without explanation.";
//
//        String sqlQuery = ollamaClient.generate(prompt);
//
//        System.out.println("Generated SQL: " + sqlQuery);
//
//        return sqlQuery;
//    }
//}
