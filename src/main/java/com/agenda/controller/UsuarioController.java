package com.agenda.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.agenda.servise.UsuarioServico;
import com.google.gson.Gson;

@RestController
@RequestMapping("/usuario")
public class UsuarioController {

	@Autowired private UsuarioServico servico;


	@RequestMapping( value = "/{nome}", method = RequestMethod.GET )
	public void usuario(@PathVariable("nome") String nome, HttpServletResponse resp ) throws ServletException, IOException {
		Gson gson = new Gson();
		String json = gson.toJson(servico.usuario(nome));
		resp.getWriter().write(json);
	}

}
