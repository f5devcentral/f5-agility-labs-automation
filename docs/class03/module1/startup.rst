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
      - Management: 10.1.1.6,
        Internal: 10.1.10.6,
        External: 10.1.20.6, 10.1.20.10
      - admin / admin
    * - BIG-IP02
      - Management: 10.1.1.7,
        Internal: 10.1.10.7,
        External: 10.1.20.7, 10.1.20.20
      - admin / admin
    * - Ubuntu Server
      - Management: 10.1.1.4,
        Internal: 10.1.10.4,
        External: 10.1.20.4
      - user / user
    * - App Server
      - Management: 10.1.1.5,
        Internal: 10.1.10.10, 10.1.10.5
      - None

Starting the Lab
----------------

In order to complete this lab, you will connect to an Ubuntu jump host, and you
will perform all steps from there.  In the instructions below, there are steps
to connect to that jump host first, then you will complete the other steps from
there. You can open the lab guide from the Windows jump host in order to make
it easier to follow the rest of the lab.

**Exercise 1 - Login to Ubuntu jump host**

#. Click on the ``Components`` tab in your UDF deployment

   .. image:: /class03/images/components.jpg

#. Under ``Systems`` find the Client and click ``Access``,
   then click ``RDP``.  When prompted, select option to ``Save`` RDP file. RDP
   file will be downloaded to your local machine.

   .. image:: /class03/images/Win2019_RDP_Access.JPG

#. Open the RDP file downloaded in the previous step and click ``Continue``
   when prompted.

   .. image:: /class03/images/Win2019_RDP_Connect.JPG

#. When prompted for login credentials, select ``More Choices``.

#. Select ``Use a different account`` under ``More Choices`` option.

#. Enter credentials: user / user

   .. image:: /class03/images/Win2019_RDP_DiffAccount.JPG

#. Click ``OK``.

   .. image:: /class03/images/Win2019_RDP_Login.JPG

#. When prompted, click ``Yes`` to connection, and session will be established
   to Windows host.

   .. image:: /class03/images/Win2019_RDP_YesConnect.JPG

#. Congratulations! You are now connected to your Windows jump host.




