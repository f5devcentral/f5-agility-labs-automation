Lab 4 - Creating FAST Template for future app deployments
=========================================================

Connecting to F5 Devices
------------------------

#. F5 Device connection information for reference in the following tasks

   bigip1 - mgmt - 10.1.1.6 - admin/admin

#. Connect to bigip1 in the vscode-f5 extension

#. Click on the ``bigip1.f5demos.com`` at the bottom of the window

    This shows the ``/mgmt/shared/identified-devices/config/device-info`` output, but also provides a json editor

#. Select All, delete.

    We need to delete all the next in the window to prepare for the next step


Create AS3 (from Lab03) to FAST YML
-----------------------------------
#. Click on the F5 logo on the left to access F5 HOST

Upload FAST(zip package)  to BIG-IP
-----------------------------------

Render YAML template locally
----------------------------

Templatize AS3 with WAF Policy to FAST YML
------------------------------------------

Upload FAST(zip package) to BIG-IP
----------------------------------

Deploy FAST YML (WAF policy) to BIG-IP using VSCode
---------------------------------------------------

Deploy FAST YML (WAF policy) to BIG-IP using GUI
------------------------------------------------
