package com.agenda.vo;

import java.io.Serializable;
import java.util.Calendar;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;
import lombok.Setter;


@Getter @Setter
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



}
