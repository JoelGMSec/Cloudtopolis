<p align="center"><img width=500 alt="Cloudtopolis" src="https://raw.githubusercontent.com/JoelGMSec/Cloudtopolis/master/Cloudtopolis.png"></p>


**Cloudtopolis** is a tool that facilitates the installation and provisioning of Hashtopolis on the Google Cloud Shell platform, quickly and completely unattended (and also, free!). Together with Google Collaboratory, it allows us to break hashes without the need for dedicated hardware from any browser.


# Requirements
Have 1 Google account (at least).


# Installation
Cloudtopolis installation is carried out in two phases:


### Phase 1

Access Google Cloud Shell from the following link:

https://ssh.cloud.google.com/cloudshell/editor?hl=es&fromcloudshell=true&shellonly=true

Then, run the following commands inside this terminal:
```
wget https://raw.githubusercontent.com/JoelGMSec/Cloudtopolis/master/Cloudtopolis.sh
chmod +x Cloudtopolis.sh
./Cloudtopolis.sh
```


### Phase 2

Access Google Collaboratory through the following link:

https://colab.research.google.com/github/JoelGMSec/Cloudtopolis/blob/master/Cloudtopolis.ipynb

It is necessary to fill in the fields in the "Requeriments" section with the data obtained in Hashtopolis.

You can access Hashtopolis directly (provided it is running) from the following url:

https://ssh.cloud.google.com/devshell/proxy?authuser=0&port=8000&environment_id=default

Finally, execute the Collaboratory code until the agent appears registered in Hashtopolis.


# Usage

Once the installation is completed, more agents can be added by repeating phase 2 as many times as desired. 
To do this, it is necessary to use 1 Google account for each instance of the Collaboratory. 
It is not necessary to repeat phase 1 at any time, you can use your other accounts or those of your friends and colleagues.

```
Additional options:

Kaonashi = Download Kaonashi dictionary.txt
Kaonashi_WPA = Download Kaonashi_WPA100M.txt
Rockyou = Download the rockyou.txt dictionary
OneRule = Will download the OneRuleToRuleThemAll rule

VPS = Enable VPS mode, to connect to your own Hashtopolis server via SSH
SshHost = Here you must enter the host or public IP of the VPS server
SshPort = Here you must enter the SSH port of the VPS server
SshUser = Here you must enter the user of the VPS server
SshPass = Here you must enter the password of the VPS server

To load them, it is only necessary to change "False" to "True" before starting the code of the notebook. 
By default, only Rockyou is selected to load at startup.
```

The detailed guide of installation, use and advice can be found in the following link:

https://darkbyte.net/cloudtopolis-rompiendo-hashes-en-la-nube-gratis


# License
This project is licensed under the GNU 3.0 license - see the LICENSE file for more details.

The following are the NVIDIA and Google Colaboratory terms and conditions, as well as the frequently asked questions:

https://colab.research.google.com/pro/terms

https://research.google.com/colaboratory/faq.html

https://cloud.google.com/terms/service-terms/nvidia


# Credits and Acknowledgments
This tool has been created and designed from scratch by Joel Gámez Molina // @JoelGMSec

Original idea from @mxrch, inspired by Penglab: https://github.com/mxrch/penglab

Hashtopolis by Sein Coray: https://github.com/s3inlc/hashtopolis

Hashcat: https://github.com/hashcat/hashcat


# Contact
This software does not offer any kind of guarantee. Its use is exclusive for educational environments and / or security audits with the corresponding consent of the client. I am not responsible for its misuse or for any possible damage caused by it.

For more information, you can contact through info@darkbyte.net


-------------------------------------------------------------------------------------------------------------
# Spanish description


**Cloudtopolis** es una herramienta que facilita la instalación y el aprovisionamiento de Hashtopolis en la plataforma Google Cloud Shell, de forma rápida y totalmente desatendida (y además, gratis!). Junto con Google Colaboratory, nos permite romper hashes sin necesidad de hardware dedicado desde cualquier navegador.


