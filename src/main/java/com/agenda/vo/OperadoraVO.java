package com.agenda.vo;

import java.io.Serializable;
import java.math.BigDecimal;

import com.agenda.model.Operadora;
import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;
import lombok.Setter;


@Getter @Setter
public class OperadoraVO implements Serializable {

	private static final long serialVersionUID = -6743909296281666847L;

	@JsonProperty("codigo")
	private Long codigo;

	@JsonProperty("nome")
	private String nome;

	@JsonProperty("categoria")
	private String categoria;

	@JsonProperty("preco")
	private BigDecimal preco;
	
	
	public OperadoraVO( ) {}

	
	public OperadoraVO( Operadora o ) {
		
		this.codigo    = o.getCodigo( );
		this.nome      = o.getNomeOperadora( );
		this.categoria = o.getCategoria( );
		this.preco     = o.getPreco( );
		
	}
}
