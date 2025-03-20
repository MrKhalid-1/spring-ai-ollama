package com.example.spring_ai_ollama.controller;

//import org.springframework.ai.chat.ChatClient;

import org.springframework.ai.chat.client.ChatClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/chat")
public class ChatController {

    private final ChatClient chatClient;
//    private final JdbcTemplate jdbcTemplate;
            
    @Autowired
    public ChatController(ChatClient chatClient) {
        this.chatClient = chatClient;
    }

    @GetMapping("/generate")
    public String generateSQL(@RequestParam String question) {

        String TABLE_INFO = """
        Database Schema:
        - base_unit (id, name, description, company_id, created_by, updated_by, create_time, update_time)
        - companies (id, name, mobile, email, address, logo, business_type, status, created_by, updated_by, create_time, update_time)
        - order_items (id, order_id, product_id, product_code, name, quantity, unit_price, total_price, created_by, updated_by, create_time, update_time)
        - orders (id, total_amount, status, comment, retailer_id, retailer_company_id, wholesaler_company_id, added_by, modify_by, order_der_date, order_der_time, created_by, updated_by, create_time, update_time)
        - payments (id, payment_method, amount, payment_date, comment, received_by, modify_by, retailer_id, retailer_company_id, wholesaler_company_id, created_by, updated_by, create_time, update_time)
        - product_categories (id, name, description, parent_id, company_id, created_by, updated_by, create_time, update_time)
        - products (id, code, description, category_id, pack_size, item_Name, current_Stock, stock_Limit, buy_Price, sell_Price, profit, base_unit, tax_type, token, company_id, created_by, updated_by, create_time, update_time)
        - user_roles (id, user_id, role, company_id, created_by, updated_by, create_time, update_time)
        - users (id, name, email, password, mobile, status, created_by, updated_by, create_time, update_time)

        Relationships:
        - base_unit.company_id -> companies.id (Foreign Key)
        - order_items.order_id -> orders.id (Foreign Key)
        - order_items.product_id -> products.id (Foreign Key)
        - orders.retailer_id -> users.id (Foreign Key)
        - orders.retailer_company_id -> companies.id (Foreign Key)
        - orders.wholesaler_company_id -> companies.id (Foreign Key)
        - payments.retailer_id -> users.id (Foreign Key)
        - payments.retailer_company_id -> companies.id (Foreign Key)
        - payments.wholesaler_company_id -> companies.id (Foreign Key)
        - product_categories.company_id -> companies.id (Foreign Key)
        - products.category_id -> product_categories.id (Foreign Key)
        - products.company_id -> companies.id (Foreign Key)
        - products.base_unit -> base_unit.id (Foreign Key)
        - user_roles.user_id -> users.id (Foreign Key)
        - user_roles.company_id -> companies.id (Foreign Key)
        """;

        String prompt = "Based on this database schema:\n" + TABLE_INFO + "\nConvert this question into an SQL query:\n" + question;

        return chatClient.prompt()
                .user(prompt)
                .call()
                .content();
    }

    @GetMapping("/ask")
    public String askQuestion(@RequestParam String question) {
        return chatClient.prompt()
                .user(question)
                .call()
                .content();
    }
}

