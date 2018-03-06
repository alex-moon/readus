package com.github.alex_moon.readus;

import org.neo4j.graphdb.GraphDatabaseService;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.data.neo4j.config.EnableNeo4jRepositories;
import org.springframework.data.neo4j.config.Neo4jConfiguration;
import org.springframework.data.neo4j.rest.SpringCypherRestGraphDatabase;
import org.springframework.hateoas.Resource;
import org.springframework.hateoas.ResourceProcessor;

import com.github.alex_moon.readus.entities.Text;
import com.github.alex_moon.readus.resources.processors.TextResourceProcessor;

@SpringBootApplication
@EnableNeo4jRepositories
public class Application extends Neo4jConfiguration {
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

    public Application() {
        setBasePackage("com.github.alex_moon.readus");
    }

    @Bean
    public GraphDatabaseService graphDatabaseService() {
        return new SpringCypherRestGraphDatabase("http://127.0.0.1:7474/db/data", "neo4j", "fuck");
    }

    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(Application.class);
    }
}
