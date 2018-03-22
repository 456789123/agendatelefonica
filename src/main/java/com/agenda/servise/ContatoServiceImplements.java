package com.agenda.servise;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.agenda.model.Contato;
import com.agenda.model.Operadora;
import com.agenda.repositorio.ContatoRepositorio;
import com.agenda.vo.ContatoVO;
import com.agenda.vo.OperadoraVO;

@Service
public class ContatoServiceImplements implements ContatoService {
	
	@Autowired
	private ContatoRepositorio contatoRepositorio;

	@Override
	public List<ContatoVO> listaContatos() {
		List<ContatoVO> lista = new ArrayList<>();
		for(Contato c: contatoRepositorio.findAll()) {
			lista.add(new ContatoVO( c, new OperadoraVO( c.getOperadora( ))));
		}
		return lista;
	}

	@Override
	public void salvarContato(ContatoVO contato) {
		Contato   c = new Contato( contato, new Operadora(contato.getOperadora()));
		contatoRepositorio.save(c);
	}

	@Override
	public void deletarContatos(List<ContatoVO> contatos) {
		for(ContatoVO contato: contatos) {
			contatoRepositorio.delete( new Contato( contato, new Operadora(contato.getOperadora( ))));
		}
	}

}
