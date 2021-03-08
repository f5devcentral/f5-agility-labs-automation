Lab 1 - Creating a Simple HTTPS Application using FAST - (F5 Application Services Template)
===========================================================================================

F5 Devices
----------

   F5 Device connection information for reference in the following tasks

   ======= ========= ============
   Device  Mgmt. IP  user/pass
   ======= ========= ============
   bigip1  10.1.1.6  admin/admin 
   bigip2  10.1.1.7  admin/admin 
   ======= ========= ============

Task 1 - Getting connected
---------------------------

#. Open VS Code

      To connect to ``VS CODE``, select the ``ACCESS`` dropdown from the ``client`` ``system``, on the right side, then select ``VS CODE``

      .. image:: /class03/images/VSCode-UDF-DropDown.png
      
      .. Note:: This can also be reached via the client access methods
      
      .. image:: /class03/images/AccessVScode.jpg
      
#. Access F5 VSCode extension

      Once connected, click on the ``F5`` logo on the left-hand side of window.

      .. image:: /class03/images/VScode_F5Logo.jpg
         :scale: 50 %

#. Add F5 Host

      If ``BIG-IP`` host ``10.1.1.6`` is not listed under ``F5 HOSTS``, click on ``ADD HOST``.

      .. image:: /class03/images/VScode_F5AddHost.jpg
         :scale: 50 %

      When prompted, enter: admin@10.1.1.6

      .. image:: /class03/images/VScode_F5AddBIGIP01.jpg
         :scale: 50 %

#. Connect to F5 Host

      Click on the newly created host entry in the ``Hosts`` view to connect

      .. image:: /class03/images/lab01_vscode_selectDeviceHostsView.png
         :scale: 50 %

      Enter the password of ``admin`` when prompted
      
      
      
      
      .. NOTE:: An alternative method to connect is to select ``F5 -> Connect!`` at the bottom of the screen
      
      .. image:: /class03/images/VScode_F5Connect.jpg
         :scale: 50 %

      When prompted choose ``admin@10.1.1.6`` from the list of choices:
      
      .. image:: /class03/images/VScode_F5ConnectBIGIP01.jpg
         :scale: 50 %



#. Confirming connection

      You can confirm ``VS CODE`` is connected by looking at detail on ``F5 -> Connect!`` at bottom of screen.  In the status you can see the version of AS3 that is installed on the ``BIG-IP``.  In this case, it is version ``3.22.0``.

      .. image:: /class03/images/VScode_F5ConnectedBIGIP01.jpg
         :scale: 50 %




Task 2 - Access extension documentation
---------------------------------------

      Click on the ``vscode-f5 Documentation`` button in the ``DOCUMENTATION/EXAMPLES`` view

      .. image:: /class03/images/lab01_vscode_documentation_button.jpg


   


Task 3 - Import devices
-----------------------

      How to import devices for larger/automated environments

      #. Open a new tab by double clicking in the main editor area
      #. Paste the following into the editor

         .. code-block:: bash
            :linenos:

            [
               {
               "device": "admin@10.1.1.7",
               "password": "admin"
               }
            ]
      

#. Highlight the json object we just pasted, then right-click in editor, select ``Import Devices``

      .. image:: /class03/images/lab01_vscode_deviceImport.png
         :scale: 75 %


Task 4 - Install FAST extension
-------------------------------

      How to install ATC services using the extension.

      .. NOTE::  This method is considered the "offline" method so all the lab users are not trying to download the same files from github at the same time.  For additional information on alternate install methods see:  https://f5devcentral.github.io/vscode-f5/#/atc_rpm_mgmt

#. In VSCode, go to the file explorer view
#. Open the files folder
#. Right-click ``f5-appsvcs-templates-1.7.0.noarch.rpm``, then select ``Install RPM``

      .. image:: /class03/images/VSCode-FAST-RPMinstall.png
         :scale: 50 %

      .. Note:: This process will upload the local RPM and install it on the F5.  The install happens rather quickly, but it can take another 30-60 seconds for all the servcies to restart and present the changes.  


When complete, the vscode-f5 extension should reconnect and refresh all the details.

      You may need to click on the device in the HOSTS view to reconnect and refresh the discovered services

Notice that FAST now shows as installed (with version number) along the bottom of the editor

      .. image:: /class03/images/lab01_vscode_fastInstalledVersion.png
         :scale: 80 %
      
      
Task 5 - Deploy application via FAST template in tmui
-----------------------------------------------------
   
#. Connect to the F5 UI
      
      .. image:: /class03/images/VSCode-bigip1_tmui_access.png

#. Under ``iApps`` >> ``Application Services`` : ``Applications LX``, select ``F5 Application Services Templates``

      login if needed: ``admin/admin``

      Select the ``Deploy`` tab, expand the ``examples`` section, select ``examples/simple_udp_defaults``

      Notice that the template has default parameters

      Click each of the buttons at the bottom, next to the submit button, to see the different outputs:
      - View Template
      - View Schema
      - View Inputs
      - View Rendered

      Now click  ``Submit`` to deploy an application using the fast template

      .. image:: /class03/images/lab01_tmui_fast_template01.png
         :scale: 80 %
      
      This will bring you back to the ``Deploy Log`` tab and provide a status the application deployment process

#. In the vscode-f5 extension refresh the FAST/AS3 views with the refresh icon in the upper right hand corner of each view window

      Explore the windows to see the deployed FAST application/task, and how it resulted in an AS3 Tenant/Task

      .. image:: /class03/images/lab01_vscode_fastAppFromTMUI.png
         :scale: 80 %

#. Delete application

      In the TMUI (F5 GUI), in the ``F5 Application Services Templates`` screen, select the ``Application List``.

      We should see the application we deployed with FAST.

      On the right side of the application row item, select the ``trash`` icon to delete the application.

      .. image:: /class03/images/lab01_vscode_deleteFastAppFromTMUI.png

Task 6 - Deploy FAST application via API
----------------------------------------

#. In Coder (browser tab for vscode), paste the following into an editor

      .. code-block:: json
         :linenos:

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

#. Highlight the object, right-click, then select ``Deploy Fast App``

      This should produce the following output in another tab

      .. code-block:: json
         :linenos:

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

      .. image:: /class03/images/lab01_vscode_deployFastAppAPI.gif

#. Check the TMUI to see that the application is now in the ``Application List`` tab

#. Check out the vscode-f5 FAST/AS3 views to see what was deployed


Delete application through the FAST API
---------------------------------------

#. In the Coder UI, right-click on the ``Deployed Application`` in the FAST view, then select ``Delete Fast App``

      .. image:: /class03/images/lab01_vscode_deleteFastAppAPI.gif