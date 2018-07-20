package com.agenda.servise;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.agenda.model.UsuarioLogin;
import com.agenda.repositorio.UsuarioLoginRepositorio;
import com.agenda.vo.UsuarioLoginVO;

@Service(value="userService")
public class UsuarioServicoImplements implements UsuarioServico {


	@Autowired private UsuarioLoginRepositorio repositorio;

	@Override
	public UsuarioLoginVO usuario( long id ) {
		ModelMapper modelMapper = new ModelMapper();
		return modelMapper.map( repositorio.findOne( id ), new UsuarioLoginVO( ).getClass( ));
	}

	@Override
	public List<UsuarioLoginVO> listarusuaruios() {
		List<UsuarioLoginVO> lista = new ArrayList<>( );
		ModelMapper modelMapper = new ModelMapper();
		for( UsuarioLogin o: repositorio.findAll( )) {
			lista.add( modelMapper.map( o, new UsuarioLoginVO( ).getClass( )));
		}
		return lista;
	}

	@Override
	public void deletarContatos( long id ) {
		repositorio.delete(id);
	}


	@Override
	public UsuarioLoginVO usuario(String nome) {
		ModelMapper modelMapper = new ModelMapper();
		return modelMapper.map( repositorio.buscarUsuario( nome ), UsuarioLoginVO.class );
	}

	private List<SimpleGrantedAuthority> getAuthority() {
		return Arrays.asList(new SimpleGrantedAuthority("ROLE_ADMIN"));
	}

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		UsuarioLogin user = repositorio.buscarUsuario( username );
		if(user == null){
			throw new UsernameNotFoundException("Usuário ou senha invalidos.");
		}
		return new org.springframework.security.core.userdetails.User(user.getUsername(), user.getPassword(), getAuthority());
	}


}
