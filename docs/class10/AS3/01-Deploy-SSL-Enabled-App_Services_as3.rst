Use-case 01: Deploy SSL enabled App-service with AS3
====================================================

OVERVIEW
--------
Deploy-SSL-Enabled-App_Services.yaml is a templated Ansible playbook that utilizes AS3 that demonstrates configuring SSL termination and SSL re-direct for your application on F5 BIG-IP. 

Using this template, we will create an SSL enabled (on port 443) application service (Virtual IP or VIP) on F5 BIG-IP and also create the associative Port 80 SSL redirect for that Virtual IP. If there is an already existing application service (VIP) that was previously deployed without SSL (a very common scenario), this template will also enable SSL (open SSL port) on that Virtual IP address.

The certificates used in this template for SSL termination are self-signed certs that are generated on the BIG-IP. Users will be able to swap out the self-signed certs very easily and we will demonstrate how in 'certificate-replacement' template that will follow.

HIGHLIGHTS
----------

   1. This will deploy a HTTPS enabled application with a HTTP Redirect (port 80 --> 443) using a AS3 declaration.

   2. This code utilizes the F5 default certificate for the SSL enabled application.

   3. AS3 utilizes JSON and Jinja2 coding and is different than our Ansible yaml coding.

   4. AS3 is designed to be the "Single Source of Truth" its recommended to always modify your AS3 declaration and not do modifications with the GUI or imperative automation while using AS3. 


EXAMINING THE CODE
------------------

   1. In the VSCode (Code-Server) on the left menus expand f5-bd-ansible-labs --> 401-F5-AppWorld-Lab --> AS3 --> 01-Deploy-SSL-Enabled-App_Services-AS3 --> and select the `Deploy-SSL-Enabled-App_Services.yaml` file.

   2. In our playbook, we are using block and rescue code to ensure that AS3 is installed within our environment, if our code fails to deploy with AS3 (which it will on first run) then it will install AS3 and re-run the declaration.

   3. Lets examine the code that launches our AS3 declaration.  when using the Ansible lookup reserved function when defined as a template, it will import that j2 code as JSON and any Ansible variable within the j2 file will get filled in by Ansible.

      .. code:: yaml

         - name: PUSH AS3 Template
           f5networks.f5_bigip.bigip_as3_deploy:
             content: "{{ lookup('template','j2/https.j2', split_lines=False) }}"
   
   4. Lets examine our `https.j2` file within the `j2` folder.  Note the Ansible variables used such as `as3_tenant_name`, `F5_VIP_Name` and `pool_members` are variables from our main yaml file.  Also note the jinja2 loop code when adding members to the pool, this is different than our ansible loops.


RUN THE TEMPLATE
----------------
Running this template assumes that a F5 BIG-IP instance, necessary webservers and Ansible node are available.  

  1. Ensure you are using a terminal from VSCode (UDF --> Ansible-Node --> Access --> Code-Server --> Password: Ansible123! --> Trust --> Terminal --> New Terminal)

  2. Change Directory in the Ansible Host to the use-cases repo previously downloaded

    .. code::
    
        cd ~/f5-bd-ansible-labs/401-F5-AppWorld-Lab/AS3/01-Deploy-SSL-Enabled-App_Services-AS3/

  3. Run the Ansible Playbook ‘Deploy-SSL-Enabled-App_Services.yaml’:

    .. code::
    
        ansible-navigator run Deploy-SSL-Enabled-App_Services.yaml --mode stdout

    .. note:: 
      
        Any errors seen on the screen are expected behavior and can be ignored.

TESTING AND VALIDATION
-----------------------

**VERIFYING RE-DIRECT SERVICE:**

   **Access Using F5 UDF Console:**

      Using the External Client (UDF --> Components --> External Client --> Access --> Firefox)

      - In the Bookmarks bar you can select the ``Ansible Labs`` Folder and goto ``401 - Labs`` and Select ``Use Case 1 - HTTP or Use Case 1 - HTTPS`` 
      - OR within the browser you can browse to https://10.1.20.30/
      - You will need to bypass the certificate warning (within Firefox Warning --> Advanced --> Accept the Risk and Continue)
      
      .. note::

         Your browser is presented with a certificate (clientssl cert) that is built with the BIG-IP.
         
         You will therefore see an `unsafe` message from your browser which is expected in this demo. Click proceed to website.

      |

**BIG-IP CONFIGURATION VERIFICATION:**

This section is optional and for testing and verification purposes only. It assumes knowledge of how to operate BIG-IP commands and networking.

   **Access Using F5 UDF Console:**

   - BIG-IP - (In UDF --> Components --> BIG-IP --> Access --> TMUI)  - This will popup a webpage to access the F5 Login Page

      * Login to the BIG-IP instance
      * Navigate to Local Traffic --> Virtual Servers
      * Change the Partition (Top Right Corner) to "WorkshopExample"
      * Ensure there are 2 VIPs with same IP

         + One listening on port 443
         + One listening on port 80

   - Login information for the BIG-IP:
   
      * username: admin 
      * password: **found in the inventory hosts file**