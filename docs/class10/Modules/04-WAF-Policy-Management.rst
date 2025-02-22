Use Case 04: WAF (XML) Policy Management in a Role
==================================================

OVERVIEW
--------

WAF-Policy-Management-Role.yaml is a templated Ansible Role to manage blocked IP addresses and URL's on F5 ASM through Ansible automation. 

Web Application Firewalls work to protect web applications by inspecting incoming traffic, blocking bots, SQL injection, Cross Site Scripting and a host of other attacks. This playbook is designed to demonstrate a basic WAF scenario to create and modify an F5 WAF (ASM) policy to block URL(s) or IP address(s) or both. 

Using this role, other security vendors or even ticketing based solutions like Service NOW, users will be able to create a start to finish automated solution based on when attacks can occur.

HIGHLIGHTS
----------

   1. This code will install the ASM (WAF) module in the F5 Device this can take up to 5 minutes to complete, **it is recommended to run the code first before examining the code.**

   2. This code can work in conjunction with event-driven automation to provide event-driven security by blocking IP addresses and URLs on Virtual Servers utilzing the F5 Web Application Firewall.

   3. This code extracts the F5 WAF policy as a XML and then modifies it to add blocked IP addresses and blocked URLs defined in the `vars/f5_vars.yml` file (which is now coded into our primary playbook).

   4. This code will show `RED` errors in Ansible, typically these are fatal errors, in our use-case we are utilizing the error (null pointers) as a decision maker to ensure that we do not duplicate the insertion of blocked IP addresses and urls into the WAF policy.  (This is expected behavior)

   5. if you re-run the code after the first time, the `RED` errors will not show as the IP addresses and URLs are part of the WAF Policy and are not null pointers.


EXAMINING THE CODE
------------------

   1. In the VSCode (Code-Server) on the left menus expand f5-bd-ansible-labs --> 401-F5-AppWorld-Lab --> Modules --> 04-WAF-Policy-Management --> and select the `WAF-Policy-Management.yaml` file.

   2. In this code we are again utilizing Ansible Roles like in our Backup/Restore use-case.  To examine each role, expand the roles folder within 04-WAF-Policy-Management and you can expand each role and see how the code works.

      - The `f5_setup_prework` role is designed to Install the ASM Module on the F5, Create our Virtual Server (Pool/Members), and our WAF Policy (which will be empty) and Assign it to the created Virtual Server.
      - The `waf_export_policy` role is designed to extract the WAF Policy as an XML file to our Ansible Excution Environment for Modification. 
      - The `waf_block_ip` role is designed to utilize the `Blocked_IPs` variable located in `vars/f5_vars.yml` to modify the downloaded XML WAF policy file.
      - The `waf_block_urls` role is designed to utilize the `Blocked_URLs` variable located in `vars/f5_vars.yml` to modify the downloaded XML WAF policy file.
      - The `waf_import_apply_policy` role is designed import the execution environment modified XML WAF Policy file to the F5 and overwrite the existing policy, and apply the policy and its configuration immediately to the F5 device. 

   3. An interesting piece of code worth noting is at the end of the execution of all of the code.  This code is not idempotent (this means it doesnt provide a return code to say if the code has run successfully or not) this code launch is like clicking the "Apply Policy" link in the GUI. 

      .. code:: yaml
   
         #Publish ASM Policy via TMSH
         - name: Publish ASM Policy via TMSH
            f5networks.f5_modules.bigip_command:
               commands: "publish asm policy {{ ASM_Policy_Name }}"
               provider: "{{ provider }}"



RUNNING THE TEMPLATE
--------------------

Running this template assumes that a F5 BIG-IP instance, necessary webservers and Ansible node are available. 

   1. Ensure you are using a terminal from VSCode (UDF --> Ansible-Node --> Access --> Code-Server --> Password: Ansible123! --> Trust --> Terminal --> New Terminal)

   2. Change Directory in the Ansible Host to the use-cases repo previously
      downloaded

      .. code:: bash
      
         cd ~/f5-bd-ansible-labs/401-F5-AppWorld-Lab/Modules/04-WAF-Policy-Management/


   3. **(Optional)** Edit 'vars/f5_vars.yml' file to customize your variables.
      Here you can add/remove IP addresses and URLs from the 'Blocked_IPs' and 'Blocked_URLs' list

   4. Launch the Ansible playbook 'WAF-Policy-Management.yaml':

      .. code:: bash

         ansible-navigator run WAF-Policy-Management.yaml --mode stdout

      This template will configure the F5 BIG-IP to provision the `WAF module <https://www.f5.com/products/security/advanced-waf>`__, create a Virtual IP (VIP) including a Pool and nodes, a WAF policy for the use case, then modify the policy to block IP’s and URL’s.


      .. note::

         This playbook modifies the provisioning of modules on the BIG-IP and will take some time to complete as the new module comes online.

      .. attention::

         This playbook detects if blocked URL or IP already exists and only add what is new (idempotency).
   

TESTING AND VALIDATION
----------------------

**VERIFYING WAF POLICY ENFORCEMENT:**

   **Access Using F5 UDF Console:**

   Using the External Client (UDF --> Components --> External Client --> Access --> Firefox)

      - In the Bookmarks bar you can select the ``Ansible Labs`` Folder and goto ``401 - Labs`` and Select ``Use Case 4`` 
      - OR within the browser you can browse to https://10.1.20.30:8084/ 
      - Access the URL's present in the f5_vars.yml file to see the WAF policy in action 

         - https://10.1.20.30:8084/blocked.html
         - https://10.1.20.30:8084/hacked.html
         - https://10.1.20.30:8084/robot.txt 


**BIG-IP CONFIGURATION VERIFICATION:**

This section is optional and for testing and verification purposes only. It assumes knowledge of how to operate BIG-IP commands and networking.

   **Access Using F5 UDF Console:**

   - BIG-IP - (In UDF --> Components --> BIG-IP --> Access --> TMUI)  - This will popup a webpage to access the F5 Login Page

      - Login to the BIG-IP instance
      - Navigate to Security --> Application Security to view the WAF policy deployed
      - Navigate to Local Traffic --> Virtual Servers
      - View the deployed use case access F5-BIG-IP-Public-IP:port (8084)

   - Login information for the BIG-IP:
   
      * username: admin 
      * password: **found in the inventory hosts file**

**UDF Lab Revert**
------------------

   Once you have completed this section it is recommended to go back to Use-Case 00 and run the **restore** of the BIG-IP before continuing to test the AS3 Section.