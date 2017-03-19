package com.agenda.model;

import java.io.Serializable;
import java.util.Calendar;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity
@Table(name="TB_CONTATO")
@SequenceGenerator( name = "co_seq_contato", sequenceName = "co_seq_contato", allocationSize = 1, initialValue = 1)
public class Contato implements Serializable {

	private static final long serialVersionUID = 514248256155199285L;

	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator = "co_seq_contato" )
	@Column(name="COD_SEQ_CONTATO")
	private Long codigo;

	@Column(name="NO_CONTATO")
	private String nome;

	@Column(name="TELEFONE")
	private String telefone;

	@Column(name="DATA_CADASTRO")
	private Calendar dataCadastro;

	@ManyToOne( fetch = FetchType.LAZY )
	@JoinColumn(name="COD_OPERADORA")
	private Operadora operadora;



	public Long getCodigo() {
		return codigo;
	}
	public String getNome() {
		return nome;
	}
	public String getTelefone() {
		return telefone;
	}
	public Calendar getDataCadastro() {
		return dataCadastro;
	}
	public void setCodigo(Long codigo) {
		this.codigo = codigo;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public void setTelefone(String telefone) {
		this.telefone = telefone;
	}
	public void setDataCadastro(Calendar dataCadastro) {
		this.dataCadastro = dataCadastro;
	}
	public Operadora getOperadora() {
		return operadora;
	}
	public void setOperadora(Operadora operadora) {
		this.operadora = operadora;
	}

	

}
