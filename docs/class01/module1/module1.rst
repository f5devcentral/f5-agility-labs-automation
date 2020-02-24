Module 1: Imperative Automation with the BIG-IP and iControl Rest
=================================================================

In this module, you will learn the basic concepts required to interact
with the BIG-IP iControl REST API. Additionally, you will walk through a
typical Device Onboarding workflow to deploy a fully functional
BIG-IP Active/Standby pair. It is important to note that this module will
focus on demonstrating an **Imperative** approach to automation.

.. NOTE:: The Lab Deployment for this lab includes two BIG-IP devices.
   For most of the labs, we will only be configuring the BIG-IP A
   device (management IP has been already been configured in both instances).
   During certain parts of the lab, we will work on both BIG-IP units in what 
   may feel the incorrect order. This is intentional, in order to make all the
   timings happen correctly.

.. NOTE:: In order to confirm the results of REST API calls made in this lab,
   it is recommended to keep GUI/SSH sessions to the BIG-IP devices open. By
   default, BIG-IP will log all the REST API related events locally to
   **restjavad.0.log**. These logs can also be directed to a remote Syslog
   server (see https://support.f5.com/csp/article/K13080). On a side note, the
   **LTM** log files listed below contain log messages specific to  BIG-IP
   local traffic management events.

   - BIG-IP:

     - /var/log/ltm
     - /var/log/restjavad.0.log

.. toctree::
   :maxdepth: 1
   :glob:
   
   lab*
