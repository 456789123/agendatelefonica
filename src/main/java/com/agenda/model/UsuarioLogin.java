package com.agenda.model;

import java.util.Calendar;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.springframework.security.core.GrantedAuthority;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter

@Entity
@Table(name="TB_USUARIO_LOGIN")
@SequenceGenerator( name = "cod_seq_usuario", sequenceName = "cod_seq_usuario", allocationSize = 1, initialValue = 1)
public class UsuarioLogin implements GrantedAuthority {


	private static final long serialVersionUID = -9014242407665946429L;

	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator = "cod_seq_usuario" )
	@Column(name="ID")
	private Long id;

	@Column(name="NOME")
	private String username;

	@Column(name="SOBRENOME")
	private String sobrenome;

	@Column(name="EMAIL")
	private String email;

	@Column(name="USUARIO")
	private String usuario;

	@Column(name="SENHA")
	private String password;

	@Column(name="DATA_CADASTRO")
	private Calendar dataCadastro;

	@Column(name="DATA_ULTIMO_LOGIN")
	private Calendar dataUltimoLogin;

	@Column(name="ATIVADO")
	private String ativado;

	@Override
	public String getAuthority() {
		return this.username;
	}
}
