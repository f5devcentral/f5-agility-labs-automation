Use Case 02: Replace Application Certificates with AS3
======================================================

OVERVIEW
--------
Replace-Application-Certificates.yaml is a templated Ansible playbook that is used to demonstrate automation for managing certificates and keys used by your application services with AS3.

Being able to create and swap SSL Profiles on a BIG-IP to singular or multiple VIPs is extremely useful, especially in today’s world where SSL keys get leaked, systems and applications get hacked, certificates become stale or expire. This automated method allows a seamless process to create and change certificates based on need/demand.

This use case template will create a new application service (VIP) on the F5 BIG-IP that will use a custom key and certificate to terminate client's SSL connection. 

RUNNING THE TEMPLATE
--------------------
Running this template assumes that a F5 BIG-IP instance, necessary webservers and Ansible node are available.  

  1. Login to the Ansible host
    
  2. Change Directory in the Ansible Host to the use-cases repo previously downloaded

    .. code::
    
        cd ~/f5-bd-ansible-labs/201-F5-Advanced/AS3/02-Replace-Application-Certificates-AS3/


  3. Run the Ansible Playbook ‘Replace-Application-Certificates.yaml’:

    .. code::

        ansible-navigator run Replace-Application-Certificates.yaml --mode stdout


AS3 Declarations
----------------
In this module we will discuss a little bit more about AS3 declarations and how they differ from calling modules.  in AS3 the json templates become the single source of truth for the tenant partition.
When using Modules every action is done sequentially but also doesnt take away from the previous command, where as AS3 if a VIP is in the template it will be there, and if between runs the VIP is not there it is removed.

In this code we have our base template (tennant_base.j2) this code sets up our tenant and fills it in with the variable as3_app_body which is a rendering of as3_template.j2 file with ansible filling in variable areas.

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


In this code we have the two usecases (Use Case 1's code and Use Case 2's code), if use Case 1's code would not have been in this template then it would only deploy use case 2's virtual server.  This is an example of how a AS3 template with multiple applications are built.

  .. code::  yaml

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
               "virtualPort": 8081,
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

In this section we focus on Use Case 2 but we wanted to provide an example of how AS3 stacks applications within the template (will be seen in Use Case 3 as well)

TESTING AND VALIDATION
----------------------

**CERTIFICATE VERIFICATION**

   **Access Using F5 UDF Console:**

   Using the External Client (UDF --> Components --> External Client --> Access --> Firefox)

      - In the Bookmarks bar you can select the ``Ansible Labs`` Folder and goto ``201 - Labs`` and Select ``Use Case 2`` 
      - OR within the browser you can browse to https://10.1.20.30:8081/
      - From a client browser, access the VIP on port 8081 to view the new self-signed certificate (https://10.1.20.30:8081)


**BIG-IP CONFIGURATION VERIFICATION**

This section is optional and for testing and verification purposes only. It assumes knowledge of how to operate BIG-IP commands and networking.

   **Access Using F5 UDF Console:**

   - BIG-IP - (In UDF --> Components --> BIG-IP --> Access --> TMUI)  - This will popup a webpage to access the F5 Login Page

      * Login to the BIG-IP instance
      * Navigate to Local Traffic --> Virtual Servers
      * View the deployed use case access VIP:port (8081)

   - Login information for the BIG-IP:
   
      * username: admin 
      * password: **found in the inventory hosts file**