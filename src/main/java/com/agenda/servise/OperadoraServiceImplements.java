package com.agenda.servise;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.agenda.model.Operadora;
import com.agenda.repositorio.OperadoraRepositorio;
import com.agenda.vo.OperadoraVO;

@Service
public class OperadoraServiceImplements implements OperadoraService {

	@Autowired
	private OperadoraRepositorio operadoraRepositorio;
	
	@Override
	public List<OperadoraVO> listaOperadoras() {
		List<OperadoraVO> lista = new ArrayList<>();

		for(Operadora o: operadoraRepositorio.findAll()) {
			lista.add( new OperadoraVO( o ) );
		}

		return lista;
	}

}
