package com.example.spring_ai_ollama.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;

@Service
public class ChromaService {

    @Autowired
    private RestTemplate restTemplate;

    // Base URL for your ChromaDB instance (Docker container)
    private final String CHROMA_BASE_URL = "http://localhost:8000/api/v1/collections";

    // Collection ID from your stored collection in ChromaDB
    private final String COLLECTION_ID = "be5c9fa8-9849-4e23-b2dd-8520e8812982";

    public String fetchContext(String userQuery) {
        // Construct the GET request payload.
        // Here you can enhance filtering logic based on userQuery to fetch relevant context.
        Map<String, Object> requestBody = new HashMap<>();
        requestBody.put("ids", null);
        requestBody.put("where", new HashMap<>());
        requestBody.put("where_document", new HashMap<>());
        requestBody.put("limit", 100);
        requestBody.put("offset", 0);
        requestBody.put("include", new String[]{"metadatas", "documents"});

        String url = CHROMA_BASE_URL + "/" + COLLECTION_ID + "/get";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(requestBody, headers);

        ResponseEntity<Map> response = restTemplate.exchange(url, HttpMethod.POST, entity, Map.class);

        // Here, you should parse the response to extract the relevant context.
        // For simplicity, we'll concatenate all document texts.
        StringBuilder contextBuilder = new StringBuilder();
        if (response.getStatusCode() == HttpStatus.OK && response.getBody() != null) {
            // Assuming "documents" key contains a List of strings
            Object docsObj = response.getBody().get("documents");
            if (docsObj instanceof java.util.List) {
                for (Object doc : (java.util.List<?>) docsObj) {
                    contextBuilder.append(doc.toString()).append("\n");
                }
            }
        }
        // You may further enhance context extraction by applying your own filtering/selection logic.
        return contextBuilder.toString();
    }
}
