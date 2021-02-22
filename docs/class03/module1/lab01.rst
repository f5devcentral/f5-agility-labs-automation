Lab 1 - Creating a Simple HTTPS Application using FAST - (F5 Application Services Template)
===========================================================================================

Getting the latest vscode-f5 extension
--------------------------------------

To download latest vscode extension

.. code-block::  
curl -LO https://github.com/f5devcentral/vscode-f5/releases/download/v2.10.7/vscode-f5-2.10.7.vsix 


To always download latest vscode-f5 extension (requires jq in bash "sudo apt install jq -Y")

.. code-block:: 
curl -sL https://api.github.com/repos/f5devcentral/vscode-f5/releases/latest | jq .assets[0].browser_download_url | xargs wget


F5 Devices
----------

F5 Device connection information for reference in the following tasks

bigip1 - mgmt - 10.1.1.6 - admin/admin
bigip2 - mgmt - 10.1.1.7 - admin/admin


Task 1 - Access extesnion documentation
---------------------------------------

How to access vscode-f5 extension documenation

** gif/screenshot of documentation link in "Documentation/Examples" view **


Task 2 - Add F5 device to vscode-f5 extension
---------------------------------------------

The following describes how to manualy add an F5 device to the extension

** gif/screenshot of main extension hosts view **

#. Click ``ADD HOST`` in the hosts view
#. Enter ``admin@10.1.1.6``, hit Enter
#. Click on host entry to connect
#. type in password of ``admin``

   Notice the discovered ATC services


Task 3 - Import devices
-----------------------

How to import devices for larger/automated environments

#. Open a new tab by double clicking in the tab bar along the top
#. Paste the following into the editor


.. code-block::
[
    {
        "device": "admin@10.1.1.7",
        "password": "admin"
    }
]

#. Highlight the json object we just pasted, then right-click in editor, select ``Import Devices``

Install FAST extension
---

How to install ATC services using the extension

#. Connect to admin@10.1.1.6 by clicking the device in the ``F5 HOSTS`` view
#. Press ``F1``, then type ``f5 install``
#. Select FAST
#. Select latest version (or 1.6.0)

The vscode-f5 extension quieries the repos for the different ATC version to consistantly provide an update to date list.  Once a version is selected, the extension will download the necessary assets to the local machine (in this case the linux host vscode is running on), then it will upload and install the ATC ILX RPM on the F5.  The install happens rather quickly, but it can take another 30-60 seconds for all the servcies to restart and present the changes.  

After everything is complete, the vsocde-f5 extension should reconnect and refresh all the details

Notice that FAST now shows as installed (with version number) along the bottom of the editor

** screenshot/gif **


Deploy application via FAST template in tmui
---

#. Under iApps >> Application Services : Applications LX, select ``F5 Application Services Templates``

   login if needed ``admin/admin``

   Select the ``Deploy`` tab, expand the ``examples`` section, select ``examples/simple_udp_defaults``

   Notice that the template has default parameters

   Click each of the buttons at the bottom, next to the submit button, to see the different outputs:
   - View Template
   - View Schema
   - View Inputs
   - View Rendered

   Now click  ``Submit`` to deploy an application using the fast template

   This will bring you back to the ``Deploy Log`` tab and provide a status the application deployment process


#. Back in the vscode-f5 extension refresh the FAST/AS3 views with the refresh icon in the upper right hand corner of each view window

   Explore the windows to see the deployed FAST application/task, and how it resulted in an AS3 Tenant/Task

#. Delete application

   Bank in the TMUI (F5 GUI), in the ``F5 Application Services Templates screen, select the ``Application List``.

   We should see the application we deployed with FAST.

   On the right side of the application row item, select the trash icon to delete the application.


Deploy FAST application via API
---

#. In Coder (browser tab for vscode), paste the following into an editor

.. code-block:: JSON
   {
      "name": "examples/simple_http",
      "parameters": {
         "tenant_name": "apiTenant",
         "application_name": "apiTenant",
         "virtual_port": 80,
         "virtual_address": "192.168.230.40",
         "server_port": 8080,
         "server_addresses": [
               "192.168.100.11",
               "192.168.100.12"
         ]
      }
   }

#. Highlight the objec, right-click, then select ``Deploy Fast App``

   This should produce the following output in another tab

        {
            "id": "4b06e4d9-01f1-497e-93e5-662d5eb75d1d",
            "code": 200,
            "message": "success",
            "name": "examples/simple_http",
            "parameters": {
               "tenant_name": "apiTenant",
               "application_name": "apiTenant",
               "virtual_port": 80,
               "virtual_address": "192.168.230.40",
               "server_port": 8080,
               "server_addresses": [
                     "192.168.100.11",
                     "192.168.100.12"
               ]
            },
            "tenant": "apiTenant",
            "application": "apiTenant",
            "operation": "create"
        }

#. Check the TMUI to see that the application is now in the ``Application List`` tab

#. Check out the vscode-f5 FAST/AS3 views to see what was deployed


Delete application through the FAST API
---

#. In the Coder UI, right-click on the Deployed FAST application in the FAST view, then select ``Delete Fast App``



making fast template