Lab 4 - Creating FAST Template for future app deployments
=========================================================

Install FAST template on BIG-IP
-------------------------------

#. Connect to admin@10.1.1.6 by clicking the device in the F5 HOSTS view
   
#. You should see that FAST(1.7.0) is already installed.  

   .. image:: /class03/images/lab01_vscode_fastInstalledVersion.png

#. If you do not see FAST(1.7.0) installed you can do the following:

#. Press F1 (Windows), Command/Shift/P (Mac), then type ``f5 install``

#. Select FAST
   
#. Select latest version (or 1.7.0)

   .. NOTE:: The vscode-f5 extension queries the repos for the different ATC version to consistently provide an up to date list. Once a version is selected, the extension will download the necessary assets to the local machine (in this case the linux host vscode is running on), then it will upload and install the ATC ILX RPM on the F5. The install happens rather quickly, but it can take another 30-60 seconds for all the servcies to restart and present the changes.

  After everything is complete, the vsocde-f5 extension should reconnect and refresh all the details


Templatize Simple AS3 to FAST YML
----------------------------------
#. From the VScode click on the F5 logo on the left to access F5 HOST

#. Right clock on the F5 Host to Display Show Device Info, the show device info shows details about the  bigip like chassis serial number, license, number of interfaces etc. 

   .. image:: /class03/images/showdeviceinfo.png
      :scale: 50%
  
#. Select the contents of the file and Delete or clear the contents. We are deleting these contents so that we can enter the yml file which can be rendered later in the lab.

#. Copy the below YML file into the VScode browser.  The below yml shows the values already populated for tenant name, virtual address, virtual port, server addresses and server port. The template portion has those variables already templatize with d  double curly braces. 

   .. literalinclude:: http.yml
      :language: YAML

#. Remaining on the VScode, Render FAST template HTML review 

   .. image:: /class03/images/render.png
      :scale: 50%

#. Review the Simple HTTP Application details 

   .. image:: /class03/images/simplehttp.png

#. Click on the Render TAB to see the AS3 generated 

   .. image:: /class03/images/renderas3.png

#. Review the generated AS3

   .. image:: /class03/images/as3.png

#. Remaining on VScode Right Click to POST the AS3 to BIG-IP

   .. image:: /class03/images/postas3.png

#. Remaining on VScode Click on the AS3 tab --> Tenant 1 you can see your tophhtp 1 Application 

   .. image:: /class03/images/tophttp1.png
      :scale: 60%

#. Go to UDF bigip1 access Click on TMUI to access bigip1, you can see your application is deployed.

   .. image:: /class03/images/BIGIP_TMUIlogin.jpg

#. Access BIG-IP1 by logging into the GUI to review the configuration, Select partition as tophttp1 to see the details

   .. image:: /class03/images/bigip1.png

#. Clean up the tenant after use, remianing at VScode right click on the tophttp1 tenant and delete

   .. image:: /class03/images/deletetophttp1.png
      :scale: 50%

Use VScode for Posting Template Set
-----------------------------------

#. Go to VScode create a folder Agility as shown below

   .. image:: /class03/images/ag1.png
   .. image:: /class03/images/ag2.png
   .. image:: /class03/images/ag4.png
   .. image:: /class03/images/ag5.png
   .. image:: /class03/images/ag6.png
   .. image:: /class03/images/ag7.png

   .. literalinclude:: as3.json
      :language: JSON

   .. image:: /class03/images/ag8.png
   .. image:: /class03/images/ag9.png
   .. image:: /class03/images/ag11.png
   .. image:: /class03/images/ag12.png
   .. image:: /class03/images/ag13.png
   .. image:: /class03/images/ag14.png

   .. literalinclude:: as3.yml
      :language: YAML

   .. image:: /class03/images/ag15.png
   .. image:: /class03/images/ag16.png
   .. image:: /class03/images/ag17.png
   .. image:: /class03/images/ag18.png
   .. image:: /class03/images/ag19.png
   .. image:: /class03/images/ag20.png
   .. image:: /class03/images/ag21.png
   .. image:: /class03/images/ag22.png
   .. image:: /class03/images/ag24.png
   .. image:: /class03/images/ag25.png
   .. image:: /class03/images/ag26.png
   .. image:: /class03/images/ag27.png
   .. image:: /class03/images/ag28.png

#. Click on F5 logo on the left

