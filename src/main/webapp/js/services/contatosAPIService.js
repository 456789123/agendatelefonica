angular.module("listaTelefonica").factory("contatosAPI", function($http, config) {
	var _getContatos = function () {
		return $http.get(config.baseUrl + "/contatos");
	};

	var _saveContato = function (contato) {
		return $http.post(config.baseUrl + "/salvaContato", contato);
	};

	var _deleteContatos = function (contatos) {
		return $http.post(config.baseUrl + "/deleteContatos", contatos);
	};

	var _acionarLed = function(condition) {
	    return $http.post("http://192.168.1.3/LED=" + condition);
	}

	var _lerTemperatura = function() {
	    return $http.get("http://192.168.1.3/TEMP");
	}

	return {
		getContatos:    _getContatos,
		saveContato:    _saveContato,
		deleteContatos: _deleteContatos,
		acionarLed:     _acionarLed,
		lerTemperatura: _lerTemperatura
	};
});