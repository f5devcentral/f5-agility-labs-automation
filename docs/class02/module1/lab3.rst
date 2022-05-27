Lab 3 Onboard a BIG-IP via BIG-IQ
=================================

In the previous labs, we pushed the declaration directly to BIG-IP. In this 
lab, we are going to send our JSON declaration to BIG-IQ, which will configure 
the BIG-IP. Additionally, the device will be onboarded and managed by BIG-IQ.

#. Review the declaration for **BIG-IP-03**, and notice the following changes:

   - Updated license class 
   - New statements to target the BIG-IQ

#. Just as before we will use VSCode to send the declaration. This time we will
   send the declaration to BIG-IQ and BIG-IQ will onboard the BIG-IP.

   - Use the copy button in the upper right hand corner of the declaration below
   - Paste the declaration into the VSCode editor

   .. attention:: Be sure to connect to the BIG-IQ device in VSCode before sending
      the declaration.


   .. code-block:: JSON

     {
       "class": "DO",
       "declaration": {
           "schemaVersion": "1.5.0",
           "class": "Device",
           "async": true,
           "Common": {
               "class": "Tenant",
               "myLicense": {
                   "class": "License",
                   "licensePool": "lab-licenses",
                   "licenseType": "licensePool",
                   "bigIpUsername": "admin",
                   "bigIpPassword": "@gi1ity2022"
               },
               "myProvisioning": {
                   "class": "Provision",
                   "ltm": "nominal",
                   "gtm": "minimum",
                   "afm": "minimum"
               },           
               "myDns": {
                   "class": "DNS",
                   "nameServers": [
                      "8.8.8.8",
                      "2001:4860:4860::8844"
                   ],
                   "search": [
                       "f5.com"
                   ]
               },
               "myNtp": {
                   "class": "NTP",
                   "servers": [
                       "0.pool.ntp.org",
                       "1.pool.ntp.org",
                       "2.pool.ntp.org"
                   ],
                   "timezone": "UTC"
               },
               "external": {
                   "class": "VLAN",
                   "interfaces": [
                       {
                           "name": "1.1",
                           "tagged": false
                       }
                   ]
               },
               "internal": {
                   "class": "VLAN",
                   "interfaces": [
                       {
                           "name": "1.2",
                           "tagged": false
                       }
                   ]
               },
               "external-fl": {
                   "vlan": "external",
                   "class": "SelfIp",
                   "address": "10.1.10.240/24",
                   "trafficGroup": "traffic-group-1"
               },
               "internal-fl": {
                   "vlan": "internal",
                   "class": "SelfIp",
                   "address": "10.1.20.240/24",
                   "trafficGroup": "traffic-group-1"
               },
               "external-self": {
                   "vlan": "external",
                   "class": "SelfIp",
                   "address": "10.1.10.241/24",
                   "allowService": "none"
               },
               "internal-self": {
                   "vlan": "internal",
                   "class": "SelfIp",
                   "address": "10.1.20.241/24"
               },
               "defualt": {
                   "gw": "10.1.10.1",
                   "class": "Route"
               },
               "myConfigSync": {
                   "class": "ConfigSync",
                   "configsyncIp": "10.1.20.241"
               },
               "myFailoverUnicast": {
                   "class": "FailoverUnicast",
                   "address": "10.1.20.241"
               },
               "hostname": "bigip-03.compute.internal"
           }
         },
         "targetUsername": "admin",
         "targetHost": "10.1.1.8",
         "targetPort": 443,
         "targetPassphrase": "@gi1ity2022",
         "bigIqSettings": {
           "statsConfig": {
               "enabled": true
           },
           "useBigiqSync": true,
           "conflictPolicy": "USE_BIGIQ",
           "deviceConflictPolicy": "USE_BIGIP",
           "failImportOnConflict": false,
           "versionedConflictPolicy": "KEEP_VERSION"
         }
     }

#. Once the declaration completes, login to **BIG-IQ-01**. 

   .. note :: 
      | **URL:** https\://10.1.1.9
      | **Username:** admin
      | **Password:** @gi1ity2022
   
   .. attention ::
      When onboarding BIG-IP-03 via BIG-IQ-01 the DO post may take a few minutes
      to complete. Be sure wait until the declaration result window appears in
      VSCode with the success message before proceeding.
   
   .. attention ::
      When the declaration is complete you may notice that BIG-IQ is still
      adding the device. This is expected as BIG-IQ will perform the device
      onboarding first. Afterwards, it will proceed to add the device and
      discover services on the BIG-IP.

#. Navigate to the devices tab and then click on BIG-IP devices.

   - Notice that the BIG-IP device has been added to BIG-IQ

   .. image:: images/bigiq_1.png

#. Login into **BIG-IP-03** and review the configurations. 

   .. note :: 
      | **URL:** https\://10.1.1.8
      | **Username:** admin
      | **Password:** @gi1ity2022

This completes the Declarative Onboarding lab
---------------------------------------------
