Use-case 01: Deploy SSL enabled App-service with AS3
====================================================

OVERVIEW
--------
Deploy-SSL-Enabled-App_Services.yaml is a templated Ansible playbook that utilizes AS3 that demonstrates configuring SSL termination and SSL re-direct for your application on F5 BIG-IP. 

Using this template, we will create an SSL enabled (on port 443) application service (Virtual IP or VIP) on F5 BIG-IP and also create the associative Port 80 SSL redirect for that Virtual IP. If there is an already existing application service (VIP) that was previously deployed without SSL (a very common scenario), this template will also enable SSL (open SSL port) on that Virtual IP address.

The certificates used in this template for SSL termination are self-signed certs that are generated on the BIG-IP. Users will be able to swap out the self-signed certs very easily and we will demonstrate how in 'certificate-replacement' template that will follow.

RUN THE TEMPLATE
----------------
Running this template assumes that a F5 BIG-IP instance, necessary webservers and Ansible node are available.  


  1. Login to the Ansible Host

  2. Change Directory in the Ansible Host to the use-cases repo previously downloaded

    .. code::
    
        cd ~/f5-bd-ansible-labs/201-F5-Advanced/AS3/01-Deploy-SSL-Enabled-App_Services-AS3/

  3. Run the Ansible Playbook ‘Deploy-SSL-Enabled-App_Services.yaml’:

    .. code::
    
        ansible-navigator run Deploy-SSL-Enabled-App_Services.yaml --mode stdout

TESTING AND VALIDATION
-----------------------

**VERIFYING RE-DIRECT SERVICE:**

   **Access Using F5 UDF Console:**

      Using the External Client (UDF --> Components --> External Client --> Access --> Firefox)

      - In the Bookmarks bar you can select the ``Ansible Labs`` Folder and goto ``201 - Labs`` and Select ``Use Case 1 - HTTP or Use Case 1 - HTTPS`` 
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
      * Ensure there are 2 VIPs with same IP

         + One listening on port 443
         + One listening on port 80

   - Login information for the BIG-IP:
   
      * username: admin 
      * password: **found in the inventory hosts file**