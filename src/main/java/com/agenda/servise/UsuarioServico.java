package com.agenda.servise;

import java.util.List;

import org.springframework.security.core.userdetails.UserDetailsService;

import com.agenda.vo.UsuarioLoginVO;

public interface UsuarioServico extends UserDetailsService {

	UsuarioLoginVO usuario( String username );
	UsuarioLoginVO usuario( long id );
	List<UsuarioLoginVO> listarusuaruios( );
	void deletarContatos( long id );

}
