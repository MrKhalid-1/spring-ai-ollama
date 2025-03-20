//package com.example.spring_ai_ollama.config;
//
//import com.example.spring_ai_ollama.service.SQLSchemaLoaderService;
//import jakarta.annotation.PostConstruct;
//import org.springframework.stereotype.Component;
//
//@Component
//public class SchemaLoaderRunner {
//
//    private final SQLSchemaLoaderService schemaLoaderService;
//
//    public SchemaLoaderRunner(SQLSchemaLoaderService schemaLoaderService) {
//        this.schemaLoaderService = schemaLoaderService;
//    }
//
//    @PostConstruct
//    public void loadSchema() throws Exception {
//        schemaLoaderService.loadSQLSchemaIntoVectorDB("C:/supermarket_db.sql");
//    }
//}
//
//
