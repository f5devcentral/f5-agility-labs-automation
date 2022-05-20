Lab 1.3: Review/Set Device Settings
-----------------------------------

All devices are ready to be licensed; then, we can focus on configuring the necessary infrastructure related settings to complete the Device Onboarding process. The remaining items include (list not exhaustive):

-  Device Settings

   -  **NTP/DNS Settings**

   -  Remote Authentication

   -  **Hostname**

   -  **Admin Credentials**

-  L1-3 Networking

   -  Physical Interface Settings

   -  L2 Connectivity (**VLAN**, VXLAN, etc.)

   -  L3 Connectivity (**Self IPs, Routing**, etc.)

-  HA Settings

   -  **Global Settings**

      -  **Config Sync IP**

      -  **Mirroring IP**

      -  **Failover Addresses**

   -  **CMI Device Trusts**

   -  **Device Groups**

   -  **Traffic Groups**

   -  **Floating Self IPs**

We will specifically cover the items in **BOLD** above in the following
labs. It should be noted that many permutations of the Device Onboarding process exist due to the nature of real-world environments. This class is designed to teach enough information so that you can then apply the knowledge learned and help articulate and/or deliver a specific solution for your environment.

Task 1 - Set Device Hostname & Disable GUI Setup Wizard
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In this task, we will modify the device hostname and disable the GUI
Setup Wizard. The Resource that contains these settings is
``/mgmt/tm/sys/global-settings``.

Perform the following steps to complete this task:

#. Expand the ``Lab 1.3 - Review/Set Device Settings`` folder in the Postman collection.

#. Click the ``Step 1: Get System Global-Settings`` request. Click the :guilabel:`Send` button and review the response :guilabel:`Body` to see what the current settings on the device are. Examine the resulting response to understand what settings are currently applied.

#. Click the ``Step 2: Set System Global-Settings`` request. This item uses a ``PATCH`` request to the ``global-settings`` resource to modify the attributes contained within it. We will update the ``guiSetup`` and ``hostname`` attribute.

   - Click on :guilabel:`Body`. Review the JSON body and modify the ``hostname`` attribute to set the hostname to ``bigip-a.f5.local``

   - Also notice that we are disabling the GUI Setup Wizard as part of the same request:

     |lab-3-1|

#. Click the :guilabel:`Send` button and review the response :guilabel:`Body`. You should see that the attributes modified above have been updated by looking at the response. You can also ``GET`` the ``global-settings`` by sending the ``Step 1: Get System Global-Settings`` request again to verify they have been updated.

#. Click the ``Step 3: Set System System Device Name`` request. This item uses a ``POST`` request to the ``BASH utility`` resource to modify the attributes contained within it. This step is needed to set the device name in the DSC cluster

Task 2 - Modify DNS/NTP Settings
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. NOTE:: This task will make use of JSON arrays.  The syntax for defining a JSON array is:

   ``myArray: [ Object0, Object1 ... ObjectX ]``

   To define an array consisting of Strings the syntax is:

   ``myStringArray: [ "string0", "string1" ... "stringX" ]``

Much like the previous task, we can update system DNS and NTP settings by sending a PATCH request to the correct resource in the ``sys`` Organizing Collection. The relevant Resources for this task are:

.. list-table::
   :header-rows: 1

   * - **URL**
     - **Type**
   * - ``/mgmt/tm/sys/dns``
     - DNS Settings
   * - ``/mgmt/tm/sys/ntp``
     - NTP Settings

Perform the following steps to complete this task:

#. Click the ``Step 4: Get System DNS Settings`` item in the folder. Click :guilabel:`Send` and review the current settings.

#. Click the ``Step 5: Set System DNS Settings`` item in the folder. Click :guilabel:`Body`. Review the JSON body to verify the name server IPs ``4.2.2.2`` and ``8.8.8.8`` are listed. Additionally, add a search domain of ``f5.local``. You will modify a JSON array to add a search domain:

   |lab-3-4|

#. Click the :guilabel:`Send` button and verify the requested changes were successfully implemented by looking at the response or by sending the ``Step 3: Get System DNS Settings`` request again.

#. Click the ``Step 6: Get System NTP Settings`` item in the folder. Click :guilabel:`Send` and review the current settings.

#. Click the ``Step 7: Set System NTP Settings`` item in the folder. Click :guilabel:`Body`. Review the JSON body to verify the NTP servers with hostnames ``0.pool.ntp.org`` and ``1.pool.ntp.org`` are contained in the ``servers`` attribute (another JSON array!).

