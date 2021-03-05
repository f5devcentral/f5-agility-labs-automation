Lab 3 Onboard a BIG-IP via BIG-IQ
=================================

In the previous labs, we pushed the declaration directly to BIG-IPs . In this 
lab, we are going to send our JSON declaration to the BIG-IQ, which will configure the BIG-IP.   

#. Review the declaration for **BIGIP-03**, and notice the following changes:

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
       "$schema": "https://raw.githubusercontent.com/F5Networks/f5-declarative-onboarding/master/src/schema/latest/base.schema.json",
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
                   "bigIpPassword": "@gi1ity2021"
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
         "targetPassphrase": "@gi1ity2021",
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

#. Once the declaration completes, login to **BIGIQ-01**. 

   .. note :: Username and password are: **admin/@gility2021**

#. Navigate to the devices tab and then click on BIG-IP devices.

   - Notice that the BIG-IP device has been added to BIG-IQ

   .. image:: images/bigiq_1.png

#. Login into **BIGIP-03** and review the configurations. 

   .. note :: Username and password are: **admin/@gility2021**

This completes the Declarative Onboarding lab
---------------------------------------------