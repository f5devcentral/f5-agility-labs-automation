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

In order to complete this lab, you will connect to environment using VS-Code on the Ubuntu server
called "client".  From VS-Code you will use all tools and interact with BIG-IPs for configuration.
There is also an instance of Firefox, which will be used to validate virtual server configurations.

**Exercise 1 - Connect to VS-Code**

#. Click on the ``Deployment`` tab in your UDF deployment

   .. image:: ../images/components.jpg

#. Find the ``client`` system, and click ``Access``, then click ``VS CODE``.  
   
   .. image:: ../images/AccessVScode2.jpg
      :scale: 70 %

#. A new window will open for the VS-Code program.

   .. image:: ../images/VScode.jpg


