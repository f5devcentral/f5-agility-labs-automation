Lab 4 - Creating FAST Template for future app deployments
=========================================================

Install FAST template on BIG-IP
-------------------------------

#. Connect to admin@10.1.1.6 by clicking the device in the F5 HOSTS view
   
#. You should see that FAST(1.7.1) is already installed.  

   .. image:: ../images/lab01_vscode_fastInstalledVersion.png

#. If you do not see FAST(1.7.1) installed you can do the following:

#. Press F1 (Windows), Command/Shift/P (Mac), then type ``f5 install``

#. Select ``F5 Install RPM``

#. Select FAST
   
#. Select latest version (or 1.7.1)

   .. NOTE:: The vscode-f5 extension queries the repos for the different ATC version to consistently provide an up to date list. Once a version is selected, the extension will download the necessary assets to the local machine (in this case the linux host vscode is running on), then it will upload and install the ATC ILX RPM on the F5. The install happens rather quickly, but it can take another 30-60 seconds for all the servcies to restart and present the changes.

  After everything is complete, the vsocde-f5 extension should reconnect and refresh all the details

Render Simple FAST YML template to AS3
--------------------------------------
This lab will focus on rendering a FAST yml template using VScode template HTML Preview and generating AS3
declaration which can posted to BIG-IP in VScode istself.

#. From the ``VScode`` window click on the ``F5 logo`` on the left to access ``F5 HOST``

#. Right click on the F5 Host to display ``Show Device Info``.  This will show device info details about the BIG-IP like chassis serial number, license, number of interfaces etc. 

   .. image:: ../images/showdeviceinfo.png
      :scale: 50%
  
#. Select the contents of the file and Delete or clear the contents. We are deleting these contents so we can enter the yml file which can be rendered later in the lab.

#. Copy the below YML file into the ``VScode`` browser.  The below yml shows the values already populated for tenant name, virtual address, virtual port, server addresses and server port. The template portion has those variables already templatize with double curly braces. 

   .. literalinclude:: http.yml
      :language: YAML

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

#. Go to ``VScode`` right click on fast/templates folder and click on ``New Folder`` as shown below

   .. image:: ../images/ag1.png

#. Type name of the folder as **Agility** and hit return

   .. image:: ../images/ag2.png

#. Access BIG-IP through ``VScode`` by clicking on the F5 Logo on bottom left then click on **F5 HOSTS**, right 
   click on the F5 HOST and then click on **Show Device info**

   .. image:: ../images/ag4.png
   .. image:: ../images/ag5.png

#. You can see the BIG-IP info details here. Clear the contents of the file. 

   .. image:: ../images/ag6.png

#. Type as3 in the box to list **as3-Sample_01** file and hit enter this will display the sample http as3


   .. image:: ../images/ag7.png

#. Below shows the complete AS3 which you plan to templatize 


   .. literalinclude:: as3.json
      :language: JSON

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

#. Now add the **service_address**, **service_port** and **virtual_server** to the parameters section along with description as shown below.
  
   .. image:: ../images/ag13.png

#. Save the file as http.yml in the **Agility** folder.

   .. image:: ../images/ag14.png

#. Review the YML template file which was just created.

   .. literalinclude:: as3.yml
      :language: YAML

#. While you are in the ``VScode`` window highlight the file **http.yml** in the **Agility** folder. Right click and select **Post Template** to post the new template to BIG-IP.  
   
   When prompted for ``Destination FAST Template Folder Name", enter **Agility**.
   
   When prompted for ``Input Destination FAST Template Name", enter **httpTemplate**.

   .. image:: ../images/ag16.png

#. Go to UDF and Click on the ``bigip1`` TMUI and login into the BIG-IP, Click on the
   **iApps --> Application Services --> Application LX**

   .. image:: ../images/ag17.png


#. Go to ``Templates`` to see the **Agility** Template Set 

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

#. You can go back to bigip1 GUI and check the application / Tenant is deleted.
