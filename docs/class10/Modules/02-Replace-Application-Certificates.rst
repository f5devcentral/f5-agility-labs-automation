Use Case 02: Replace Application Certificates
=============================================

OVERVIEW
--------
Replace-Application-Certificates.yaml is a templated Ansible playbook that is used to demonstrate automation for managing certificates and keys used by your application services.

Being able to create and swap SSL Profiles on a BIG-IP to singular or multiple VIPs is extremely useful, especially in today’s world where SSL keys get leaked, systems and applications get hacked, certificates become stale or expire. This automated method allows a seamless process to create and change certificates based on need/demand.

This use case template will create a new application service (VIP) on the F5 BIG-IP that will use a custom key and certificate to terminate the client's SSL connection.

HIGHLIGHTS
----------

   1. This will import in a Certificate/Key Combination (Self Signed in our Lab) to the F5 Device and then Create a ClientSSL Profile that utilizes these certificates

   2. When using faster expiring certificates it is possible to just upload the updated/new Cert/Key combo in replacement of an existing certificate that utilizes a existing ClientSSL Profile without modifying the Virtual Server or ClientSSL Profile (typically easier as a PFX)

EXAMINING THE CODE
------------------

   1. In the VSCode (Code-Server) on the left menus expand f5-bd-ansible-labs --> 401-F5-AppWorld-Lab --> Modules --> 02-Replace-Application-Certificates --> and select the ``Replace-Application-Certificates.yaml`` file.

   2. Notice that this playbook we are deploying this Virtual Server on a different port 8081 but at first it's deploying with the default certificate just like our previous use-case.

   3. At Line 57+ in the code is when we start importing our Certificate/Key Combination and creating our ClientSSL Profile, and attach that newly created SSL profile to our Virtual Server.

RUNNING THE TEMPLATE
--------------------

Running this template assumes that a F5 BIG-IP instance, necessary webservers and Ansible node are available. 

   1. Ensure you are using a terminal from VSCode (UDF --> Ansible-Node --> Access --> Code-Server --> Password: Ansible123! --> Trust --> Terminal --> New Terminal)
      
   2. Change Directory in the Ansible Host to the use-cases repo previously downloaded

      .. code:: bash
      
         cd ~/f5-bd-ansible-labs/401-F5-AppWorld-Lab/Modules/02-Replace-Application-Certificates

   3. **(Optional)** Edit ``f5_vars.yml`` file to customize your variables.

   4. Run the Ansible Playbook ``Replace-Application-Certificates.yaml`` with the variable file ``f5_vars.yml``:

      .. code:: bash

         ansible-navigator run Replace-Application-Certificates.yaml --mode stdout -e @f5_vars.yml

      In this example, the playbook will configure the BIG-IP instance to import certificates and create (if it doesn't already exist) a Virtual IP (VIP), a Pool and ClientSSL Profile and assign it to the created VIP (Use-Case-2).  
   
      .. note::
         
         The playbook will look for the SSL key and certificates from the path mentioned in the 'f5_vars.yml' file and import those into the BIG-IP. For the sake of this demo, the key and cert are also located in the same folder as the playbook. However, you can provide any path/URI in the variable file. As Ansible automation is idempotent, the same use-case template can be used to modify certs in an existing application service (VIP already exists on BIG-IP). 

      .. note::

         This script can be modified to work on other VIPs and with other key/cert pairs by editing the f5_vars.yaml file.

TESTING AND VALIDATION
----------------------

**CERTIFICATE VERIFICATION**

   **Access Using F5 UDF Console:**

   Using the External Client (UDF --> Components --> External Client --> Access --> Firefox)

      - In the Bookmarks bar you can select the ``Ansible Labs`` Folder and go to ``401 - Labs`` and Select ``Use Case 2`` 
      - OR within the browser you can browse to https://10.1.20.30:8082/
      - From a client browser, access the VIP on port 8081 to view the new self-signed certificate (https://10.1.20.30:8082)

**BIG-IP CONFIGURATION VERIFICATION**

This section is optional and for testing and verification purposes only. It assumes knowledge of how to operate BIG-IP commands and networking.

   **Access Using F5 UDF Console:**

   - BIG-IP - (In UDF --> Components --> BIG-IP --> Access --> TMUI)  - This will popup a webpage to access the F5 Login Page

      * Login to the BIG-IP instance
      * Navigate to Local Traffic --> Virtual Servers
      * View the deployed use case access VIP:port (8082)

   - Login information for the BIG-IP:
   
      * username: admin 
      * password: Ansible123!