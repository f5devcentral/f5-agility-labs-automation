Use Case 03: Application Maintenance with AS3
=============================================

OVERVIEW
--------

Application-Maintenance.yaml is a templated Ansible Playbook that demonstrates the ability to change the state (enable/disable/offline) of traffic flowing to web-server(s) in a load balancing pool.

There are times where web servers are taken offline to provide upgrades, troubleshooting, or even replacement. 

This playbook allows the ability to enable, disable or offline a specific or array of pool members (e.g. [hostname]:[port] or [ip address]:[port]); This script can also affect "All" of the members of a selected pool.

HIGHLIGHTS
----------

   1. This declarative code is designed to run and change the state of nodes within a F5 pool, because this is declarative and a declaration defines the end-state of an environment.
   
   2. Due to being declarative, if a node is disabled on the first run but then changed not be disabled on the second run of the code the node will become active automatically. 

EXAMINING THE CODE
------------------

   1. In the VSCode (Code-Server) on the left menus expand f5-bd-ansible-labs --> 401-F5-AppWorld-Lab --> AS3 --> 03-Application-Maintenance-AS3 --> and lets first examine the ``vars/f5_vars.yml`` file, this vars file is similar to our modules section vars.

      - The **F5_Pool_Members** variable can be set in the array to a specific node and port (e.g. [hostname]:[port] or [ip address]:[port]) or can be set to (All) the code is designed to be able to determine if you want a specific node or all nodes to have a changed state.
      - The **F5_Pool_Node_State** variable can be set to 3 states (Enabled, Disabled, Offline) just like you could do to pool members on a BIG-IP Pool within the GUI.

   2. Now lets examine a the specific section within the declaration ``j2/app_maint.j2`` this code loops and iterates over the ``pool_members`` variable which is our inventory file group called ``web`` it will use the information from the inventory with the ``F5_Pool_Members`` and ``F5_Pool_Node_State`` variables to determine the state of the nodes.

      .. code:: json 

         "members": [
            {%  for item in pool_members %}
            {
               "servicePort": 80,
               "serverAddresses": [
                  "{{hostvars[item]['private_ip'] }}"
               ],
               {%  if hostvars[item]['inventory_hostname'] in F5_Pool_Members %}
                  "adminState": "{{F5_Pool_Node_State|lower}}"
               {%  elif "all" in F5_Pool_Members|lower %}
                  "adminState": "{{F5_Pool_Node_State|lower}}"
               {%  else  %}
                  "adminState": "enable"
               {% endif %}
            }{{ ", " if not loop.last else ""}}
            {% endfor %}
         ]



RUNNING THE TEMPLATE
--------------------

Running this template assumes that a F5 BIG-IP instance, necessary webservers and Ansible node are available. 

   1. Ensure you are using a terminal from VSCode (UDF --> Ansible-Node --> Access --> Code-Server --> Password: Ansible123! --> Trust --> Terminal --> New Terminal)

   2. Change Directory in the Ansible Host to the use-cases repo previously downloaded

      .. code:: bash
      
         cd ~/f5-bd-ansible-labs/401-F5-AppWorld-Lab/AS3/03-Application-Maintenance-AS3

   3. Run the Ansible Playbook ``Application-Maintenance.yaml``

      .. code:: bash

         ansible-navigator run Application-Maintenance.yaml --mode stdout

      .. note::

         By default a VIP and pool will be created during the execution of the code, then the code will disable a single node in that created pool.
         
         Modification of the vars/f5_vars.yml file can change the pool, node(s) and state which can be modified within the f5_vars.yml.

TESTING AND VALIDATION
----------------------

This section assumes knowledge of how to operate BIG-IP commands and networking.

**VERIFYING NODE MAINTENANCE:**

   **Access Using F5 UDF Console:**

   Using the External Client (UDF --> Components --> External Client --> Access --> Firefox)

      - In the Bookmarks bar you can select the ``Ansible Labs`` Folder and goto ``401 - Labs`` and Select ``Use Case 3`` 
      - OR within the browser you can browse to https://10.1.20.30:8083/ 
      - Browse the page and notice that only NODE2 is the only responsive Node as Node 1 was disabled.


**BIG-IP CONFIGURATION VERIFICATION:**

   **Using F5 UDF:**

   - BIG-IP - (In UDF --> Components --> BIG-IP --> Access --> TMUI)  - This will popup a webpage to access the F5 Login Page

      - Login to the BIG-IP
      - Navigate to Local Traffic --> Pools
      - Change the Partition (Top Right Corner) to "WorkshopExample"
      - Click on the pool you selected while running the playbook
      - View the members of the pool and verify their state based on action choosen while running the playbook

   - Login information for the BIG-IP:
   
      * username: admin 
      * password: Ansible123!