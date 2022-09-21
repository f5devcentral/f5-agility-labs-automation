Getting Started
===============

Lab Components
--------------

The following table lists the virtual resources and credentials you will be deploying and utilizing for this lab.  Relevant access endpoints will be dynamically generated via Terraform.

.. list-table::
    :widths: 20 40 80
    :header-rows: 1
    :stub-columns: 1
    
    * - **System Type**
      - **Credentials**
      - **Description**
    * - F5 BIG-IP(s)
      - bigipuser / F5Student!
      - Provides L4/L7 ADC services
    * - NGINX(s)
      - appuser / F5Student!
      - Example backend applicatin workloads 
    * - Hashicorp Consul Server
      - consuluser / F5Student!
      - Provides backend service discovery and scaling operation logging
    * - ELK Stack Server
      - elastic / F5Student!
      - Provides application monitoring and alerting services
    * - Locust
      - N/A
      - Load generation tool    

Starting the Lab
----------------

In order to complete this lab, you utilize F5's Unified Demo Framework (UDF) and connect to a linux jump host as well as your
local browser, (Mozilla Firefox recommended).  Use the below steps to access your jump box.
In later lab sections you will interact with the environment using the jump box too 
access tools, (VS Code and Locust).

#. Navigate to the UDF environment, (*https://udf.f5.com*) and deploy the **Agility 2021 - Performance-based Autoscaling** blueprint.

#. Click on the ``Components`` tab in your UDF deployment

   .. image:: images/udf_start.png
      :width: 400

As illustrated above, you will access the 'client' system via 'VS CODE' and 'LOCUST' access
to complete the lab.  These access links will open tabs on your local browser. 

