Use Case 04: WAF (XML) Policy Management with AS3
=================================================

OVERVIEW
--------

WAF-Policy-Management.yaml is a templated Ansible Role to manage blocked IP addresses and URL's on F5 ASM through Ansible automation. 

Web Application Firewalls work to protect web applications by inspecting incoming traffic, blocking bots, SQL injection, Cross Site Scripting and a host of other attacks. This playbook is designed to demonstrate a basic WAF scenario to create and modify an F5 WAF (ASM) policy to block URL(s) or IP address(s) or both. 

Using this role, other security vendors or even ticketing based solutions like Service NOW, users will be able to create a start to finish automated solution based on when attacks can occur.

HIGHLIGHTS
----------

   1. This code will install the ASM (WAF) module in the F5 Device this can take up to 5 minutes to complete, **it is recommended to run the code first before examining the code.**

   2. This code can work in conjunction with event-driven automation to provide event-driven security by blocking IP addresses and URLs on Virtual Servers utilzing the F5 Web Application Firewall.

   3. This code extracts the F5 WAF policy as a XML and then modifies it to add blocked IP addresses and blocked URLs defined in the `vars/f5_vars.yml` file and then stores it into a webserver (node1).

   4. When using AS3 with WAF Policies, the WAF policy is also treated as a single source of truth and requires to be located on a URL resource (e.g. gitlab/github/webserver) instead of a local file being uploaded.

   5. This code will show `RED` errors in Ansible, typically these are fatal errors, in our use-case we are utilizing the error (null pointers) as a decision maker to ensure that we do not duplicate the insertion of blocked IP addresses and urls into the WAF policy.  (This is expected behavior)

   6. if you re-run the code after the first time, the `RED` errors will not show as the IP addresses and URLs are part of the WAF Policy and are not null pointers.


EXAMINING THE CODE
------------------

   1. In the VSCode (Code-Server) on the left menus expand f5-bd-ansible-labs --> 401-F5-AppWorld-Lab --> AS3 --> 04-WAF-Policy-Management-AS3 --> and select the `WAF-Policy-Management.yaml` file.

   2. In this code we are again utilizing Ansible Roles like in our Backup/Restore use-case.  To examine each role, expand the roles folder within 04-WAF-Policy-Management-AS3 and you can expand each role and see how the code works.

      - The `apply_as3` role contains the AS3 declaration template and the code to apply the AS3 Declaration to the BIG-IP Device.
      - The `checksum` role contains code to validate any changes from the original single source of truth declaration and the potentially modified xml policy.
      - The `existing_policy` role contains code to see if the webserver (node1) has a pre-existing WAF Policy and if not it will use the `files/Master_Template_v16.xml` WAF policy.
      - The `find_file_webserver` role will help identify the latest WAF policy filename to inject into the AS3 declaration.
      - The `install_asm` role will use a Declarative Onboarding (DO) declaration to install ASM on the F5 Device.
      - The `install_do` role will install the latest version of Declarative Onboarding on the F5 Device.
      - The `permissions_change` role is designed to change the permissions of the webserver so the uploaded WAF Policy can be written to the web server and be accessible within the network.
      - The `waf_block_ip` role is designed to utilize the `Blocked_IPs` variable located in `vars/f5_vars.yml` to modify the downloaded XML WAF policy file.
      - The `waf_block_urls` role is designed to utilize the `Blocked_URLs` variable located in `vars/f5_vars.yml` to modify the downloaded XML WAF policy file.

   3. inside of the declaration (roles --> apply_as3 --> templates --> `configure_as3.j2`) we can see how the WAF Policy is applied using variables from the `vars/f5_vars.yml` also note that the WAF policy is defined as its own class then applied to the virtual server above (similar to how the certificates were done in use-case 2)

RUNNING THE TEMPLATE
--------------------

Running this template assumes that a F5 BIG-IP instance, necessary webservers and Ansible node are available. 

   1. Ensure you are using a terminal from VSCode (UDF --> Ansible-Node --> Access --> Code-Server --> Password: Ansible123! --> Trust --> Terminal --> New Terminal)

   2. Change Directory in the Ansible Host to the use-cases repo previously downloaded

      .. code:: bash
      
         cd ~/f5-bd-ansible-labs/401-F5-AppWorld-Lab/AS3/04-WAF-Policy-Management-AS3/

   3. Launch the Ansible playbook 'WAF-Policy-Management.yaml':

      .. code::

         ansible-navigator run WAF-Policy-Management.yaml --mode stdout

      .. note::

         This Playbook modifies the provisioning of modules using Declarative Onboarding (DO) on the BIG-IP and will take some time to complete as the new module comes online.
         
      .. attention::

         This Playbook detects if blocked URLs or IPs already exist and only adds new ones (idempotency).  because of that it will create Errors and ignore them on first run, this is expected behavior.  The Errors will indicate when the exported ASM Policy doesn't contain the data we are attempting to add, and then will add that data.  


TESTING AND VALIDATION
----------------------

**VERIFYING WAF POLICY ENFORCEMENT:**

   **Access Using F5 UDF Console:**

   Using the External Client (UDF --> Components --> External Client --> Access --> Firefox)

      - In the Bookmarks bar you can select the ``Ansible Labs`` Folder and goto ``401 - Labs`` and Select ``Use Case 4`` 
      - OR within the browser you can browse to https://10.1.20.30:8084/ 
      - Access the URL's present in the `vars/f5_vars.yml` file to see the WAF policy in action 

         - https://10.1.20.30:8084/blocked.html
         - https://10.1.20.30:8084/hacked.html
         - https://10.1.20.30:8084/robot.txt 


**BIG-IP CONFIGURATION VERIFICATION:**

This section is optional and for testing and verification purposes only. It assumes knowledge of how to operate BIG-IP commands and networking.

   **Access Using F5 UDF Console:**

   - BIG-IP - (In UDF --> Components --> BIG-IP --> Access --> TMUI)  - This will popup a webpage to access the F5 Login Page

      - Login to the BIG-IP instance
      - Navigate to Security --> Application Security to view the WAF policy deployed
      - Change the Partition (Top Right Corner) to "WorkshopExample"
      - Navigate to Local Traffic --> Virtual Servers
      - View the deployed use case access F5-BIG-IP-Public-IP:port (8084)

   - Login information for the BIG-IP:
   
      * username: admin 
      * password: **found in the inventory hosts file**
