Getting Started
===============

Overview 
--------------
Hands-on lab for using F5's declarative tools for configuration: AS3, FAST, ACC.

Prerequisites 
--------------

1. Access to the F5's Unified Demo Framework (UDF)
2. Chrome browser 

Lab Components
--------------

The following table lists the virtual appliances in the lab along with their
networks and credentials to use.

.. list-table::
    :widths: 20 40 40
    :header-rows: 1
    :stub-columns: 1

    * - **System Type**
      - **Networks**
      - **Credentials**

    * - BIG-IP01
      - Management: 10.1.1.6,
        Internal: 10.1.10.6,
        External: 10.1.20.6
      - admin / admin
    * - BIG-IP02
      - Management: 10.1.1.7,
        Internal: 10.1.10.7,
        External: 10.1.20.7
      - admin / admin
    * - Ubuntu Server, "app"
      - Management: 10.1.1.5,
        Internal: 10.1.10.10,
      - None
      - ubuntu / HelloUDF
    * - Ubuntu Server, "client"
      - Management: 10.1.1.4,
        Internal: 10.1.10.4
      - None
      -ubuntu / HelloUDF

Starting the Lab
----------------

In order to complete this lab, you will connect to environment using VS-Code on the Ubuntu server
called "client".  From VS-Code you will use all tools and interact with BIG-IPs for configuration.
There is also an instance of Firefox, which will be used to validate virtual server configurations.

**Exercise 1 - Connect to VS-Code **

#. Click on the ``Components`` tab in your UDF deployment

   .. image:: images/AccessVScode.jpg

#. Under ``Systems`` find the ``client`` system, and click ``Access``,
   then click ``VS CODE``.  

#. A new window will open for the VS-Code program.

   .. image:: images/VScode.JPG

**Exercise 2 - Launch and configure Postman**

#. Right click and open Postman

   .. image:: images/postman.jpg

#. Once Postman has launched, you need to load the Postman environment
   variables and import the collections we will be using for the lab.

#. First, import the Postman collection, which are located on a github
   repository. On the top left, click the ``Import`` button.

   .. image:: images/import.jpg

#. Select ``Import From Link`` and paste the link into the text box,
   ``https://raw.githubusercontent.com/f5devcentral/f5-agility-labs-automation/master/docs/class03/module1/images/AS3%202020%20Lab.postman_collection20200204.json``,
   then click ``Import``:

   .. image:: images/import_from_link.jpg

#. If you get a message that Postman collection is already present, choose ``Replace`` in the dialog box to overwrite any collection that may be present.

   .. image:: images/postman_collectionPresent.JPG
   
#. You should now see a new folder under the ``Collections`` tab to the left of
   the Postman application screen.

#. Navigate to File -> Settings and confirm the ``SSL Certificate Verification``
   option is turned OFF. If it is on, please turn it OFF. Once finished, exit
   the settings menu.



