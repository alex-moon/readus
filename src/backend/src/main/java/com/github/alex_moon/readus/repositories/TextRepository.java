package com.github.alex_moon.readus.repositories;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

import com.github.alex_moon.readus.entities.Text;

@RepositoryRestResource(collectionResourceRel="texts", path="texts")
public interface TextRepository extends PagingAndSortingRepository<Text, Long> {
    public List<Text> findByUuid(@Param("uuid") String uuid);
}