#. Click the :guilabel:`Send` button and verify the requested changes were successfully implemented by looking at the response or sending the ``Step 6: Get System NTP Settings`` again.

Task 3 - Update default user account passwords
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In this task, we will update the passwords for the ``root`` and ``admin``
accounts. The process for updating the root account is different from
other system accounts because it is used by underlying Linux OS.

To update the root account password, we will use a ``POST`` to the
``/mgmt/shared/authn/root`` REST endpoint.

To update all other system accounts we will ``PATCH`` the
``/mgmt/tm/auth/user/<username>`` Resource.

Perform the following steps to change the ``root`` user password:

#. Click the ``Step 8: Set root User Password`` item in the folder.

#. We are performing a POST operation to change the root user password and have to specify the ``oldPassword`` because the REST implementation on the BIG-IP uses the underlying Linux mechanism. Click :guilabel:`Body`.  Modify the JSON body to update the password to the value ``newdefault`` and click the :guilabel:`Send` button.

   |lab-3-2|

#. **Repeat the procedure above to change the password back to** ``Agility2020!``.

Perform the following steps to change the **admin** user password:

#. Click the ``Step 9: Set admin User Password`` item in the collection.

#. We are performing a ``PATCH`` operation to admin user Resource. Click :guilabel:`Body` and modify the JSON body to update the password to the value ``newadmin`` and click the :guilabel:`Send` button.

   |lab-3-3|

#. You can verify the password has been changed by logging into TMUI (HTTP GUI) to BIG-IP A in a Chrome browser tab.

#. **Repeat the procedure above to change the password back to** ``Agility2020!``.

Perform the following steps to save the system configuration before licensing the device:

#. Click the ``Step 10: Save config`` item in the collection. Click the ``Send`` button to save the BIG-IP configuration.

.. Warning:: Configuration changes made through the iControl REST API are not saved by default. A configuration save prior to a reload or reboot of the system is required.

.. |lab-3-1| image:: images/lab-3-1.png
.. |lab-3-2| image:: images/lab-3-2.png
.. |lab-3-3| image:: images/lab-3-3.png
.. |lab-3-4| image:: images/lab-3-4.png
.. |lab-3-5| image:: images/lab-3-5.png

Task 4 - License the BIG-IPs
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In more recent versions of BIG-IP TMOS editions, you can place configuration on the platform **prior** to installing a license. If you have logged into the BIG-IPs at any point before this section, you will have noticed ours do not have a license.

This concept can be used in several applications, like placing a BIG-IP into an environment before needing it or testing out configuration restores or validation.

This lab contains a BIG-IQ instance which houses a license pool,
which will come in Enterprise License Agreements, or Subscription agreements directly from F5.

#. Click the ``Step 11: License BIG-IP A`` item in the collection. Click the ``Send`` button to ``POST`` the request to BIG-IQ for license allocation. Examine the BIG-IP A GUI to see the license has been allocated.

#. Click the ``Step 12: License BIG-IP B`` item in the collection. Click the ``Send`` button to ``POST`` the request to BIG-IQ for license allocation. Examine the BIG-IP B GUI to see the license has been allocated.

.. Warning:: Licensing a BIG-IP can take several seconds, as the license is checked and the requested services are restarted. Please wait for the systems to be **ONLINE (ACTIVE)** before proceeding

Task 5 - Provision ASM Module
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The example services we will create in this lab will need ASM provisioned for emulated protection, we are going to provision the module here to keep the lab flowing correctly

Provisioning or de-provisioning a module is a **PATCH** operation, as there are modules that exist alongside what we are requesting, we do not utilize a **POST**  as that would erase all other settings to the endpoint.

#. Click the ``Step 13: Provision ASM BIG-IP A`` item in the collection. Click the ``Send`` button to ``POST`` the request to BIG-IQ for license allocation. Examine the BIG-IP A GUI to see the module has been provisioned.

#. Click the ``Step 14: Provision ASM BIG-IP B`` item in the collection. Click the ``Send`` button to ``POST`` the request to BIG-IQ for license allocation. Examine the BIG-IP B GUI to see the module has been provisioned.

.. Warning:: Changing of modules provisioned on a BIG-IP is an outage level event. This should only be done during a change window. The elapsed time for the new services to be online will be several seconds to minutes. Please wait for the systems to be **ONLINE (ACTIVE)** before proceeding.
