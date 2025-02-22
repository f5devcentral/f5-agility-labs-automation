Use Case 03: Application Maintenance
====================================

OVERVIEW
--------

Application-Maintenance.yaml is a templated Ansible Playbook that demonstrates the ability to change the state (enable/disable/offline) of traffic flowing to web-server(s) in a load balancing pool.

There are times where web servers are taken offline to provide upgrades, troubleshooting, or even replacement. 

This playbook allows the ability to enable, disable or offline a specific or array of pool members (e.g. [hostname]:[port] or [ip address]:[port]); This script can also affect "All" of the members of a selected pool.

HIGHLIGHTS
----------

   1. This imperative code is designed to run and change the state of nodes within a F5 pool, if you do not re-enable those nodes by modifying the `f5_vars.yml` those nodes will never come online, even commenting out the node that was already disabled that node will stay disabled until it is enabled.

   2. This code utilizes querying from the BIG-IP to determine the pool-members actual name and node to disable it properly. 


EXAMINING THE CODE
------------------

   1. In the VSCode (Code-Server) on the left menus expand f5-bd-ansible-labs --> 401-F5-AppWorld-Lab --> Modules --> 03-Application-Maintenance --> and lets first examine the `f5_vars.yml` file, this vars file has more variables than we have seen in previous use-cases.

      - The `F5_Pool_Members` variable can be set in the array to a specific node and port (e.g. [hostname]:[port] or [ip address]:[port]) or can be set to (All) the code is designed to be able to determine if you want a specific node or all nodes to have a changed state.
      - The `F5_Pool_Node_State` variable can be set to 3 states (Enabled, Disabled, Offline) just like you could do to pool members on a BIG-IP Pool within the GUI.


   2. Now lets examine the code In the VSCode (Code-Server) on the left menus expand f5-bd-ansible-labs --> 401-F5-AppWorld-Lab --> Modules --> 03-Application-Maintenance --> select the `Application-Maintenance.yaml`

   3. This code has also been setup to ensure if run multiple times it doesn't re-enable pool objects (based on previous creation) as using the `f5networks.f5_modules.bigip_pool_member` module would re-enable those objects if disabled.

   4. Another piece of code worth noting, one of these two codes will run based on the `F5_Pool_Members` variable, it will also utilze a previous query string on the BIG-IP to be able to compare the nodes inputted into the variable match the existing pool to ensure the specific or all members of the pool are put in their proper state.

      .. code:: yaml

         - name: Change ALL pool members State to {{F5_Pool_Node_State}}
            f5networks.f5_modules.bigip_pool_member:
               provider: "{{ provider }}"
               state: "{{ F5_Pool_Node_State|lower }}"
               name: "{{ item.split(':')[0] }}"
               pool: "{{ F5_Pool_Name }}"
               port: "{{ item.split(':')[1] }}"
               host: "{{ hostvars[item.split(':')[0]].ansible_host }}"
            loop: "{{ bigip_facts.ltm_pools | json_query(query_string) }}"
            vars:
            query_string: "[?name=='{{F5_Pool_Name}}'].members[*].name[]"
            when: '"all" in F5_Pool_Members|lower and F5_Pool_Node_State is defined'

         - name: Change Specific Pool member(s) State to {{F5_Pool_Node_State}}
            f5networks.f5_modules.bigip_pool_member:
               provider: "{{ provider }}"
               state: "{{ F5_Pool_Node_State|lower }}"
               name: "{{ item.split(':')[0] }}"
               pool: "{{ F5_Pool_Name }}"
               port: "{{ item.split(':')[1] }}"
               host: "{{ hostvars[item.split(':')[0]].ansible_host }}"
            with_items: "{{ F5_Pool_Members }}"
            when: '"all" not in F5_Pool_Members|lower and F5_Pool_Node_State is defined'



RUNNING THE TEMPLATE
--------------------

Running this template assumes that a F5 BIG-IP instance, necessary webservers and Ansible node are available. 

   1. Ensure you are using a terminal from VSCode (UDF --> Ansible-Node --> Access --> Code-Server --> Password: Ansible123! --> Trust --> Terminal --> New Terminal)

   2. Change Directory in the Ansible Host to the use-cases repo previously downloaded

      .. code:: bash
      
         cd ~/f5-bd-ansible-labs/401-F5-AppWorld-Lab/Modules/03-Application-Maintenance


   3. **(Optional)** Edit 'f5_vars.yml' file to customize your variables for your environment. 

   4. Run the Ansible Playbook ‘Application-Maintenance.yaml’ with the variable file ‘f5_vars.yml’:

      .. code:: bash

         ansible-navigator run Application-Maintenance.yaml --mode stdout -e @f5_vars.yml

      .. note::

         By default a VIP and pool will be created during the execution of the code, then the code will disable a single node in that created pool.
         
   5.  **(Optional)** Try changing the f5_vars.yml file to disable additional nodes, or change the original node state back to enabled after saving and the code in #4 is re-executed, then see in the `Testing and Validation` Section if your modification worked.

   
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
      - Click on the pool you selected while running the playbook
      - View the members of the pool and verify their state based on action chosen while running the playbook

   - Login information for the BIG-IP:
   
      * username: admin 
      * password: **found in the inventory hosts file**