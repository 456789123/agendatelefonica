#!/bin/sh

###################################################################
# Versao            : 0.0-11  (13/07/2007)                        #
# Sistema           : Asterisk VoIP p/ telecentros                #
# Criado por        : Charles Junqueira,Antonio Carlos Vianna     # 
# Data              : 03/06/2007                                  #
# Modificado por    : Charles Junqueira                           # 
# Data              : 13/07/2007                                  #
#                                                                 # 
###################################################################

clear

###########verifica qual janela gráfica vai usar###########
if [ -e /usr/bin/Xdialog ] ; then
	arquivox=Xdialog
   tamx="28 70 0" #qual o tamanho da tela
elif [ -e /usr/bin/dialog ] ; then
	arquivox=dialog
   tamx="10 80 0"
else 
    echo -n "Voce tem que instalar o pacote dialog ou xdialog"
    exit 0
fi	  

function menu_principal(){
if [ $arquivox = "Xdialog" ];then
entra=`$arquivox --stdout --title "Instalar Servidor Asterisk" \
--backtitle "Escolha uma opcao abaixo" \
-radiolist "Este Menu tem como objetivo ajudar a \n \
  instalar o servidor voip  \n 
" $tamx \
"Asterisk" "Instalar o Servidor Asterisk." on \
"Sair" "Sair sem instalar" off`
else
	entra=`$arquivox --stdout --title "Instalar Servidor Asterisk" \
	--backtitle " Escolha uma opcao abaixo " \
--radiolist "   Este Menu tem como objetivo ajudar a instalar o \n \
  Servidor VoIP. \n 
" $tamx \
"Asterisk" "Instalar o Servidor Asterisk" on \
"Sair" "Sair sem instalar" off`
fi	
 
retvalprincipal=$? 

entrar=`echo $entra | sed '1!d'`

if [ $retvalprincipal = 0 ];then   
	if [ "$entrar" != "Sair" ];then  
	   #servidor_voip
	    finaliza_config
	elif [ $entrar = "Sair" ];then  
	   exit 0
	fi   
elif [ $retvalprincipal = 1 ];then  
  exit 0
elif [ $retvalprincipal = 255 ];then
  exit 0
fi


}

function servidor_voip(){
 
 $arquivox --yesno "Deseja configurar um servico VoIP(ex:vono.net.br) externo?" 5 60 

 if [ $? -eq 1 ];then
     FLAG=0
     cadastra_servidor
 else
     FLAG=1
     if [ $arquivox = "Xdialog" ];then
 	SERVICOVOIP=$( $arquivox --stdout --no-cancel --title "Servico VoIP" --backtitle "Ex: vono.net.br"  \
      --inputbox "Digite o endereco do seu servico VoIP" 0 0 ) 
     else 
  	SERVICOVOIP=$( $arquivox --stdout --no-cancel --title "Servico VoIP" --backtitle "Ex: vono.net.br" \
  	--inputbox "Digite o endereco do seu servico VoIP" -1 -1 )
     fi 

 SERVICOVOIP=$( echo $SERVICOVOIP | sed '1!d' )
 fi

 #verifica se enderelo do servico não está em branco
 while [ -z $SERVICOVOIP ]; do  
    $arquivox --title "Servico VoIP" --backtitle "Ex: vono.net.br" \
 		   --msgbox "servico incorreto. nome do servico não pode ser em branco" 0 0  
    if [ $arquivox = "Xdialog" ];then
 	SERVICOVOIP=$( $arquivox --stdout --no-cancel --title "Servico VoIP" --backtitle "Ex: vono.net.br"  \
      --inputbox "Digite o endereco do seu servico VoIP" 0 0 ) 
    else 
  	SERVICOVOIP=$( $arquivox --stdout --no-cancel --title "Servico VoIP" --backtitle "Ex: vono.net.br" \
  	--inputbox "Digite o endereco do seu servico VoIP" -1 -1 )
    fi 
 done     

 SERVICOVOIP=$( echo $SERVICOVOIP | sed '1!d' )
 ip_servidor 


}

