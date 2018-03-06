package com.github.alex_moon.readus.resources;

import org.springframework.hateoas.ResourceSupport;

public class MessageResource extends ResourceSupport {
    private String message;
    
    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
