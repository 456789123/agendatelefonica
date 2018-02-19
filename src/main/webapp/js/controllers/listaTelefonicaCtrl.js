angular.module("listaTelefonica").controller("listaTelefonicaCtrl", function ($scope, contatosAPI, operadorasAPI, $interval) {
    $scope.contatos = [];
    $scope.operadoras = [];
    $scope.conditionLed = "ON";
    $scope.temperatura = 25.00;

    var carregarContatos = function( ) {
        contatosAPI.getContatos().then(function(success) {
            $scope.contatos = success.data;
        }, function(error){
            console.log("Aconteceu um problema!! Contatos!!");
        });
    };

    var carregarOperadoras = function( ) {
	operadorasAPI.getOperadoras().then(function(response) {
            $scope.operadoras = response.data;
        }, function(error){
            console.log("Aconteceu um problema!! Opeardoras!!");
        });
    };

    $scope.adicionarContato = function (contato) {
        contato.data = new Date();
        contatosAPI.saveContato(contato).then(function(data) {
            delete $scope.contato;
            $scope.contatoForm.$setPristine();
            carregarContatos();
        }, function(error) {
            console.log("Não salvou!!");
        })
    };

    $scope.apagarContatos = function (contatos) {

        var contatos = contatos.filter(function (contato) {
            if(contato.selecionado) return contato;
        });

        contatosAPI.deleteContatos(contatos).then(function(value) {
            carregarContatos();
        }, function(reason) {
            console.log("Não deletou!!");
        })
    };

    $scope.isContatoSelecionado = function (contatos) {
        return contatos.some(function (contato) {
            return contato.selecionado;
        });
    };

    $scope.ordenarPor = function (campo) {
        $scope.criterioDeOrdenacao = campo;
        $scope.direcaoDaOrdenacao = !$scope.direcaoDaOrdenacao;
    };

    $scope.acionarLed = function() {
	if($scope.conditionLed === "OFF")
	    $scope.conditionLed = "ON";
	else
	    $scope.conditionLed = "OFF";
	
	contatosAPI.acionarLed($scope.conditionLed).then(function(success) {
	    
	}, function(error) {
	    console.log("LED não funcionou");
	})
    };

    $interval(function(){
		contatosAPI.lerTemperatura().then(function(success) {
			$scope.temperatura = (success.data.temperature[0]).toFixed(2);
		}, function(error) {
		    console.log("Aconteceu um problema!!");
		})
    }, 3000);

    carregarContatos();
    carregarOperadoras();
});