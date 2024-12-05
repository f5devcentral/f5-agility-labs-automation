Class 10: Mastering Imperative and Declarative Automation with F5 BIG-IP
========================================================================

`Last updated: 2024-12-05 11:00 AM MT`


OVERVIEW
--------

The use cases templates are built for the F5 Automation Sandbox ennvironment. To run the use-cases, users must use the environment to stand-up the F5 automation sandbox environment. 

With a F5 Automation Sandbox environment and these scenario use cases, users can/will be able to

- Test common deployment scenarios through Automation with Ansible
- Fork instances of code to develop their own plugins and automation playbooks 
- Provide feedback on existing and new use cases that are relevant to everyday work

.. attention:: 

   This content is built by F5 Business Development organization. New content will be added periodically to provide additional automation senarios. Please open a github issue for any new feature request.

HOW TO USE
----------

.. image:: images/executing-templates.png
   :width: 800

**1. PROVISION INFRASTRUCTURE**

   There are two options to creating a F5 Automation Sandbox environment, you only need to do one of these (not both) to access the lab.

      - Contact your F5 Account Manager or Sales Engineer to help setup a F5 UDF Environment for testing.



**2. Examine the Ansible-Use-Case Code via Github**

   - Examine the use case code via Github - ` <https://github.com/f5devcentral/f5-bd-ansible-labs>`_
    
   
**3. When Using F5 UDF Environment & Ansible Inventory File**

   When using the F5 UDF environment, everything is configured and setup correctly, use the instructions on how to access your lab given to you by either your F5 instructor or by the UDF Instructions Email.   
   

**4. RUN USE CASE TEMPLATES**

   Start with Use-Cases (Click the following link) to begin - `Use-Case 00 <https://clouddocs.f5.com/training/fas-ansible-use-cases/00-Backup-Restore-Role.html>`_ 

   .. note::

      Keep the BIG-IP login handy to login and validate configuration when use cases are executed
   
Support
-------

   This project is a community effort to promote Network and Security automation and is maintained by F5 Business Development (BD). For anyfeature requests or issues, feel free to open an `issue <https://github.com/f5devcentral/f5-bd-ansible-labs/issues>`_ and we will give our best effort to address it.

.. note::

   Need help with automating use cases not present here - `Open a request <https://github.com/f5devcentral/f5-bd-ansible-labs/issues>`_

 
Modules Labs
------------

.. toctree::
   :glob:
   :maxdepth: 2
   :Caption: 201 Modules Labs

   Modules/*

AS3 Labs
--------

.. toctree::
   :glob:
   :maxdepth: 2
   :Caption: 201 AS3 Labs

   AS3/*
   