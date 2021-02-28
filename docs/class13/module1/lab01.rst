Lab 1 - Deploying Sample Application Infrastructure
====================================================
The ADC performance-based scaling, (ADPM) lab utilizes a centralized automation repo consisting of:

- Github Actions, (central repo provding automation)
- Hashicorp Terraform, (Application scaling operations)
- Hashicorp Consul Server, (scaling params, student Terraform remote state hosting, logging)
- Alert Forwarding service, (Nodejs proxy providing webhook normalization and security)

As a student you will perform the initial application deployment from your lab jump box utilzing Terraform.
The student terrafrom project utilizes a remote state file hosted on the central Consul server.  The central
ADPM system uses Terraform and the student's remot state file to perform scaling operations.

**Exercise 1 - Deploy Application Infrastructure**

#. From the UDF deployment, select the 'Components' tab and navigate to the client component and
   expand the 'Access' drop-down menu.  Select 'VS Code' to open the VS Code browser interface, (see below).

   .. image:: images/access_vscode.png
      :width: 400

#. The client jump box has been preconfigured top interact with  You will use VS Code to clone and deploy your application environment.  From VS Code, select the
   'Terminal' tab, navigate to the home directory and clone the repo using the below commands.
    
    ``cd $home``
    ``git clone http://https://github.com/f5devcentral/adpm-agility.git``

   .. image:: images/vscode_1.png
      :width: 200
      
#. Navigate to the scripts directory and execute the application deployment script.

   ``cd adpm-agility/scripts``
   ``sh ./deploy.sh``

   .. image:: images/deploy.png
      :width: 200