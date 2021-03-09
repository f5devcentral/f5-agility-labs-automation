Lab 1 Configure Standalone BIG-IP with Declarative Onboarding
==============================================================

In this lab we will use the F5 VSCode extenion to install Declarative 
Onboarding (DO). For other installation options please see appendix A.

Before we jump into Declarative Onboarding (DO) lets take a look at the current
state of one of our BIG-IP appliances.

#. Login to **BIGIP-01** and notice that it is not licensed and nothing has been
   provisioned.  Also notice the hostname in the upper left hand corner.

   .. note :: Username and password are: **admin/@gility2021**

   .. image:: images/bigip01_01.png

#. In order to install Declarative Onboarding using the VSCode extension we
   need to add our BIG-IP devices to VSCode.

   Within the VSCode window click on the ``F5 Extension icon`` then click
   ``ADD HOST`` in the ``F5 HOSTS`` window.

   .. image:: images/f5_extension_add_host_01.png

   Within the add host prompt add each BIG-IP using the username\@X.X.X.X format
   and press enter.

   .. note :: Username and password are: **admin/@gility2021**

   .. image:: images/f5_extension_add_host_02.png

   Lastly, click the device you just added enter in the password to connect to
   the device.

   .. image:: images/f5_extension_add_host_03.png

   .. note:: Once you have successfully connected and authenticated to the 
      BIG-IP device you will notice that the bottom of your VSCode window 
      will show the version of Declarative Onboarding that is installed 
      (as well as other components).

   .. image:: images/do_version.png

   .. note:: Be sure to add all three BIG-IPs and BIG-IQ to the F5 VSCode 
      extension.

   Once the device has been added, select **BIGIP-01**. 
      - Press **F1** your keyboard (this opens the command palette).
      - Type **F5** (this will filter the F5 commands)
      
      .. image:: images/do_install_01.png

      - Select **Install RPM**
  
      .. image:: images/do_install_02.png

      - Select **DO**
  
      .. image:: images/do_install_03.png

      - Then select the latest version of DO
  
      .. image:: images/do_install_04.png

      .. note:: At this point you will see several prompts in the bottom right 
         hand corner of VSCode indicating the DO is being installed.
         (similar to the images below) 
        
         .. image:: images/do_install_05.png

      - Proceed to install DO on the other three BIG-IPs. BIG-IQ already has DO
        installed.

   .. attention:: The BIG-IQ device already has DO installed, theres no need to
      attempt to install DO on the BIG-IQ device.


