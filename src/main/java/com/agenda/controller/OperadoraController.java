package com.agenda.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.agenda.servise.OperadoraService;
import com.fasterxml.jackson.databind.ObjectMapper;

@RestController
public class OperadoraController {
	
	@Autowired
	private OperadoraService operadoraService;

	@RequestMapping( value = "/operadoras")
	public void listaOperadoras(HttpServletResponse resp) throws ServletException, IOException {
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(operadoraService.listaOperadoras());
		resp.getWriter().write(json);
	}

}
