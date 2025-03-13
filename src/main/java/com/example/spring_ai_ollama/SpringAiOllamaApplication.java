package com.example.spring_ai_ollama;

//import com.example.spring_ai_ollama.service.SQLSchemaLoaderService;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class SpringAiOllamaApplication {

    public static void main(String[] args) {
        SpringApplication.run(SpringAiOllamaApplication.class, args);
        System.out.println("Started Server!!");

    }

}
