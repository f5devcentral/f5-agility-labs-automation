Use Case 02: Replace Application Certificates with AS3
======================================================

OVERVIEW
--------

Replace-Application-Certificates.yaml is a templated Ansible playbook that is used to demonstrate automation for managing certificates and keys used by your application services with AS3.

Being able to create and swap SSL Profiles on a BIG-IP to singular or multiple VIPs is extremely useful, especially in today’s world where SSL keys get leaked, systems and applications get hacked, certificates become stale or expire. This automated method allows a seamless process to create and change certificates based on need/demand.

This use case template will create a new application service (VIP) on the F5 BIG-IP that will use a custom key and certificate to terminate client's SSL connection. 

In this module we will discuss a little bit more about AS3 declarations and how they differ from calling modules.  in AS3 the json templates become the single source of truth for the tenant partition.

When using Modules every action is done sequentially but also doesn't take away from the previous command, where as AS3 if a VIP is in the template it will be there, and if between runs the VIP is not there it is removed.


HIGHLIGHTS
----------

   1. This will import in a Certificate/Key Combination (Self Signed in our Lab) to the F5 Device and then Create a ClientSSL Profile that utilizes these certificates

   2. The tenant part of the declaration can be separated from the use-cases to help with alignment issues as well as allow for the separation of templates if desired. 

EXAMINING THE CODE
------------------

   1. In the VSCode (Code-Server) on the left menus expand f5-bd-ansible-labs --> 401-F5-AppWorld-Lab --> AS3 --> 02-Replace-Application-Certificates-AS3 --> and select the ``Replace-Application-Certificates.yaml`` file.

   2. In our playbook, we have only two (2) tasks, the conversion of our ``as3_app_body`` into a json variable which contains the bulk of our AS3 declaration with variables filled in and our push of the AS3 declaration. 

   3. In our base template ``tennant_base.j2`` this code sets up our tenant and fills it in with the variable ``as3_app_body`` which is a rendering of ``as3_template.j2`` file with ansible filling in variable areas.

      .. code::  json

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


   4. In this code we have the two usecases (use-case 1's code and use-case 2's code), if use-case 1's code would not have been in this template then it would only deploy use-case 2's virtual server.  This is an example of how a AS3 template with multiple applications are built.

      .. code::  json

         "AS3-UseCase-1": {
         "class": "Application",
         "{{F5_VIP_Name_UC1}}": {
            "class": "Service_HTTPS",
            "virtualAddresses": [
               "{{ private_ip }}"
            ],
            "profileMultiplex": {
               "bigip": "/Common/oneconnect"
            },
            "pool": "{{ F5_VIP_Name_UC1 }}_pool",
            "serverTLS": {
               "bigip": "/Common/clientssl"
            },
            "persistenceMethods": []
         },
         "{{ F5_VIP_Name_UC1 }}_pool": {
            "class": "Pool",
            "minimumMembersActive": 0,
            "minimumMonitors": "all",
            "monitors": [
               "http"
            ],
            "members": [{
               "servicePort": 80,
               "serverAddresses": [
                     {% set comma = joiner(",") %}
                     {% for mem in pool_members %}
                           {{comma()}} "{{  hostvars[mem]['private_ip']  }}"
                     {% endfor %}
               ]
            }]
         }
         },
         "AS3-UseCase-2": {
            "class": "Application",
            "{{F5_VIP_Name}}": {
               "class": "Service_HTTPS",
               "virtualPort": 8082,
               "virtualAddresses": [
                  "{{ private_ip }}"
               ],
               "pool": "{{ F5_VIP_Name }}_pool",
               "redirect80": false,
               "profileMultiplex": {
                  "bigip": "/Common/oneconnect"
               },
               "serverTLS": "{{ F5_VIP_Name }}_cert",
               "persistenceMethods": []
            },
            "{{ F5_VIP_Name }}_pool": {
               "class": "Pool",
               "minimumMembersActive": 0,
               "minimumMonitors": "all",
               "monitors": [
                  "http"
               ],
               "members": [{
                  "servicePort": 80,
                  "serverAddresses": [
               {% set comma = joiner(",") %}
               {% for mem in pool_members %}
                  {{comma()}} "{{  hostvars[mem]['private_ip']  }}"
               {% endfor %}
         ]
               }]
            },
            "{{ F5_VIP_Name }}_cert": {
               "class": "TLS_Server",
               "certificates": [{
                  "certificate": "{{ F5_VIP_Name }}_crt"
               }]
            },
            "{{ F5_VIP_Name }}_crt": {
               "class": "Certificate",
               "remark": "in practice we recommend using a passphrase",
               "certificate": "{{ lookup('file', '{{playbook_dir}}/app-demo.crt') | replace('\n', '\\n') }}",
               "privateKey": "{{ lookup('file', '{{playbook_dir}}/app-demo.key') | replace('\n', '\\n') }}"
            }
         }

      In this section we focus on use-case 2 but we wanted to provide an example of how AS3 stacks applications within a single template.

   5. Inside of our declaration we can also see how the certificate is imported by the Certificate Class then passed to the TLS_Server class being referenced by the main body of use-case 2.

   6. One other thing worth noting in the declaration are these lines below.  the code ``| replace('\n', '\\n')`` within the variable is designed to ensure the newline characters of the certificate and key are accommodated properly with the file importation process. 

      .. code:: json
         
         "certificate": "{{ lookup('file', '{{playbook_dir}}/app-demo.crt') | replace('\n', '\\n') }}",
         "privateKey": "{{ lookup('file', '{{playbook_dir}}/app-demo.key') | replace('\n', '\\n') }}"


RUNNING THE TEMPLATE
--------------------

Running this template assumes that a F5 BIG-IP instance, necessary webservers and Ansible node are available.  

  1. Ensure you are using a terminal from VSCode (UDF --> Ansible-Node --> Access --> Code-Server --> Password: Ansible123! --> Trust --> Terminal --> New Terminal)
    
  2. Change Directory in the Ansible Host to the use-cases repo previously downloaded

    .. code::
    
        cd ~/f5-bd-ansible-labs/401-F5-AppWorld-Lab/AS3/02-Replace-Application-Certificates-AS3/

  3. Run the Ansible Playbook ``Replace-Application-Certificates.yaml``:

    .. code::

        ansible-navigator run Replace-Application-Certificates.yaml --mode stdout



TESTING AND VALIDATION
----------------------

**CERTIFICATE VERIFICATION**

   **Access Using F5 UDF Console:**

   Using the External Client (UDF --> Components --> External Client --> Access --> Firefox)

      - In the Bookmarks bar you can select the ``Ansible Labs`` Folder and goto ``401 - Labs`` and Select ``Use Case 2`` 
      - OR within the browser you can browse to https://10.1.20.30:8082/
      - From a client browser, access the VIP on port 8081 to view the new self-signed certificate (https://10.1.20.30:8082)


**BIG-IP CONFIGURATION VERIFICATION**

This section is optional and for testing and verification purposes only. It assumes knowledge of how to operate BIG-IP commands and networking.

   **Access Using F5 UDF Console:**

   - BIG-IP - (In UDF --> Components --> BIG-IP --> Access --> TMUI)  - This will popup a webpage to access the F5 Login Page

      * Login to the BIG-IP instance
      * Navigate to Local Traffic --> Virtual Servers
      * Change the Partition (Top Right Corner) to "WorkshopExample"
      * View the deployed use case access VIP:port (8082)

   - Login information for the BIG-IP:
   
      * username: admin 
      * password: Ansible123!