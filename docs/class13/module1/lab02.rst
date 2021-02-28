Lab 2 - Configuring Alerts with Elastic Watcher
====================================================

In this lab, you will deploy a sample environment using Microsoft Visual Studio Code.
Your lab environment includes:
* BIG-IP(s) - provding application load balancing
* Application Server(s) - Bakcend sample application, (NGINX) servers
* Elastic ELK stack - Fully functioning and integrated analytics provider
* Hashicorp Consul Server - Providing service discovery and scaling status information

**Exercise 1 - Deploy Application Infrastructure**

#. From the UDF deployment, select the 'Components' tab and navigate to the client component and
   expand the 'Access' drop-down menu.  Select 'VS Code' to open the VS Code browser interface, (see below).

#. You will use VS Code to clone and deploy your application environment.  From VS Code, select the
   'Terminal' tab, navigate to the home directory and clone the repo using the below commands.
    
    ''cd $home
      