# Requisitos
Disponer de 1 cuenta de Google (como mínimo).


# Instalación
La instalación de Cloudtopolis se realiza en dos fases:


### Fase 1

Acceder a Google Cloud Shell desde el siguiente enlace:

https://ssh.cloud.google.com/cloudshell/editor?hl=es&fromcloudshell=true&shellonly=true

A continuación, ejecutar los siguientes comandos dentro de esta terminal:
```
wget https://raw.githubusercontent.com/JoelGMSec/Cloudtopolis/master/Cloudtopolis.sh
chmod +x Cloudtopolis.sh
./Cloudtopolis.sh
```


### Fase 2

Acceder a Google Colaboratory a través del siguiente enlace:

https://colab.research.google.com/github/JoelGMSec/Cloudtopolis/blob/master/Cloudtopolis.ipynb

Es necesario rellenar los campos en la sección "Requeriments" con los datos obtenidos en Hashtopolis.

Puedes acceder directamente a Hashtopolis (siempre que se encuentre en ejecución) desde la siguiente url:

https://ssh.cloud.google.com/devshell/proxy?authuser=0&port=8000&environment_id=default

Por último, ejecutar el código de Colaboratory hasta que el agente aparezca registrado en Hashtopolis.


# Uso

Una vez terminada la instalación, pueden añadirse más agentes repitiendo la fase 2 tantas veces como se desee. 
Para ello, es necesario utilizar 1 cuenta de Google por cada instancia de Colaboratory. 
No es necesario repetir la fase 1 en ningún momento, puedes utilizar tus otras cuentas o las de tus amigos y compañeros.

```
Opciones adicionales:

Kaonashi = Descargará el diccionario Kaonashi.txt
Kaonashi_WPA = Descargará el diccionario Kaonashi_WPA100M.txt
Rockyou = Descargará el diccionario rockyou.txt
OneRule = Descargará la regla OneRuleToRuleThemAll

VPS = Habilita el modo VPS, para conectarse a un servidor de Hashtopolis propio a través de SSH
SshHost = Aquí debes introducir el host o la IP pública del servidor VPS
SshPort = Aquí debes introducir el puerto SSH del servidor VPS
SshUser = Aquí debes introducir el usuario del servidor VPS
SshPass = Aquí debes introducir la contraseña del servidor VPS

Para cargarlas, solo es necesario cambiar "False" por "True" antes de arrancar el código del cuaderno. 
Por defecto, solo Rockyou está seleccionado para cargarse al inicio.
```

La guía detallada de instalación, uso y consejos se encuentra en el siguiente enlace:

https://darkbyte.net/cloudtopolis-rompiendo-hashes-en-la-nube-gratis


# Licencia
Este proyecto está licenciando bajo la licencia GNU 3.0 - ver el fichero LICENSE para más detalles.

A continuación se adjuntan los términos y condiciones de NVIDIA y Google Colaboratory, así como las preguntas frecuentes:

https://colab.research.google.com/pro/terms

https://research.google.com/colaboratory/faq.html

https://cloud.google.com/terms/service-terms/nvidia


# Créditos y Agradecimientos
Esta herramienta ha sido creada y diseñada desde cero por Joel Gámez Molina // @JoelGMSec

Idea original de @mxrch, inspirado en Penglab: https://github.com/mxrch/penglab

Hashtopolis de Sein Coray: https://github.com/s3inlc/hashtopolis

Hashcat: https://github.com/hashcat/hashcat


# Contacto
Este software no ofrece ningún tipo de garantía. Su uso es exclusivo para entornos educativos y/o auditorías de seguridad con el correspondiente consentimiento del cliente. No me hago responsable de su mal uso ni de los posibles daños causados por el mismo.

Para más información, puede contactar a través de info@darkbyte.net
