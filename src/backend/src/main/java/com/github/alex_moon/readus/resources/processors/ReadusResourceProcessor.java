package com.github.alex_moon.readus.resources.processors;

import org.springframework.data.rest.webmvc.RepositoryLinksResource;
import org.springframework.hateoas.ResourceProcessor;
import org.springframework.hateoas.mvc.ControllerLinkBuilder;
import org.springframework.stereotype.Component;

import com.github.alex_moon.readus.controllers.ReadusController;

@Component
public class ReadusResourceProcessor
    implements ResourceProcessor<RepositoryLinksResource> {

    public RepositoryLinksResource process(RepositoryLinksResource resource) {
        resource.add(
            ControllerLinkBuilder
            .linkTo(ReadusController.class)
            .withRel("readus")
        );
        return resource;
    }
}
