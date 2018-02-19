package com.agenda.servise;

import java.util.List;

import com.agenda.vo.ContatoVO;

public interface ContatoService {

	List<ContatoVO> listaContatos();
	void salvarContato(ContatoVO contato);
	void deletarContatos(List<ContatoVO> contatos);

}
