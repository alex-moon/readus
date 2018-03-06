package com.github.alex_moon.readus.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.hateoas.EntityLinks;
import org.springframework.hateoas.ExposesResourceFor;
import org.springframework.hateoas.mvc.ControllerLinkBuilder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.github.alex_moon.readus.entities.Text;
import com.github.alex_moon.readus.repositories.TextRepository;
import com.github.alex_moon.readus.resources.MessageResource;

@RestController
@ExposesResourceFor(Text.class)
@RequestMapping("/readus/texts/")
public class TextController {
    @Autowired
    private TextRepository textRepository;

    @Autowired
    private EntityLinks entityLinks;

    @RequestMapping
    public MessageResource index() {
        MessageResource resource = new MessageResource();
        resource.setMessage("Use this controller to do stuff with texts");
        resource.add(entityLinks.linkToCollectionResource(Text.class));
        return resource;
    }

    @RequestMapping(value = "{id}/tokenize/", method = RequestMethod.POST)
    public Text tokenize(@PathVariable Long id) {
        Text text = textRepository.findOne(id);
        return text;
    }

    @RequestMapping(value = "{id}/tokenize/")
    public MessageResource describeTokenize(@PathVariable Long id) {
        MessageResource result = new MessageResource();
        result.setMessage(
            "Use this endpoint to begin asynchronous tokenisation"
        );
        return result;
    }
}
