//package com.example.spring_ai_ollama.service;
//
//import org.springframework.stereotype.Service;
//import java.nio.file.Files;
//import java.nio.file.Paths;
//import java.util.List;
//
//@Service
//public class SQLSchemaLoaderService {
//
//    private final FaissEmbeddingStore vectorStore;
//
//    public SQLSchemaLoaderService(FaissEmbeddingStore vectorStore) {
//        this.vectorStore = vectorStore;
//    }
//
//    public void loadSQLSchemaIntoVectorDB(String filePath) throws Exception {
//        List<String> lines = Files.readAllLines(Paths.get(filePath));
//        String schema = String.join("\n", lines);
//
//        // Convert schema to vector representation
//        vectorStore.add("db_schema", schema);
//
//        System.out.println("Database schema loaded into vector store.");
//    }
//}
