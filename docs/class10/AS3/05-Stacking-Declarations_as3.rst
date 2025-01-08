Use Case 05: Stacking Declarations with Ansible
===============================================

OVERVIEW
--------

In this usecase we will show how one can templatize each usecase as a separate jinja file, and then be able to utilize ansible to combine all of the applciations in a single declaration.

This method can be extremely useful when trying to standardize on a template deployment and using VARS files to fill in the blanks, this is also easier to split out a massive single declaration into each usecase for modification and Day 2 delivery.

RUNNING THE TEMPLATE
--------------------

   .. note::

      Do not run this use-case without running AS3 use-cases 01 thru 04, as this will ensure that services and software is enabled. 


Running this template assumes that a F5 BIG-IP instance, necessary webservers and Ansible node are available. 

   1. Ensure you are using a terminal from VSCode (UDF --> Ansible-Node --> Access --> Code-Server --> Password: Ansible123! --> Trust --> Terminal --> New Terminal)

   2. Change Directory in the Ansible Host to the use-cases repo previously downloaded

      .. code:: bash
      
         cd ~/f5-bd-ansible-labs/401-F5-AppWorld-Lab/AS3/05-Stacking-Declarations-AS3/

   3. Launch the Ansible playbook 'WAF-Policy-Management-Role.yaml':

      .. code::

         ansible-navigator run Stacking-Declarations.yaml --mode stdout

      .. note::

         This Playbook assumes all modules are already installed, as well as AS3 is deployed on the F5 device.
         This Playbook also assumes that no modifications of existing declarations are needed (i.e. WAF) and just leverage the existing WAF policies already deployed.

         
AS3 Declarations
----------------

In this code we have our base template (tennant_base.j2) this code sets up our tenant and fills it in with the variable as3_app_body which is a rendering of all of the `j2/usecase_*.j2` files combined with ansible filling in variable areas.

  .. code::  yaml

      {
         {
         "class": "AS3",
         "action": "deploy",
         "persist": true,
         "declaration": {
            "class": "ADC",
            "schemaVersion": "3.2.0",
            "id": "ansibleusecases",
            "label": "Ansible Workshops",
            "remark": "Tenant-multi-app",
            "{{ as3_tenant_name }}":{
                  "class": "Tenant",
                  {{ as3_app_body }}
            }
         }
      }


This will show how you can create individual template files that can be stacked in a single declaration.

TESTING AND VALIDATION
----------------------

**VERIFYING WAF POLICY ENFORCEMENT:**

   **Access Using F5 UDF Console:**

   Using the External Client (UDF --> Components --> External Client --> Access --> Firefox)

      - In the Bookmarks bar you can select the ``Ansible Labs`` Folder and goto any of the use-cases previously deployed all will be available. 


**BIG-IP CONFIGURATION VERIFICATION:**

This section is optional and for testing and verification purposes only. It assumes knowledge of how to operate BIG-IP commands and networking.

   **Access Using F5 UDF Console:**

   - BIG-IP - (In UDF --> Components --> BIG-IP --> Access --> TMUI)  - This will popup a webpage to access the F5 Login Page

      - Login to the BIG-IP instance
      - Navigate to Local Traffic --> Virtual Servers
      - Change the Partition (Top Right Corner) to "WorkshopExample"
      - View the deployed use cases

   - Login information for the BIG-IP:
   
      * username: admin 
      * password: **found in the inventory hosts file**

**UDF Lab Revert**
-------------------------------

   Once you have completed this section it is recommended to go back to Use-Case 00 and run the **restore** of the BIG-IP before continuing to test the AS3 Section.