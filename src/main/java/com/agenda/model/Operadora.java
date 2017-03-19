package com.agenda.model;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="TB_OPERADORA")
public class Operadora implements Serializable {

	private static final long serialVersionUID = -3077891172753340003L;

	@Id
	@Column(name="COD_OPERADORA")
	private Long codigo;

	@Column(name="NO_OPERADORA")
	private String nomeOperadora;

	@Column(name="CATEGORIA")
	private String categoria;

	@Column(name="PRECO")
	private BigDecimal preco;


	public Long getCodigo() {
		return codigo;
	}
	public String getNomeOperadora() {
		return nomeOperadora;
	}
	public String getCategoria() {
		return categoria;
	}
	public void setCodigo(Long codigo) {
		this.codigo = codigo;
	}
	public void setNomeOperadora(String nomeOperadora) {
		this.nomeOperadora = nomeOperadora;
	}
	public void setCategoria(String categoria) {
		this.categoria = categoria;
	}
	public BigDecimal getPreco() {
		return preco;
	}
	public void setPreco(BigDecimal preco) {
		this.preco = preco;
	}


}
