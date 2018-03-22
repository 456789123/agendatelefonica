package com.agenda.model;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.agenda.vo.OperadoraVO;

import lombok.Getter;
import lombok.Setter;


@Getter @Setter

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

	public Operadora( ) { }

	public Operadora( OperadoraVO vo ) {
		
		this.codigo        = vo.getCodigo( );
		this.nomeOperadora = vo.getNome( );
		this.categoria     = vo.getCategoria( );
		this.preco         = vo.getPreco( );
		
	}

}
