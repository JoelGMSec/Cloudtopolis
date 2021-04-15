<p align="center"><img width=550 alt="Cloudtopolis" src="https://raw.githubusercontent.com/JoelGMSec/Cloudtopolis/master/Cloudtopolis.png"></p>


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
curl https://raw.githubusercontent.com/JoelGMSec/Cloudtopolis/master/Cloudtopolis.sh | bash
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

Kaonashi = Download the Kaonashi.txt dictionary
Kaonashi_WPA = Download the Kaonashi_WPA100M.txt dictionary
Rockyou = Download the rockyou.txt dictionary
OneRule = Download the OneRuleToRuleThemAll rule

VPS = Enable VPS mode, to connect to your own Hashtopolis server via SSH
SshHost = Here you must enter the host or public IP of the VPS server
SshPort = Here you must enter the SSH port of the VPS server
SshUser = Here you must enter the user of the VPS server
SshPass = Here you must enter the password of the VPS server

To load them, it is only necessary to change "False" to "True" before starting the code of the notebook. 
By default, only Rockyou is selected to load at startup.
```

### The detailed guide of use can be found at the following link:

https://darkbyte.net/cloudtopolis-rompiendo-hashes-en-la-nube-gratis


# License
This project is licensed under the GNU 3.0 license - see the LICENSE file for more details.

The following are the NVIDIA and Google Colaboratory terms and conditions, as well as the frequently asked questions:

https://colab.research.google.com/pro/terms

https://research.google.com/colaboratory/faq.html

https://cloud.google.com/terms/service-terms/nvidia


# Credits and Acknowledgments
This tool has been created and designed from scratch by Joel Gámez Molina // @JoelGMSec

Original idea from **@mxrch**, inspired in *Penglab* --> https://github.com/mxrch/penglab

**Hashtopolis** by *Sein Coray* --> https://github.com/s3inlc/hashtopolis

**Hashcat** --> https://github.com/hashcat/hashcat


# Contact
This software does not offer any kind of guarantee. Its use is exclusive for educational environments and / or security audits with the corresponding consent of the client. I am not responsible for its misuse or for any possible damage caused by it.

For more information, you can contact through info@darkbyte.net


# Support
You can support my work buying me a coffee:

[<img width=250 alt="buymeacoffe" src="https://cdn.buymeacoffee.com/buttons/v2/default-blue.png">](https://www.buymeacoffee.com/joelgmsec)
