package com.agenda.vo;

import java.io.Serializable;
import java.util.Calendar;

import com.fasterxml.jackson.annotation.JsonProperty;

public class ContatoVO implements Serializable {

	private static final long serialVersionUID = 7144056839669386760L;

	@JsonProperty("codigo")
	private Long codigo;

	@JsonProperty("nome")
	private String nome;

	@JsonProperty("telefone")
	private String telefone;

	@JsonProperty("data")
	private Calendar data;

	@JsonProperty("operadora")
	private OperadoraVO operadora;



	public Long getCodigo() {
		return codigo;
	}
	public String getNome() {
		return nome;
	}
	public String getTelefone() {
		return telefone;
	}
	public Calendar getData() {
		return data;
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
	public void setData(Calendar data) {
		this.data = data;
	}
	public OperadoraVO getOperadora() {
		return operadora;
	}
	public void setOperadora(OperadoraVO operadora) {
		this.operadora = operadora;
	}

}
