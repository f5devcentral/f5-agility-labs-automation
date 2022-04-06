Lab 4 - Creating FAST Template for future app deployments
=========================================================

Install FAST template on BIG-IP
-------------------------------

#. Connect to admin@10.1.1.6 by clicking the device in the F5 HOSTS view
   
#. You should see that FAST(1.16.0) is already installed.  

   .. image:: ../images/lab01_vscode_fastInstalledVersion.png

#. If you do not see FAST(1.16.0) installed you can do the following:

#. Navigate to ``FAST`` under the ``BIG-IP`` menu by choosing ``BIG-IP`` >> ``ATC`` >> ``FAST``

   .. image:: ../images/VScodeFASTDropdown.jpg

#. Under the ``FAST`` dropdown, you should see a list of version options for the FAST extension. Select ``v1.16.0``. This will automatically install the rpm file to the connected BIG-IP. After a minute or so, you should see messages in your output indicating that it is installed: 
        
   .. code-block:: bash

      [INFO]: installing atc rpm job complete, waiting for services to restart (~30 seconds)
      
#. After seeing the above message, please wait another a minute for your connected device to update in VSCode. If it has not refreshed automatically after a minute, try clicking on the ``10.1.1.6`` host again to refresh manually. 


Render Simple FAST YML template to AS3
--------------------------------------
This lab will focus on rendering a FAST yml template using VScode template HTML Preview and generating AS3
declaration which can posted to BIG-IP in VScode istself.

#. Copy the below YML file into the ``VScode`` browser.  The below yml shows the values already populated for tenant name, virtual address, virtual port, server addresses and server port. The template portion has those variables already templatize with double curly braces. 

   .. codeblock:: yml
   
   title: Simple HTTP Application
   description: Simple HTTP load balancer using the same port on client and server side.
   parameters:
     tenant_name: tophttp
     application_name: defaultsHTTP_8080
     virtual_address: 10.0.0.200
     virtual_port: 8080
     server_addresses:
       - 10.1.20.10
       - 10.1.20.11
     service_port: 80
   template: |
     {
       "class": "ADC",
       "schemaVersion": "3.20.0",
       "{{tenant_name}}": {
         "class": "Tenant",
         "{{application_name}}": {
           "class": "Application",
           "template": "http",
           "serviceMain": {
             "class": "Service_HTTP",
             "virtualAddresses": [
               "{{virtual_address}}"
             ],
             "virtualPort": {{virtual_port}},
             "pool": "{{application_name}}_Pool1"
           },
           "{{application_name}}_Pool1": {
             "class": "Pool",
             "monitors": [
               "icmp"
             ],
             "members": [
               {
                 "serverAddresses": {{server_addresses::array}},
                 "servicePort": {{service_port}}
               }
             ]
           }
         }
       }
     }

#. Remaining on the VScode, select ``Render FAST template HTML Preview``.

   .. image:: ../images/render.png
      :scale: 50%

#. Review the Simple HTTP Application details.

   .. image:: ../images/simplehttp.png

#. Click on the ``Render`` button at the bottom of screen to see the generated AS3 declaration.

   .. image:: ../images/renderas3.png

#. Review the generated AS3 declaration.

   .. image:: ../images/as3.png

#. Remaining on ``VScode`` right click to ``POST as AS3 Declaration``.

   .. image:: ../images/postas3.png

#. Remaining on ``VScode`` click on the AS3 tab --> ``Tenant``, and you can see your **tophttp** application.

   .. image:: ../images/tophttp1.png
      :scale: 60%

#. Go to UDF ``bigip1`` Access, and click on TMUI to access ``bigip1``.

   .. image:: ../images/BIGIP_TMUIlogin.jpg

#. Access ``bigip1`` by logging into the GUI to review the configuration, Select partition as ``tophttp`` to see the details.

   .. image:: ../images/bigip1.png

#. Clean up the tenant after use.  In ``VScode`` window, right click on the **tophttp** tenant and select ``Delete Tenant``.

   .. image:: ../images/deletetophttp1.png
      :scale: 50%

Use VScode for Posting FAST Template Set
----------------------------------------
This lab will focus on converting a AS3 declaration into FAST YML and then packaging into FAST Template Set. The template set can be pushed to the BIG-IP. The FAST App can be deployed using the recently pushed template set.

#. Go to ``VScode`` right click on ``fast`` >> ``templates`` folder and click on ``New Folder`` as shown below

   .. image:: ../images/ag1.png

#. Type name of the folder as **Agility** and hit return

   .. image:: ../images/ag2.png

#. Ensure that you have the ``10.1.1.6`` host selected in the F5 Extension. 

