Lab 3 (Optional) Onboard a BIGIP via BIGIQ
=================================================

In the previous labs, we pushed the declaration directly to BIGIPs . In this lab, we are going to send our JSON declaration to the BIGIQ, which will configure the BIGIP.   

Review the declaration for BIGIP-03, and notice the following changes:

- Updated license class 
- New statements to target the BIGIQ

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

 Just as before we will use VSCode to send the declaration. This time we will
 send the declaration to BIGIQ and BIGIQ will onboard the BIGIP.

 |

 Be sure to connect to the BIGIQ in VSCode before sending the declaration.

.. list-table::
   :widths: 20 40 40
   :header-rows: 1
   :stub-columns: 1

   * - **System Type**
     - **Networks**
     - **Credentials**
   * - BIGIQ
     - Management: 10.1.1.9
     - admin / @gi1ity2021  
.. image:: images/bigiq_1.png

Login into BIGIP-03 at https://10.1.1.8, and review the configurations. 

.. list-table::
   :widths: 20 40 40
   :header-rows: 1
   :stub-columns: 1

   * - **System Type**
     - **Networks**
     - **Credentials**
   * - BIGIP-03
     - Management: 10.1.1.8
     - admin / @gi1ity2020