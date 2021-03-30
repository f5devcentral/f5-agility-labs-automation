Lab 4 - Creating FAST Template for future app deployments
=========================================================

Install FAST template on BIG-IP
-------------------------------

#. Connect to admin@10.1.1.6 by clicking the device in the F5 HOSTS view
   
#. You should see that FAST(1.7.0) is already installed.  

   .. image:: ../images/lab01_vscode_fastInstalledVersion.png

#. If you do not see FAST(1.7.0) installed you can do the following:

#. Press F1 (Windows), Command/Shift/P (Mac), then type ``f5 install``

#. Select FAST
   
#. Select latest version (or 1.7.0)

   .. NOTE:: The vscode-f5 extension queries the repos for the different ATC version to consistently provide an up to date list. Once a version is selected, the extension will download the necessary assets to the local machine (in this case the linux host vscode is running on), then it will upload and install the ATC ILX RPM on the F5. The install happens rather quickly, but it can take another 30-60 seconds for all the servcies to restart and present the changes.

  After everything is complete, the vsocde-f5 extension should reconnect and refresh all the details

Render Simple FAST YML template to AS3
--------------------------------------
This lab will focus on rendering a FAST yml template using VScode template HTML Preview and generating AS3
declaration which can posted to BIG-IP in VScode istself.

#. From the VScode click on the F5 logo on the left to access F5 HOST

#. Right clock on the F5 Host to Display Show Device Info, the show device info shows details about the  bigip like chassis serial number, license, number of interfaces etc. 

   .. image:: ../images/showdeviceinfo.png
      :scale: 50%
  
#. Select the contents of the file and Delete or clear the contents. We are deleting these contents so that we can enter the yml file which can be rendered later in the lab.

#. Copy the below YML file into the VScode browser.  The below yml shows the values already populated for tenant name, virtual address, virtual port, server addresses and server port. The template portion has those variables already templatize with d  double curly braces. 

   .. literalinclude:: http.yml
      :language: YAML

#. Remaining on the VScode, Render FAST template HTML review 

   .. image:: ../images/render.png
      :scale: 50%

#. Review the Simple HTTP Application details 

   .. image:: ../images/simplehttp.png

#. Click on the ``Render`` button on the bottm to see the AS3 generated 

   .. image:: ../images/renderas3.png

#. Review the generated AS3

   .. image:: ../images/as3.png

#. Remaining on VScode Right Click to POST the AS3 to BIG-IP

   .. image:: ../images/postas3.png

#. Remaining on VScode Click on the AS3 tab --> Tenant 1 you can see your **tophhtp** 1 Application 

   .. image:: ../images/tophttp1.png
      :scale: 60%

#. Go to UDF bigip1 access Click on TMUI to access bigip1, you can see your application is deployed.

   .. image:: ../images/BIGIP_TMUIlogin.jpg

#. Access BIG-IP1 by logging into the GUI to review the configuration, Select partition as tophttp1 to see the details

   .. image:: ../images/bigip1.png

#. Clean up the tenant after use, remaining  at VScode right click on the **tophttp1** tenant and delete

   .. image:: ../images/deletetophttp1.png
      :scale: 50%

Use VScode for Posting FAST Template Set
----------------------------------------
This lab will focus on converting a AS3 declaration into FAST YML and then packaging into FAST Template Set, 
this template Set then can be pushed to the BIG-IP. The FAST App can be deployed using the recently pushed template set.

#. Go to VScode right click on fast/templates folder and click on New folder as shown below

   .. image:: ../images/ag1.png

#. Type name of the folder as **Agility** and hit return

   .. image:: ../images/ag2.png

#. Access BIG-IP through VScode by clicking on the F5 Log on bottom left then Click on **F5 HOSTS**, right 
   click on the F5 HOST and then click on **Show Device info**

   .. image:: ../images/ag4.png
   .. image:: ../images/ag5.png

#. You can see the BIG-IP info details here, clear the contents by pressing Cmd A & Backspace if you are 
   using Mac 

   .. image:: ../images/ag6.png

#. Type as3 in the box to list **as3-Sample_01** file and hit enter this will display the sample http as3


   .. image:: ../images/ag7.png

#. Below shows the complete AS3 which you plan to templatize 


   .. literalinclude:: as3.json
      :language: JSON

#. AS3 Json which we need to convert from AS3 to YML FAST template

   .. image:: ../images/ag8.png

#. While in the VScode Right Click to see the **AS3-->FAST YAML** option

   .. image:: ../images/ag9.png

#. Review the converted YML file and replace the IP address **"10.0.1.10"** by **{{virtual_server}} and
   replace **["192.0.1.10", "192.0.1.11"]** by **{{server_address::array}}** and **80** by **{{service_port}}**

   .. image:: ../images/ag11.png

#. Below shows the replacement or tempaltize parameters.

   .. image:: ../images/ag12.png

#. Also add the **service_address service_port** and **virtual_server** alongwith description as shown below 
  
   .. image:: ../images/ag13.png

#. Save the file as http.yml in the **Agility** folder

   .. image:: ../images/ag14.png

#. Review the YML template file which was just created       

   .. literalinclude:: as3.yml
      :language: YAML

#. While you are in the VScode highlight the **Agility** folder Right Click to get at 
   the **Post Template Set**
   This will post the **Template Set** on the BIG-IP

   .. image:: ../images/ag16.png

#. Go to UDF and Click on the bigip1 TMUI and login into the BIG-IP, Click on the
   **iApps --> Application Services --> Application LX**

   .. image:: ../images/ag17.png


#. Go to the F5 Application Services Templates to see the **Agility** Template Set 

   .. image:: ../images/ag18.png
   

#. Click on the Deploy while you are in the F5 Application Services Templates 

   .. image:: ../images/ag19.png

#. Once you click on Deploy ---> Agility, which will load the template with default values
   you will see the template ***Agility/http*** is rendered and is ready
   to take different values, in the next step we will see the actual values you need to enter.


   .. image:: ../images/ag21.png

#. Click on *Agility/http* Enter the values for ***Tenant Name,  virtual_server, service_port*** Click on the row tab to expand the
   it and enter the server addresses ***10.1.20.10 & 10.1.20.11*** and hit *Submit* you can also render it as see.


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
