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
			ContatoVO vo = new ContatoVO();
			OperadoraVO opeVo = new OperadoraVO();
			vo.setCodigo(c.getCodigo());
			vo.setNome(c.getNome());
			vo.setData(c.getDataCadastro());
			vo.setTelefone(c.getTelefone());

			opeVo.setCodigo(c.getOperadora().getCodigo());
			opeVo.setNome(c.getOperadora().getNomeOperadora());
			opeVo.setCategoria(c.getOperadora().getCategoria());
			opeVo.setPreco(c.getOperadora().getPreco());
			vo.setOperadora(opeVo);

			lista.add(vo);
		}

		return lista;
	}

	@Override
	public void salvarContato(ContatoVO contato) {
		Contato c = new Contato();
		Operadora o = new Operadora();
		c.setNome(contato.getNome());
		c.setTelefone(contato.getTelefone());
		c.setDataCadastro(contato.getData());
		o.setCodigo(contato.getOperadora().getCodigo());
		c.setOperadora(o);
		
		contatoRepositorio.save(c);
		
	}

	@Override
	public void deletarContatos(List<ContatoVO> contatos) {
		Contato c = new Contato();
		for(ContatoVO contato: contatos) {
			c.setCodigo(contato.getCodigo());
			contatoRepositorio.delete(c);
		}
	}

}
