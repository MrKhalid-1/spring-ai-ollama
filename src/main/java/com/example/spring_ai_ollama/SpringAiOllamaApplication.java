package com.example.spring_ai_ollama;

import org.springframework.ai.chat.client.ChatClient;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class SpringAiOllamaApplication {

    public static void main(String[] args) {
        SpringApplication.run(SpringAiOllamaApplication.class, args);
    }

    @Bean
    public ChatClient chatClient(ChatClient.Builder chatClientBuilder) {
        return chatClientBuilder.build();  // Build and return the ChatClient
    }

    @Bean
    CommandLineRunner runner(ChatClient.Builder chatClientBuilder) {
        return args -> {
            var chatClient = chatClientBuilder.build();
            var response = chatClient.prompt()
                    .user("What is the capital of Germany?")
                    .call()
                    .content();
            System.out.println(response);
        };
    }
}
