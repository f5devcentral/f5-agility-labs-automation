Use Case 04: WAF (XML) Policy Management with AS3
=================================================

OVERVIEW
--------

WAF-Policy-Management.yaml is a templated Ansible Role to manage blocked IP addresses and URL's on F5 ASM through Ansible automation. 

Web Application Firewalls work to protect web applications by inspecting incoming traffic, blocking bots, SQL injection, Cross Site Scripting and a host of other attacks. This playbook is designed to demonstrate a basic WAF scenario to create and modify an F5 WAF (ASM) policy to block URL(s) or IP address(s) or both. 

Using this role, other security vendors or even ticketing based solutions like Service NOW, users will be able to create a start to finish automated solution based on when attacks can occur.

RUNNING THE TEMPLATE
--------------------

Running this template assumes that a F5 BIG-IP instance, necessary webservers and Ansible node are available. 

   1. Ensure you are using a terminal from VSCode (UDF --> Ansible-Node --> Access --> Code-Server --> Password: Ansible123! --> Trust --> Terminal --> New Terminal)

   2. Change Directory in the Ansible Host to the use-cases repo previously downloaded

      .. code:: bash
      
         cd ~/f5-bd-ansible-labs/401-F5-AppWorld-Lab/AS3/04-WAF-Policy-Management-AS3/

   3. Launch the Ansible playbook 'WAF-Policy-Management-Role.yaml':

      .. code::

         ansible-navigator run WAF-Policy-Management.yaml --mode stdout

      .. note::

         This Playbook modifies the provisioning of modules on the BIG-IP and will take some time to complete as the new module comes online.
         
      .. attention::

         This Playbook detects if blocked URL or IP already exists and only add what is new (idempotency).  because of that it will create Errors and ignore them on first run, this is expected behavior.  The Errors will indicate when the exported ASM Policy doesn't contain the data we are attempting to add, and then will add that data.  


TESTING AND VALIDATION
----------------------

**VERIFYING WAF POLICY ENFORCEMENT:**

   **Access Using F5 UDF Console:**

   Using the External Client (UDF --> Components --> External Client --> Access --> Firefox)

      - In the Bookmarks bar you can select the ``Ansible Labs`` Folder and goto ``401 - Labs`` and Select ``Use Case 4`` 
      - OR within the browser you can browse to https://10.1.20.30:8084/ 
      - Access the URL's present in the vars/f5_vars.yml file to see the WAF policy in action 

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