#. With the Declarative Onboarding (DO) package now installed on BIG-IP, we are 
   ready to build out our first BIG-IP.

   The desired end state of these DO declarations is to configure the objects
   below, built on the BIG-IPs with a single call in a single file.  This
   declarative solution allows us to compose configurations that are reusable 
   with templating technologies and storable in Source Control.

   We will use VSCode to send our declaration to **BIGIP-01**.

   In our first declaration we will configure the following items on the BIG-IP:

   - Licensing
   - Credentials
   - Provisioning
   - DNS
   - NTP
   - Self-IPs
   - Vlans

   Copy the Declarative Onboarding (DO) declaration below.
   Use the copy button in the upper left hand corner of the declaration.

   .. code-block:: JSON

    {
        "$schema": "https://raw.githubusercontent.com/F5Networks/f5-declarative-onboarding/master/src/schema/latest/base.schema.json",
        "schemaVersion": "1.9.0",
        "class": "Device",
        "async": true,
        "label": "my BIG-IP declaration for declarative onboarding",
        "Common": {
            "class": "Tenant",
            "hostname": "bigip-01.compute.internal",
            "myLicense": {
                "class": "License",
                "licenseType": "regKey",
                "regKey": "E7135-74831-26771-18995-6988851",
                "overwrite": false
            },
            "myDns": {
                "class": "DNS",
                "nameServers": [
                    "10.1.255.254",
                    "8.8.8.8",
                    "2001:4860:4860::8844"
                ],
                "search": [
                    "us-west-2-compute.internal",
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
            "anotheradmin": {
                "class": "User",
                "userType": "regular",
                "password": "Fu11Pr0%y",
                "shell": "bash"
            },
            "guestUser": {
                "class": "User",
                "userType": "regular",
                "password": "Fu11Pr0%y",
                "partitionAccess": {
                    "Common": {
                        "role": "guest"
                    }
                }
            },
            "anotherUser": {
                "class": "User",
                "userType": "regular",
                "password": "Fu11Pr0%y",
                "shell": "none",
                "partitionAccess": {
                    "all-partitions": {
                        "role": "guest"
                    }
                }
            },
            "myProvisioning": {
                "class": "Provision",
                "ltm": "nominal",
                "gtm": "minimum"
            },
            "internal": {
                "class": "VLAN",
                "tag": 4093,
                "mtu": 1500,
                "interfaces": [
                    {
                        "name": "1.1",
                        "tagged": false
                    }
                ],
                "cmpHash": "dst-ip"
            },
            "internal-self": {
                "class": "SelfIp",
                "address": "10.1.10.100/24",
                "vlan": "internal",
                "allowService": "default",
                "trafficGroup": "traffic-group-local-only"
            },
            "internal-floating": {
                "class": "SelfIp",
                "address": "10.1.10.120/24",
                "vlan": "internal",
                "allowService": "default",
                "trafficGroup": "traffic-group-1"
            },
            "external": {
                "class": "VLAN",
                "tag": 4094,
                "mtu": 1500,
                "interfaces": [
                    {
                        "name": "1.2",
                        "tagged": false
                    }
                ],
                "cmpHash": "src-ip"
            },
            "external-self": {
                "class": "SelfIp",
                "address": "10.1.20.100/24",
                "vlan": "external",
                "allowService": "none",
                "trafficGroup": "traffic-group-local-only"
            },
            "external-floating": {
                "class": "SelfIp",
                "address": "10.1.20.120/24",
                "vlan": "external",
                "allowService": "default",
                "trafficGroup": "traffic-group-1"
            },
            "default": {
                "class": "Route",
                "gw": "10.1.10.1",
                "network": "default",
                "mtu": 1500
            },
            "configsync": {
                "class": "ConfigSync",
                "configsyncIp": "/Common/internal-self/address"
            },
            "failoverAddress": {
                "class": "FailoverUnicast",
                "address": "/Common/internal-self/address"
            },
            "failoverGroup": {
                "class": "DeviceGroup",
                "type": "sync-failover",
                "members": [
                    "bigip-01.compute.internal",
                    "bigip-02.compute.internal"
                ],
                "owner": "/Common/failoverGroup/members/0",
                "autoSync": true,
                "saveOnAutoSync": false,
                "networkFailover": true,
                "fullLoadOnSync": false,
                "asmSync": false
            },
            "trust": {
                "class": "DeviceTrust",
                "localUsername": "admin",
                "localPassword": "@gi1ity2021",
                "remoteHost": "/Common/failoverGroup/members/0",
                "remoteUsername": "admin",
                "remotePassword": "@gi1ity2021"
            }
        }
    }

   .. note:: F5 publishes a schema for each of the Automation Toolchain items. This
      published schema can be used in Visual Studio Code allowing you to see context
      and find errors within your different declarations. The schema reference is
      added at the top of your declaration, and requires vscode to know the language
      is JSON.

#. We wiil now use Visual Studio Code to validate our declaraion.

   Open Visual Studio Code on and open a New File. To open a new file click the
   hamburger icon, hover over ``File`` and select ``New File``.

   .. image:: images/vscode_newfile.png

   .. attention:: Once you have a new file open paste all of the DO declaration
      contents. Additionally, the language setting in VSCode must be set to 
      JSON. In the bottom right on the VSCode screen, click ``plain text``. 
      Then in the language mode screen type ``JSON``.

      .. image:: images/schema_validation_01.png

   Once the declaration and language are set, you can highlight over sections
   of the code to see context and errors

   .. image:: images/schema_context_01.png

   .. note::  Now that you've added the schema validation to your JSON declaration
      you can try misspelling some of the declaration objects to see errors,
      remember to  revert your changes.

#. We are now ready to send our declaration to **BIGIP-01**

   Right click in the file editor of VSCode and select ``Post DO Declaration``.

   .. image:: images/post_do_declaration.png

   .. note::

      In the bottom right hand corner of VSCode you should see that the DO 
      declaration is processing.

      .. image:: images/do_declaration_processing.png

   After a few moments you will receive a second tab in VSCode that shows that the
   declaration is running.

   .. image:: images/do_declaration_status_01.png

   To know when the BIG-IP is finished processing the declaration click the DO
   version on the status bar of VSCode.

   .. image:: images/do_version.png

   When complete, you should receive a 200 response code, a status of OK and a
   message of success

   .. image:: images/do_declaration_status_02.png

#. Once the BIG-IP has finished processing the declaration, login to
   **BIGIP-01** and notice the host name has changed and the device is now
   licensed.

   .. note :: Username and password are: **admin/@gility2021**

   .. image:: images/bigip01_02.png

   Futhermore, take a look at the following settings on **BIGIP-01** to see what
   all was configured with Declarative Onboarding (DO)

   - Credentials
   - Provisioning
   - DNS
   - NTP
   - Self-IPs
   - Vlans