#. Create a new file in VSCode and copy/paste the AS3 declaration below 


   .. codeblock:: json
      
      {
        "$schema": "https://raw.githubusercontent.com/F5Networks/f5-appsvcs-extension/master/schema/latest/as3-schema.json",
        "class": "AS3",
        "action": "deploy",
        "persist": true,
        "declaration": {
          "class": "ADC",
          "schemaVersion": "3.0.0",
          "id": "urn:uuid:33045210-3ab8-4636-9b2a-c98d22ab915d",
          "label": "Sample 1",
          "remark": "Simple HTTP application with RR pool",
          "Sample_01": {
            "class": "Tenant",
            "A1": {
              "class": "Application",
              "template": "http",
              "serviceMain": {
                "class": "Service_HTTP",
                "virtualAddresses": [
                  "10.0.1.10"
                ],
                "pool": "web_pool"
              },
              "web_pool": {
                "class": "Pool",
                "monitors": [
                  "http"
                ],
                "members": [
                  {
                    "servicePort": 80,
                    "serverAddresses": [
                      "192.0.1.10",
                      "192.0.1.11"
                    ]
                  }
                ]
              }
            }
          }
        }
      }


#. We need to convert from AS3 JSON to YML FAST template

   .. image:: ../images/ag8.png

#. While in the ``VScode`` right click to see the **AS3-->FAST YAML** option

   .. image:: ../images/ag9.png

#. Review the converted YML file.

#. Replace the Virtual Server IP address **"10.0.1.10"** with **"{{virtual_server}}"**.

#. Replace **["192.0.1.10", "192.0.1.11"]** with **{{server_address::array}}**.

#. Replace **80** with **{{service_port::integer}}**.

   .. image:: ../images/ag11.png

#. Below shows the replacement or templatized parameters.

   .. image:: ../images/ag12.png

#. Now add the **server_address**, **service_port** and **virtual_server** to the parameters section along with description as shown below.
  
   .. image:: ../images/ag13.png

#. Save the file as http.yml in the **Agility** folder.

   .. image:: ../images/ag14.png

#. Review the YML template file which was just created.

   .. codeblock:: yml
   
   title: template title
   description: template description
   parameters:
     tenant_name: default tenant name
     service_address: Server Addresses
     service_port: 80
     virtual_server: Virtual Server
   definitions: 
     tenant_name:
       title: Tenant Name
       type: string
       description: partition on bigip
   template: | 
     {
       "$schema": "https://raw.githubusercontent.com/F5Networks/f5-appsvcs-extension/master/schema/latest/as3-schema.json",
       "class": "AS3",
       "action": "deploy",
       "persist": true,
       "declaration": {
         "class": "ADC",
         "schemaVersion": "3.0.0",
         "id": "urn:uuid:33045210-3ab8-4636-9b2a-c98d22ab915d",
         "label": "Sample 1",
         "remark": "Simple HTTP application with RR pool",
         "{{tenant_name}}": {
           "class": "Tenant",
           "A1": {
             "class": "Application",
             "template": "http",
             "serviceMain": {
               "class": "Service_HTTP",
               "virtualAddresses": [
                 "{{virtual_server}}"
               ],
               "pool": "web_pool"
             },
             "web_pool": {
               "class": "Pool",
               "monitors": [
                 "http"
               ],
               "members": [
                 {
                   "servicePort": {{service_port::integer}},
                   "serverAddresses": {{server_address::array}}
                 }
               ]
             }
           }
         }
       }
     }


#. While you are in the ``VScode`` window highlight the folder **Agility**. Right click and select **Post Template Set** to post the new template to BIG-IP.  

   .. image:: ../images/ag16.png

#. Go to UDF and Click on the ``bigip1`` TMUI and login into the BIG-IP, Click on the
   **iApps --> Application Services --> Application LX**

   .. image:: ../images/ag17.png


#. Go to ``FAST Templates`` and scroll to the botto to see the new **Agility** Template Set 

   .. image:: ../images/ag18.png
   

#. Click on the ``Deploy`` while you are in the F5 Application Services Templates 

   .. image:: ../images/ag19.png

#. Once you click on **Deploy ---> Agility**, the template with default values will appear.
   you will see the template ***Agility/httpTemplate*** is rendered and is ready
   to take different values. In the next step we will see the actual values you need to enter.


   .. image:: ../images/ag21.png

#. Click on *Agility/http* Enter the values for **Tenant Name**,  **virtual_server**, **service_port**.

#. Click on the row tab under **server_addresses** to expand.  Enter the server addresses ***10.1.20.10** and **10.1.20.11***.

#. Hit *Submit* you can also render it as see.


   .. image:: ../images/ag22.png

#. If prompted to login, login with credentials admin / admin

#. Check the ***Result** it should say *Success* in the *Deploy log*


   .. image:: ../images/ag24.png
   

#. Go to UDF bigip1 access Click on TMUI to access bigip1, you can see your application is deployed.

   .. image:: ../images/BIGIP_TMUIlogin.jpg

#. Click on *Partition* on the top right on bigip1 and select **Agility1**


   .. image:: ../images/ag25.png

#. Click on Local Traffic Manager and Select Virtual Server to see the new Virtual Server created


   .. image:: ../images/ag26.png

#. Go back to VScode and click on the F5 Hosts  and then click on FAST VIEW in VScode to see what
   applications are deployed, lookout for *Agility/A1* 


   .. image:: ../images/ag27.png


#. Remianing on the *Agility/A1* Right Click and Select *Delete FAST App* to remove the application frm BIG-IP


   .. image:: ../images/ag28.png

#. You can go back to ``bigip1`` GUI and check the application / Tenant is deleted.
