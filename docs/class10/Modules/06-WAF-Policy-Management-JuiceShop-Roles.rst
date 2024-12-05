Use Case 06: WAF (XML) Policy Management in a Role with Juice Shop
=====================================================================

OVERVIEW
--------

F5-WAF-Policy-Mangement-Role.yaml and JuiceShop-Docker-Deploy.yaml are Ansible Roles to manage blocked IP addresses and URL's on F5 ASM through Ansible automation using the Juice Shop website. 

Web Application Firewalls work to protect web applications by inspecting incoming traffic, blocking bots, SQL injection, Cross Site Scripting and a host of other attacks. This playbook is designed to demonstrate a basic WAF scenario to create and modify an F5 WAF (ASM) policy to block URL(s) or IP address(s) or both. 

Using this role, other security vendors or even ticketing based solutions like Service NOW, users will be able to create a start to finish automated solution based on when attacks can occur.

RUNNING THE TEMPLATE
--------------------

Running this template assumes that a F5 BIG-IP instance, necessary webservers and Ansible node are available. 

   1. Login to the Ansible host

   2. Change Directory in the Ansible Host to the use-cases repo previously downloaded

      .. code:: bash
         
            cd ~/f5-bd-ansible-labs/201-F5-Advanced/Modules/06-WAF-Policy-Management-JuiceShop-Roles/


   3. **(Optional)** Edit 'vars/f5_vars.yml' file to customize your variables. Here you can add/remove IP addresses and URLs from the 'Blocked_IPs' and 'Blocked_URLs' list


   4. Launch the Ansible playbook 'JuiceShop-WAF.yaml' to build out the
      Juice Shop Podman container on each webserver node and deploy the VIP/WAF Policy:

      .. code:: bash

            ansible-navigator run JuiceShop-WAF.yaml --mode stdout

      .. attention::

            This can take up to 5 minutes due to installing of podman and all of its sub-components, and the JuiceShop application on each webserver.

   5. **(Optional)** Block your Client IP Address with WAF

         You can use the IP address of the External Client Node to block which is "10.1.1.9"

         .. code:: bash

            ansible-navigator run Block-My-IP.yaml --mode stdout --extra-vars "my_ip_address=10.1.1.9"

         This template will gather your IP Address from your SSH connection and then add it to the existing WAF Policy and start blocking your IP so that when you browse port 8085 you will get a "Request Rejected" message.

      .. note::

            This Playbook modifies the provisioning of modules on the BIG-IP and will take some time to complete as the new module comes online.

      .. attention::

            This Playbook detects if blocked URL or IP already exists and only add what is new (idempotency).
      

TESTING AND VALIDATION
----------------------

**VERIFYING WAF POLICY ENFORCEMENT:**

   **Access Using F5 UDF Console:**

   Using the External Client (UDF --> Components --> External Client --> Access --> Firefox)

      - In the Bookmarks bar you can select the ``Ansible Labs`` Folder and goto ``201 - Labs`` and Select ``Use Case 6`` 
      - OR within the browser you can browse to https://10.1.20.30:8085/ 
      - Access the URL's present in the f5_vars.yml file to see the WAF policy in action 

         - https://10.1.20.30:8085/blocked.html
         - https://10.1.20.30:8085/hacked.html
         - https://10.1.20.30:8085/robot.txt 


**BIG-IP CONFIGURATION VERIFICATION:**

This section is optional and for testing and verification purposes only. It assumes knowledge of how to operate BIG-IP commands and networking.

   **Access Using F5 UDF Console:**

   - BIG-IP - (In UDF --> Components --> BIG-IP --> Access --> TMUI)  - This will popup a webpage to access the F5 Login Page

      - Login to the BIG-IP instance
      - Navigate to Security --> Application Security to view the WAF policy deployed
      - Navigate to Local Traffic --> Virtual Servers
      - View the deployed use case access F5-BIG-IP-Public-IP:port (8085)

   - Login information for the BIG-IP:
   
      * username: admin 
      * password: **found in the inventory hosts file**

**UDF Lab Revert**
-------------------------------

   Once you have completed this section it is recommended to go back to Use-Case 00 and run the **restore** of the BIG-IP before continuing to test the AS3 Section.