function login_servico(){
    if [ $arquivox = "Xdialog" ];then
 	  	login=$( $arquivox --stdout --no-cancel --title "Login do Servico VoIP" --password --password \
      --3inputsbox "" 0 0 \
      "Digite o login do Servico VoIP" "" "Digite sua senha " "" "Redigite a senha" "" )  
      
     	loginusuario=$( echo $login | cut -d/ -f1 )
     	senhausuario=$( echo $login | cut -d/ -f2 )
        senhausuario2=$( echo $login | cut -d/ -f3 )

    else
     	login=$( $arquivox --stdout --title "Login do Servico VoIP" --backtitle "Asterisk" --nocancel \
	   --inputbox "Digite o login do servico VoIP" 0 0 )
	 
		senhausu=$( $arquivox --stdout --insecure --title " Senha \
do Servico VoIP" --backtitle "Asterisk"\
 --nocancel \
           --passwordbox "Digite sua senha" 0 0)
           
		senhausu2=$( $arquivox --stdout --insecure --title "Senha \
do Servico VoIP" --backtitle "Asterisk"\
 --nocancel \
           --passwordbox "redigite sua senha" 0 0)           
	
		loginusuario=$( echo $login )
	  	senhausuario=$( echo $senhausu )
                senhausuario2=$( echo $senhausu2 )
      
    fi 	 
      #verifica se o login não está em branco
      if [ -z $loginusuario ] ||  [ -z $senhausuario ] || [ -z $senhausuario2 ];then
	  verifica_login_senha
      fi	  
ramais_externos_internos
#cadastra_servidor
#finaliza_config
}

function verifica_login_senha(){
     while [ -z $loginusuario ] || [ -z $senhausuario ] || [ -z $senhausuario2 ]; do  
          $arquivox --title "Servico VoIP" --backtitle "Asterisk" \
 		   --msgbox "campos não podem ser em branco" 0 0  
 	    if [ $arquivox = "Xdialog" ];then
 	  	login=$( $arquivox --stdout --no-cancel --title "Login do Servico VoIP" --password --password \
      --3inputsbox "" 0 0 \
      "Digite o login do Servico VoIP" "" "Digite sua senha " "" "Redigite a senha" "" )  
      
     	loginusuario=$( echo $login | cut -d/ -f1 )
     	senhausuario=$( echo $login | cut -d/ -f2 )
        senhausuario2=$( echo $login | cut -d/ -f3 )

    else
     	login=$( $arquivox --stdout --title "Login do Servico VoIP" --backtitle "Asterisk" --nocancel \
	   --inputbox "Digite o login do servico VoIP" 0 0 )
	 
		senhausu=$( $arquivox --stdout --insecure --title " Senha \
do Servico VoIP" --backtitle "Asterisk"\
 --nocancel \
           --passwordbox "Digite sua senha" 0 0)
           
		senhausu2=$( $arquivox --stdout --insecure --title "Senha \
do Servico VoIP" --backtitle "Asterisk"\
 --nocancel \
           --passwordbox "redigite sua senha" 0 0)           
	
		loginusuario=$( echo $login )
	  	senhausuario=$( echo $senhausu )
        senhausuario2=$( echo $senhausu2 )
      
    fi 	 	   

      done

}

function ip_servidor(){
 if [ $arquivox = "Xdialog" ];then
 	IP=$( $arquivox --stdout --no-cancel --title "IP do Asterisk" --backtitle ""  \
      --inputbox "Digite o endereco IP do servidor Asterisk " 0 0 ) 
 else 
  	IP=$( $arquivox --stdout --no-cancel --title "IP do Asterisk" --backtitle "" \
  	--inputbox "Digite o endereco IP do servidor Asterisk" -1 -1 )
 fi 

 IP=$( echo $IP | sed '1!d' )
 #verifica se o IP não está em branco
 while [ -z $IP ]; do  

    $arquivox --title "IP do Asterisk" --backtitle "" \
 		   --msgbox "IP incorreto. IP não pode ser em branco" 0 0  
 if [ $arquivox = "Xdialog" ];then
 	IP=$( $arquivox --stdout --no-cancel --title "IP do Asterisk" --backtitle ""  \
      --inputbox "Digite o endereco IP do servidor Asterisk " 0 0 ) 
 else 
  	IP=$( $arquivox --stdout --no-cancel --title "IP do Asterisk" --backtitle "" \
  	--inputbox "Digite o endereco IP do servidor Asterisk" -1 -1 )
 fi 
 done     
 IP=$( echo $IP | sed '1!d' )
 login_servico

}

