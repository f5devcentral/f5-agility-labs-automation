Getting Started
===============

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
      - Management: 10.1.1.4,
        Internal: 10.1.10.10,
        External: 10.1.20.10
      - admin / admin
    * - BIG-IP02
      - Management: 10.1.1.1,
        Internal: 10.1.10.11,
        External: 10.1.20.11
      - admin / admin
    * - Windows Server
      - Management: 10.1.1.9,
        Internal: 10.1.10.41,
        External: 10.1.20.41
      - user / user
    * - LAMP Server
      - Management: 10.1.1.6,
        Internal: 10.1.10.30
      - None

Starting the Lab
----------------

In order to complete this lab, you will connect to a Windows jump host, and you
will perform all steps from there.  In the instructions below, there are steps
to connect to that jump host first, then you will complete the other steps from
there. You can open the lab guide from the Windows jump host in order to make
it easier to follow the rest of the lab.

**Exercise 1 - Login to Windows jump host**

#. Click on the ``Components`` tab in your UDF deployment

   .. image:: images/components.jpg

#. Under ``Systems`` find the Windows Server 2019 Base and click ``Access``,
   then click ``RDP``.  When prompted, select option to ``Save`` RDP file. RDP
   file will be downloaded to your local machine.

   .. image:: images/Win2019_RDP_Access.JPG

#. Open the RDP file downloaded in the previous step and click ``Continue``
   when prompted.

   .. image:: images/Win2019_RDP_Connect.JPG

#. When prompted for login credentials, select ``More Choices``.

#. Select ``Use a different account`` under ``More Choices`` option.

#. Enter credentials: user / user

   .. image:: images/Win2019_RDP_DiffAccount.JPG

#. Click ``OK``.

   .. image:: images/Win2019_RDP_Login.JPG

#. When prompted, click ``Yes`` to connection, and session will be established
   to Windows host.

   .. image:: images/Win2019_RDP_YesConnect.JPG

#. Congratulations! You are now connected to your Windows jump host.

**Exercise 2 - Launch and configure Postman**

#. Right click and open Postman

   .. image:: images/postman.jpg

#. Once Postman has launched, you need to load the Postman environment
   variables and import the collections we will be using for the lab.
   
#. When Postman is open, click on the ``Collections`` tab.  If there is a collection present, right click and select ``Delete`` to remove the collection.

#. First, import the Postman collection, which are located on a github
   repository. On the top left, click the ``Import`` button.

   .. image:: images/import.jpg

#. Select ``Import From Link`` and paste the link into the text box,
   ``https://raw.githubusercontent.com/f5devcentral/f5-agility-labs-automation/master/docs/class03/module1/images/AS3%202020%20Lab.postman_collection20200204.json``,
   then click ``Import``:

   .. image:: images/import_from_link.jpg

#. You should now see a new folder under the ``Collections`` tab to the left of
   the Postman application screen.

#. Navigate to File -> Settings and confirm the ``SSL Certificate Verification``
   option is turned OFF. If it is on, please turn it OFF. Once finished, exit
   the settings menu.



