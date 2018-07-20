package com.agenda.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.oauth2.config.annotation.web.configuration.EnableResourceServer;
import org.springframework.security.oauth2.config.annotation.web.configuration.ResourceServerConfigurerAdapter;
import org.springframework.security.oauth2.config.annotation.web.configurers.ResourceServerSecurityConfigurer;

@Configuration
@EnableResourceServer
public class ResourceServerConfig extends ResourceServerConfigurerAdapter {
	
	static final String RESOURCEIDS = "restservice";

	@Override
	public void configure(ResourceServerSecurityConfigurer resources) {
		resources.resourceId(RESOURCEIDS).stateless(false);
	}


	@Override
	public void configure(HttpSecurity http) throws Exception {
		http.httpBasic()
		.and()
		.authorizeRequests()
		.antMatchers( "/index.html", "/login.html", "/css/**", "/css-geral/**").permitAll()
		.and()
		.logout()
	    .invalidateHttpSession(true)
	    .clearAuthentication(true)
	    .and().authorizeRequests()
	    .antMatchers( HttpMethod.GET, "/usuario/**", "/contatos", "/operadoras" ).hasAnyRole("ADMIN")
	    .anyRequest().denyAll();
	}

}
