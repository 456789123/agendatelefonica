package com.agenda.repositorio;

import org.springframework.data.repository.CrudRepository;

import com.agenda.model.Contato;

public interface ContatoRepositorio extends CrudRepository<Contato, Long> {

}
