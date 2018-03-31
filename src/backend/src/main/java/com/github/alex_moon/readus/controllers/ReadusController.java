package com.github.alex_moon.readus.controllers;

import org.springframework.hateoas.mvc.ControllerLinkBuilder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.github.alex_moon.readus.resources.MessageResource;

@RestController
@RequestMapping("/readus")
public class ReadusController {
    @RequestMapping("")
    public MessageResource index() {
        MessageResource resource = new MessageResource();
        resource.setMessage("Readus is a social network for text files");
        resource.add(
            ControllerLinkBuilder
            .linkTo(TextController.class)
            .withRel("texts")
        );
        return resource;
    }
}
