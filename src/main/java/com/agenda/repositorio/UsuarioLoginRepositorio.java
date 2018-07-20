package com.agenda.repositorio;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.agenda.model.UsuarioLogin;

public interface UsuarioLoginRepositorio extends JpaRepository< UsuarioLogin, Long > {
	
	@Query(" SELECT user FROM UsuarioLogin user WHERE user.username = :username OR user.email = :username")
	public UsuarioLogin buscarUsuario( @Param("username") String username );

}
