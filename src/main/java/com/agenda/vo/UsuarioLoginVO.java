package com.agenda.vo;

import java.io.Serializable;
import java.util.Calendar;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class UsuarioLoginVO implements Serializable {

	private static final long serialVersionUID = -5510338763078357310L;

	private Long id;
	private String username;
	private String sobrenome;
	private String email;
	private String usuario;
	private String password;
	private Calendar dataCadastro;
	private Calendar dataUltimoLogin;
	private String ativado;

}
