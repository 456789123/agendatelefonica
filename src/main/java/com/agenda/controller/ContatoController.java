package com.agenda.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.agenda.servise.ContatoService;
import com.agenda.vo.ContatoVO;
import com.fasterxml.jackson.databind.ObjectMapper;

@RestController
public class ContatoController {


	@Autowired
	private ContatoService contatoService;

	@RequestMapping( value = "/contatos", method = RequestMethod.GET )
	public void listaContatos(HttpServletResponse resp) throws ServletException, IOException {
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(contatoService.listaContatos());
		resp.getWriter().write(json);
	}

	@RequestMapping( value = "/salvaContato", method = RequestMethod.POST)
	public void adicionarContato( @RequestBody ContatoVO contato, HttpServletRequest req) throws ServletException, IOException {
		contatoService.salvarContato(contato);
	}

	@RequestMapping( value = "/deleteContatos", method = RequestMethod.POST)
	public void deletarContatos( @RequestBody List<ContatoVO> contatos, HttpServletRequest req) throws ServletException, IOException {
		contatoService.deletarContatos(contatos);
	}

}