#configura os ramais internos e externos
function ramais_externos_internos(){


ARR_RAMAIS=( "101" "102" "103" "104" "105" "106" "107" "108" "109" "110" )
TOTAL_ARR_RAMAIS=$((${#ARR_RAMAIS[@]}-1))
DIALOG=Xdialog

for (( I = 0; I <= $TOTAL_ARR_RAMAIS; I++ ));do
    NOME_RAMAL="Ramal"${ARR_RAMAIS[$I]}

    RECEBE_ARQUIVOS=`echo ${ARR_RAMAIS[$I]}|awk '{ printf " %s '${NOME_RAMAL}' 'off' ", $0, $0}'`
    BOX_ARQUIVOS=${BOX_ARQUIVOS}${RECEBE_ARQUIVOS}
done

FILES=$( $DIALOG  --title "selecione os ramais que efetuarao chamadas externas" --backtitle "" --stdout --separator "|" --checklist ""  30 40 11 $BOX_ARQUIVOS )


FILES=$FILES"|"

TOTAL_COLUNAS=`echo ${FILES}|awk -F "|" '{ print NF }'`
TOTAL_COLUNAS=$((TOTAL_COLUNAS-1))

j=1

for ((  I=0 ; I <= $TOTAL_ARR_RAMAIS; I++ ));do
       INTERNO1=${ARR_RAMAIS[$I]}
       EXTERNO=`echo ${FILES}|awk -F "|" '{ print $'${j}' }'`

       if [ "$EXTERNO" != "$INTERNO1" ];then
        INTERNO=$INTERNO"|"$INTERNO1
       else
           j=$(( j+1 ))
       fi
done
#liga e recebe ligacoes externas
EXTERNO=$FILES
#so recebe ligacoes externas
INTERNO=$INTERNO

cadastra_servidor
}

function cadastra_servidor(){
    
########adiciona as linhas do servico voip no arquivo sip.conf#############################################################
    echo -e "[general]" > /etc/asterisk/sip.conf
    echo -e "language=pt_BR" >> /etc/asterisk/sip.conf
    if [ ${FLAG} -eq 1 ];then
	echo -e "register=${loginusuario}:${senhausuario}@${SERVICOVOIP}:5060/${loginusuario}" >> /etc/asterisk/sip.conf
    fi

    echo -e "bindport=5060" >> /etc/asterisk/sip.conf
    echo -e "bindaddr=0.0.0.0" >> /etc/asterisk/sip.conf
    echo -e "localnet=10.0.0.0/24" >> /etc/asterisk/sip.conf
    echo -e "realm=${IP}" >> /etc/asterisk/sip.conf
    echo -e "srvlookup=yes" >> /etc/asterisk/sip.conf
    echo -e "tos=lowdelay|thrpighput|reliability|mincost|none" >> /etc/asterisk/sip.conf
    echo -e " " >> /etc/asterisk/sip.conf
    
    if [ ${FLAG} -eq 1 ];then
	echo -e "[${loginusuario}]" >> /etc/asterisk/sip.conf
	echo -e "type=peer" >> /etc/asterisk/sip.conf
	echo -e "username=${loginusuario}" >> /etc/asterisk/sip.conf
	echo -e "secret=${senhausuario}" >> /etc/asterisk/sip.conf
	echo -e "fromuser=${loginusuario}" >> /etc/asterisk/sip.conf
	echo -e "fromdomain=${SERVICOVOIP}" >> /etc/asterisk/sip.conf
	echo -e "context=gvt" >> /etc/asterisk/sip.conf
	echo -e "disallow=all" >> /etc/asterisk/sip.conf
	echo -e "allow=gsm" >> /etc/asterisk/sip.conf
	echo -e "allow=alaw" >> /etc/asterisk/sip.conf
	echo -e "allow=ilbc" >> /etc/asterisk/sip.conf
	echo -e "allow=ulaw" >> /etc/asterisk/sip.conf
	echo -e "host=${SERVICOVOIP}" >> /etc/asterisk/sip.conf
	echo -e "insecure=very" >> /etc/asterisk/sip.conf
	echo -e "qualify=no" >> /etc/asterisk/sip.conf
	echo -e "port=5060" >> /etc/asterisk/sip.conf
	echo -e "aut=md5" >> /etc/asterisk/sip.conf
	echo -e "nat=yes" >> /etc/asterisk/sip.conf
	echo -e "canreinvite=no" >> /etc/asterisk/sip.conf
	echo -e "dtmfmode=rfc2833" >> /etc/asterisk/sip.conf
	echo -e " " >> /etc/asterisk/sip.conf
    fi



  #ramais externos
if [ ${FLAG} -eq 1 ];then
 TOTAL_EXTERNO=`echo ${EXTERNO}|awk -F "|" '{ print NF }'`
 TOTAL_EXTERNO=$((TOTAL_EXTERNO-1))
 for ((  I=1 ; I <= $TOTAL_EXTERNO; I++ ));do
        REXTERNO=`echo ${EXTERNO}|awk -F "|" '{ print $'${I}' }'`
        RAMALMD5=`echo -n "${REXTERNO}:${IP}:debian"| md5sum | cut -f1 -d' '`
        echo -e "[${REXTERNO}]" >> /etc/asterisk/sip.conf
        echo -e "username=${REXTERNO}" >> /etc/asterisk/sip.conf
#    if [ ${FLAG} -eq 1 ];then
#        echo -e "md5secret=${RAMALMD5}" >> /etc/asterisk/sip.conf
#    else
        echo -e "secret=debian" >> /etc/asterisk/sip.conf
#    fi
        echo -e "host=dynamic" >> /etc/asterisk/sip.conf
        echo -e "type=friend" >> /etc/asterisk/sip.conf
        echo -e "callerid=ramal ${REXTERNO}<${REXTERNO}>" >> /etc/asterisk/sip.conf
        echo -e "context=externo" >> /etc/asterisk/sip.conf
        echo -e "disallow=all" >> /etc/asterisk/sip.conf
        echo -e "allow=gsm" >> /etc/asterisk/sip.conf
        echo -e "allow=ulaw" >> /etc/asterisk/sip.conf
        echo -e "allow=ilbc" >> /etc/asterisk/sip.conf
	echo -e "canreinvite=no" >> /etc/asterisk/sip.conf
        echo -e " " >> /etc/asterisk/sip.conf
 done
	echo -e ";novoramalexterno" >> /etc/asterisk/sip.conf
fi

 #ramais internos

if [ ${FLAG} -eq 1 ];then
 TOTAL_INTERNO=`echo ${INTERNO}|awk -F "|" '{ print NF }'`
 TOTAL_INTERNO=$((TOTAL_INTERNO-1))
 for ((  I=2 ; I <= $TOTAL_INTERNO+1; I++ ));do
        RINTERNO=`echo ${INTERNO}|awk -F "|" '{ print $'${I}' }'`
        RAMALMD5=`echo -n "${RINTERNO}:${IP}:debian"| md5sum | cut -f1 -d' '`
	echo -e "[${RINTERNO}]" >> /etc/asterisk/sip.conf
	echo -e "username=${RINTERNO}" >> /etc/asterisk/sip.conf
#    if [ ${FLAG} -eq 1 ];then
#	echo -e "md5secret=${RAMALMD5}" >> /etc/asterisk/sip.conf
#    else
	echo -e "secret=debian" >> /etc/asterisk/sip.conf
#    fi
	echo -e "host=dynamic" >> /etc/asterisk/sip.conf
	echo -e "type=friend" >> /etc/asterisk/sip.conf
	echo -e "callerid=ramal ${RINTERNO}<${RINTERNO}>" >> /etc/asterisk/sip.conf
	echo -e "context=interno" >> /etc/asterisk/sip.conf
	echo -e "disallow=all" >> /etc/asterisk/sip.conf
	echo -e "allow=gsm" >> /etc/asterisk/sip.conf
	echo -e "allow=ulaw" >> /etc/asterisk/sip.conf
	echo -e "allow=ilbc" >> /etc/asterisk/sip.conf
	echo -e "canreinvite=no" >> /etc/asterisk/sip.conf
	echo -e " " >> /etc/asterisk/sip.conf

 done   
	echo -e ";novoramalinterno" >> /etc/asterisk/sip.conf
else
 for ((  I=101 ; I <= $110; I++ ));do
	echo -e "[${I}]" >> /etc/asterisk/sip.conf
	echo -e "username=${I}" >> /etc/asterisk/sip.conf
	echo -e "secret=debian" >> /etc/asterisk/sip.conf
	echo -e "host=dynamic" >> /etc/asterisk/sip.conf
	echo -e "type=friend" >> /etc/asterisk/sip.conf
	echo -e "callerid=ramal ${I}<${I}>" >> /etc/asterisk/sip.conf
	echo -e "context=interno" >> /etc/asterisk/sip.conf
	echo -e "disallow=all" >> /etc/asterisk/sip.conf
	echo -e "allow=gsm" >> /etc/asterisk/sip.conf
	echo -e "allow=ulaw" >> /etc/asterisk/sip.conf
	echo -e "allow=ilbc" >> /etc/asterisk/sip.conf
	echo -e "canreinvite=no" >> /etc/asterisk/sip.conf
	echo -e " " >> /etc/asterisk/sip.conf
#	echo -e ";novoramal" >> /etc/asterisk/sip.conf
 done   
 	echo -e ";novoramalinterno" >> /etc/asterisk/sip.conf
fi
####################################fim do sip.conf#################################################################

#########adiciona as linhas do servico voip no arquivo extensions.conf###############################################
    echo -e "[general]" > /etc/asterisk/extensions.conf
    echo -e "static=yes" >> /etc/asterisk/extensions.conf
    echo -e "writeprotect=no" >> /etc/asterisk/extensions.conf
    echo -e "[globals]" >> /etc/asterisk/extensions.conf
  #  echo -e "OUTBOUNDTRUNK=SIP/101" >> /etc/asterisk/extensions.conf
    echo -e " " >> /etc/asterisk/extensions.conf
echo -e "[externo]" >>  /etc/asterisk/extensions.conf

 echo -e "include =>outbound-long-distance" >>  /etc/asterisk/extensions.conf
 echo -e "include =>outbound-local" >>  /etc/asterisk/extensions.conf
 echo -e "include =>interno" >>  /etc/asterisk/extensions.conf
 echo -e " " >> /etc/asterisk/extensions.conf
 echo -e "exten =>s,1,Answer()" >> /etc/asterisk/extensions.conf
 echo -e "exten =>s,2,Background(enter-ext-of-person)" >> /etc/asterisk/extensions.conf
 for ((  I=1 ; I <= $TOTAL_EXTERNO; I++ ));do
        REXTERNO=`echo ${EXTERNO}|awk -F "|" '{ print $'${I}' }'`
        echo -e "exten =>${REXTERNO},1,Dial(SIP/${REXTERNO},15,tT)" >> /etc/asterisk/extensions.conf
        echo -e "exten =>${REXTERNO},2,Playback(vm-nobodyavail)" >> /etc/asterisk/extensions.conf
        echo -e "exten =>${REXTERNO},3,Hangup()" >> /etc/asterisk/extensions.conf
        echo -e "exten =>${REXTERNO},102,Playback(vm-isonphone)" >> /etc/asterisk/extensions.conf
        echo -e "exten =>${REXTERNO},103,Hangup()" >> /etc/asterisk/extensions.conf
 done
 echo -e "exten =>i,1,Playback(pbx-invalid)" >> /etc/asterisk/extensions.conf
 echo -e "exten =>i,2,Goto(externo,s,1)" >> /etc/asterisk/extensions.conf
 echo -e "exten =>t,1,Playback(vm-goodbye)" >> /etc/asterisk/extensions.conf
 echo -e "exten =>t,2,Hangup()" >> /etc/asterisk/extensions.conf


if [ ${FLAG} -eq 1 ];then
   echo -e "exten =>_0.,1,Dial(SIP/\${EXTEN}@${loginusuario},90,tT)" >> /etc/asterisk/extensions.conf
   echo -e " " >> /etc/asterisk/extensions.conf
fi

 echo -e "[interno]" >> /etc/asterisk/extensions.conf
 echo -e " " >> /etc/asterisk/extensions.conf
 echo -e "exten =>s,1,Answer()" >> /etc/asterisk/extensions.conf
 echo -e "exten =>s,2,Background(enter-ext-of-person)" >> /etc/asterisk/extensions.conf
 for ((  I=2 ; I <= $TOTAL_INTERNO+1; I++ ));do
        RINTERNO=`echo ${INTERNO}|awk -F "|" '{ print $'${I}' }'`
        echo -e "exten =>${RINTERNO},1,Dial(SIP/${RINTERNO},15,tT)" >> /etc/asterisk/extensions.conf
        echo -e "exten =>${RINTERNO},2,Playback(vm-nobodyavail)" >> /etc/asterisk/extensions.conf
        echo -e "exten =>${RINTERNO},3,Hangup()" >> /etc/asterisk/extensions.conf
        echo -e "exten =>${RINTERNO},102,Playback(vm-isonphone)" >> /etc/asterisk/extensions.conf
        echo -e "exten =>${RINTERNO},103,Hangup()" >> /etc/asterisk/extensions.conf
 done
 echo -e "exten =>i,1,Playback(pbx-invalid)" >> /etc/asterisk/extensions.conf
 echo -e "exten =>i,2,Goto(interno,s,1)" >> /etc/asterisk/extensions.conf
 echo -e "exten =>t,1,Playback(vm-goodbye)" >> /etc/asterisk/extensions.conf
 echo -e "exten =>t,2,Hangup()" >> /etc/asterisk/extensions.conf

 

    if [ ${FLAG} -eq 1 ];then
       #adiciona ramais p/ ligacoes externas
       echo -e "[gvt]" >> /etc/asterisk/extensions.conf
       echo -e " " >> /etc/asterisk/extensions.conf

       for ((  I=1 ; I <= $TOTAL_EXTERNO; I++ ));do
           REXTERNO=`echo ${EXTERNO}|awk -F "|" '{ print $'${I}' }'`
           echo -e "exten =>${loginusuario},${I},Dial(SIP/${REXTERNO},15,tT)" >> /etc/asterisk/extensions.conf
       done
       J=$I
       for ((  I=2 ; I <= $TOTAL_INTERNO+1; I++ ));do
           RINTERNO=`echo ${INTERNO}|awk -F "|" '{ print $'${I}' }'`
           echo -e "exten =>${loginusuario},${J},Dial(SIP/${RINTERNO},15,tT)" >> /etc/asterisk/extensions.conf
	   J=$(( J+1 ))
       done
       echo -e "exten =>${loginusuario},${J},Hangup()" >> /etc/asterisk/extensions.conf
       echo -e " " >> /etc/asterisk/extensions.conf

       #ligacoes locais
       echo -e "[outbound-local]" >> /etc/asterisk/extensions.conf
       echo -e "exten =>_9XXX,1,Dial(\${OUTBOUNDTRUNK}/\${EXTEN:1})" >> /etc/asterisk/extensions.conf
       echo -e "exten =>_9XXX,2,Congestion()" >> /etc/asterisk/extensions.conf
       echo -e " " >> /etc/asterisk/extensions.conf
       #ligacoes externas
       echo -e "[outbound-long-distance]" >> /etc/asterisk/extensions.conf
       echo -e "exten =>XXXXXXXXXX,1,Dial(\${OUTBOUNDTRUNK}/\${EXTEN:1})" >> /etc/asterisk/extensions.conf
       echo -e "exten =>XXXXXXXXXX,2,Congestion()" >> /etc/asterisk/extensions.conf
    fi

    reiniciar

}

function finaliza_config(){


#gauge
(echo "10"; sleep 1
#apt-get install asterisk -y

cd /usr/src > /dev/null 2>&1

ln -s linux-headers-2.6.18-4-686 linux > /dev/null 2>&1

#apt-get install kernel-headers-2.6.15-1 libssl-dev doxygen -y 
echo "20"; sleep 2
tar -zxvf termcap-1.3.1.tar.gz > /dev/null 2>&1
cd termcap-1.3.1 > /dev/null 2>&1
./configure > /dev/null 2>&1
make > /dev/null 2>&1
make install > /dev/null 2>&1

cd /usr/src > /dev/null 2>&1

echo "30"; sleep 1
echo "50"; sleep 1
tar -zxvf libpri-1.4.0.tar.gz > /dev/null 2>&1
cd libpri-1.4.0 > /dev/null 2>&1
make > /dev/null 2>&1
make install > /dev/null 2>&1

cd /usr/src > /dev/null 2>&1

echo "60"; sleep 1
tar -zxvf zaptel-1.4.3.tar.gz > /dev/null 2>&1
cd zaptel-1.4.3 > /dev/null 2>&1
./configure > /dev/null 2>&1
make > /dev/null 2>&1
make install > /dev/null 2>&1

cd /usr/src > /dev/null 2>&1

echo "70"; sleep 1
tar -zxvf asterisk-1.4.4.tar.gz > /dev/null 2>&1
cd asterisk-1.4.4 > /dev/null 2>&1
./configure > /dev/null 2>&1
make  > /dev/null 2>&1
make install > /dev/null 2>&1
make samples > /dev/null 2>&1

cd /usr/src > /dev/null 2>&1

echo "80"; sleep 1
tar -zxvf asterisk-sounds-1.2.1.tar.gz
cd asterisk-sounds-1.2.1
#./configure
#make
#make install
#tar -zxvf asterisk-addons-1.4.1.tar.gz > /dev/null 
#cd asterisk-addons-1.4.1 > /dev/null 
#./configure
#make
#make install
#exemplos
#make samples

cd /usr/src > /dev/null 2>&1


echo "100"; sleep 1) |  $arquivox --title "Instalar asterisk" --gauge "Aguarde, este processo podera demorar ate 30 minutos..." 8 60 0      

 $arquivox --title "Instalar asterisk" --backtitle "ASTERISK" --msgbox "Asterisk instalado com sucesso!!" 0 0

#cadastra_servidor
servidor_voip
}

function reiniciar(){

    #caso nao exista cria a pasta
    mkdir -p /var/run/asterisk/ > /dev/null

    #sobe os modulos necessarios
    modprobe zaptel > /dev/null 2>&1
    modprobe ztdummy > /dev/null 2>&1
    modprobe wcfxo > /dev/null 2>&1
   
    #Caso nao exista o usuario e o grupo asterisk, ele cria
    USUARIOAST=`cat /etc/shadow |sed '/asterisk/!d'|awk -F ":" '{ print $1 }'|wc -l`
    GRUPOAST=`cat /etc/group |sed '/asterisk/!d'|awk -F ":" '{ print $1 }'|wc -l`  

    if [ ${GRUPOAST} -eq 0 ];then
	groupadd asterisk > /dev/null   
    fi	
    if [ ${USUARIOAST} -eq 0 ];then
	useradd -g asterisk asterisk > /dev/null 
    fi

    #seta permissoes de usuario e grupo p/ os arquivos do asterisk
    chown asterisk.asterisk /etc/asterisk -Rv > /dev/null 2>&1 
    chown asterisk.asterisk /var/lib/asterisk -Rv > /dev/null 2>&1 
    chown asterisk.asterisk /var/log/asterisk -Rv > /dev/null 2>&1 
    chown asterisk.asterisk /var/run/asterisk -Rv > /dev/null 2>&1 
    chown asterisk.asterisk /var/spool/asterisk -Rv > /dev/null 2>&1 
    chown asterisk.asterisk /usr/share/asterisk -Rv > /dev/null 2>&1 
    chown asterisk.asterisk /dev/zap -Rv > /dev/null 2>&1 

    chmod 750 /etc/asterisk -Rv > /dev/null 2>&1
    chmod 750 /var/lib/asterisk -Rv > /dev/null 2>&1
    chmod 750 /var/log/asterisk -Rv > /dev/null 2>&1
    chmod 750 /var/run/asterisk -Rv > /dev/null 2>&1
    chmod 750 /var/spool/asterisk -Rv > /dev/null 2>&1
    chmod 750 /usr/share/asterisk -Rv > /dev/null 2>&1
    chmod 750 /dev/zap -Rv > /dev/null 2>&1
   
    #modifica a pasta onde fica os arquivos de configuracao
    #por default e /var/run, mas o correto e /var/run/asterisk
    if [ -e /etc/asterisk/asterisk.conf ] ; then
	sed -i '/astrundir/s/\/var\/run/\/var\/run\/asterisk/g' /etc/asterisk/asterisk.conf > /dev/null 2>&1
    fi

    #habilita no arquivo de configuracao p/ poder rodar o binario
    if [ -e /etc/default/asterisk ] ; then
	sed -i '/RUNASTERISK/s/no/yes/g' /etc/default/asterisk > /dev/null 2>&1
    fi
    
    #modifica p/ horario pt_BR
    sed -i 's/usegmtime=yes/usegmtime=no/g' /etc/asterisk/cdr.conf > /dev/null 2>&1

    #transferi arquivos de audio pt_BR
    cp -vfa  /usr/src/asterisk-sounds-1.2.1/sounds/pt_BR/*.gsm /var/lib/asterisk/sounds/> /dev/null 2>&1

    #habilita tranferencia
    sed -i 's/;transferdigittimeout/transferdigittimeout/g' /etc/asterisk/features.conf > /dev/null 2>&1
    sed -i 's/;xfersound/xfersound/g' /etc/asterisk/features.conf > /dev/null 2>&1
    sed -i 's/;xferfailsound/xferfailsound/g' /etc/asterisk/features.conf > /dev/null 2>&1
    sed -i 's/;pickupexten/pickupexten/g' /etc/asterisk/features.conf > /dev/null 2>&1
    sed -i 's/;featuredigittimeout/featuredigittimeout/g' /etc/asterisk/features.conf > /dev/null 2>&1
    sed -i 's/;blindxfer/blindxfer/g' /etc/asterisk/features.conf > /dev/null 2>&1
    sed -i 's/;disconnect/disconnect/g' /etc/asterisk/features.conf > /dev/null 2>&1
    sed -i 's/;automon/automon/g' /etc/asterisk/features.conf > /dev/null 2>&1
    sed -i 's/;atxfer/atxfer/g' /etc/asterisk/features.conf > /dev/null 2>&1

    #gerencia os arquivos de log pelo crontab e reenvia os arquivos
    # p/ a pasta onde fica o relatorio de chamadas
    echo -e "*  *    * * *   root    cp -f /var/log/asterisk/cdr-csv/Master.csv /var/www/apache2-default/asterisk/relat.txt |chown www-data. /var/www/apache2-default/asterisk/relat.txt" >> /etc/crontab    

    #Caso nao exista o arquivo ele copia p/ init.d e atualiza a daemon
    if [ ! -e  /etc/init.d/rc.debian.asterisk ] ; then
	cp -fa /usr/src/asterisk-1.4.4/contrib/init.d/rc.debian.asterisk /etc/init.d/ > /dev/null 2>&1
	update-rc.d rc.debian.asterisk defaults 99 > /dev/null 2>&1
	chmod +x /etc/init.d/rc.debian.asterisk > /dev/null 2>&1
    fi

    #apaga os arquivos .gz da pasta /usr/src
    cd /usr/src/
    rm -f *.gz  > /dev/null 2>&1

    #iniciar asterisk
    reiniciar_asterisk start &

}
########main######################
menu_principal
#reiniciar
#cadastra_servidor
#finaliza_config
##################################
