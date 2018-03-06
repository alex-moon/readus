package com.github.alex_moon.readus.resources.processors;

import org.springframework.hateoas.Resource;
import org.springframework.hateoas.ResourceProcessor;
import org.springframework.hateoas.mvc.ControllerLinkBuilder;
import org.springframework.stereotype.Component;

import com.github.alex_moon.readus.controllers.TextController;
import com.github.alex_moon.readus.entities.Text;

@Component
public class TextResourceProcessor
    implements ResourceProcessor<Resource<Text>> {
    
    public Resource<Text> process(Resource<Text> resource) {
        return resource;
    }
}
