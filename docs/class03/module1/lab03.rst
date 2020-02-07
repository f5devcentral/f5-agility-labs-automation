Lab 3 - Adding a WAF policy to an application
=============================================

This lab will be broken down to 3 parts.

#. We will apply an already existing WAF policy to an HTTPS virtual server.
#. We will apply an policy that is stored in a source repository to an HTTPS
   virtual server.
#. We will update the policy to be in blocking mode.
#. We will delete our application configurations.


Already Existing WAF policy deployment
--------------------------------------

#. If you already have a WAF policy on the BIG-IP that you would like to apply
   to your application then it is easy enough to just reference it in the AS3
   declaration in the policyWAF area.

#. In Postman select the Lab3, ``HTTPS with local WAF policy`` request.
   Notice in the body the ``policyWAF`` option.

   .. code-block:: json
      :linenos:

      {
      "class": "AS3",
      "action": "deploy",
      "persist": true,
      "syncToGroup": "/Common/failoverGroup",
      "declaration": {
         "class": "ADC",
         "schemaVersion": "3.0.0",
         "id": "123abc",
         "label": "Sample 4",
         "remark": "HTTPS with sslbridging and WAF",
         "Sample_04": {
         "class": "Tenant",
         "A1": {
               "class": "Application",
               "template": "https",
               "serviceMain": {
               "class": "Service_HTTPS",
               "virtualAddresses": [
                  "10.1.10.103"
               ],
               "pool": "web_pool",
               "policyWAF": {
                  "bigip": "/Common/test-policy"
               },
               "clientTLS": {
                  "bigip": "/Common/serverssl"
               },
               "serverTLS": "webtls"
               },
               "web_pool": {
               "class": "Pool",
               "loadBalancingMode": "predictive-node",
               "monitors": [
               "https"
               ],
               "members": [{
                  "servicePort": 443,
                  "shareNodes": true,
                  "serverAddresses": [
                  "10.1.10.31"
                  ]
               }]
               },
               "webtls": {
               "class": "TLS_Server",
               "certificates": [{
                  "certificate": "webcert"
               }]
               },
               "webcert": {
               "class": "Certificate",
               "remark": "in practice we recommend using a passphrase",
               "certificate": "-----BEGIN CERTIFICATE-----\nMIICnDCCAgWgAwIBAgIJAJ5n2b0OCEjwMA0GCSqGSIb3DQEBCwUAMGcxCzAJBgNVBAYTAlVTMRMwEQYDVQQIDApXYXNoaW5ndG9uMRAwDgYDVQQHDAdTZWF0dGxlMRQwEgYDVQQKDAtmNV9OZXR3b3JrczEbMBkGA1UEAwwSc2FtcGxlLmV4YW1wbGUubmV0MB4XDTE3MTEyNjE5NTAyNFoXDTE4MDIyNTE5NTAyNFowZzELMAkGA1UEBhMCVVMxEzARBgNVBAgMCldhc2hpbmd0b24xEDAOBgNVBAcMB1NlYXR0bGUxFDASBgNVBAoMC2Y1X05ldHdvcmtzMRswGQYDVQQDDBJzYW1wbGUuZXhhbXBsZS5uZXQwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBALEsuXmSXVQpYjrZPW+WiTBjn491mwZYT7Q92V1HlSBtM6WdWlK1aZN5sovfKtOX7Yrm8xa+e4o/zJ2QYLyyv5O+t2EGN/4qUEjEAPY9mwJdfzRQy6Hyzm84J0QkTuUJ/EjNuPji3D0QJRALUTzu1UqqDCEtiN9OGyXEkh7uvb7BAgMBAAGjUDBOMB0GA1UdDgQWBBSVHPNrGWrjWyZvckQxFYWO59FRFjAfBgNVHSMEGDAWgBSVHPNrGWrjWyZvckQxFYWO59FRFjAMBgNVHRMEBTADAQH/MA0GCSqGSIb3DQEBCwUAA4GBAJeJ9SEckEwPhkXOm+IuqfbUS/RcziifBCTmVyE+Fa/j9pKSYTgiEBNdbJeBEa+gPMlQtbV7Y2dy8TKx/8axVBHiXC5geDML7caxOrAyHYBpnx690xJTh5OIORBBM/a/NvaR+P3CoVebr/NPRh9oRNxnntnqvqD7SW0U3ZPe3tJc\n-----END CERTIFICATE-----",
               "privateKey": "-----BEGIN RSA PRIVATE KEY-----\nProc-Type: 4,ENCRYPTED\nDEK-Info: AES-256-CBC,D8FFCE6B255601587CB54EC29B737D31\n\nkv4Fc3Jn0Ujkj0yRjt+gQQfBLSNF2aRLUENXnlr7Xpzqu0Ahr3jS1bAAnd8IWnsR\nyILqVmKsYF2DoHh0tWiEAQ7/y/fe5DTFhK7N4Wml6kp2yVMkP6KC4ssyYPw27kjK\nDBwBZ5O8Ioej08A5sgsLCmglbmtSPHJUn14pQnMTmLOpEtOsu6S+2ibPgSNpdg0b\nCAJNG/KHe+Vkx59qNDyDeKb7FZOlsX30+y67zUq9GQqJEDuysPJ2BUNP0IJXAjst\nFIt1qNoZew+5KDYs7u/lPxcMGTirUhgI84Jy4WcDvSOsP/tKlxj04TbIE3epmSKy\n+TihHkwY7ngIGtcm3Sfqk5jz2RXoj1/Ac3SW8kVTYaOUogBhn7zAq4Wju6Et4hQG\nRGapsJp1aCeZ/a4RCDTxspcKoMaRa97/URQb0hBRGx3DGUhzpmX9zl7JI2Xa5D3R\nmdBXtjLKYJTdIMdd27prBEKhMUpae2rz5Mw4J907wZeBq/wu+zp8LAnecfTe2nGY\nE32x1U7gSEdYOGqnwxsOexb1jKgCa67Nw9TmcMPV8zmH7R9qdvgxAbAtwBl1F9OS\nfcGaC7epf1AjJLtaX7krWmzgASHl28Ynh9lmGMdv+5QYMZvKG0LOg/n3m8uJ6sKy\nIzzvaJswwn0j5P5+czyoV5CvvdCfKnNb+3jUEN8I0PPwjBGKr4B1ojwhogTM248V\nHR69D6TxFVMfGpyJhCPkbGEGbpEpcffpgKuC/mEtMqyDQXJNaV5HO6HgAJ9F1P6v\n5ehHHTMRvzCCFiwndHdlMXUjqSNjww6me6dr6LiAPbejdzhL2vWx1YqebOcwQx3G\n-----END RSA PRIVATE KEY-----",
               "passphrase": {
                  "ciphertext": "ZjVmNQ==",
                  "protected": "eyJhbGciOiJkaXIiLCJlbmMiOiJub25lIn0"
               }
               }
         }
         }
      }
      }

#. Click on ``Send``.

#. Confirm the results of the POST, and make sure you receive a result of 200.

#. Look at the BIG-IP configuration and select ``Local Traffic`` and
   ``Virtual Servers``.  Select the ``Sample_04`` partition.

#. Select the ``serviceMain`` virtual server, and then go to the ``Security``
   tab and see the ``test-policy`` applied to the virtual server.

   .. image:: images/lab3-waf-onbox.png

#. You can also open a tab and browse to ``https://10.1.20.103``.  We have now
   deployed the hackazon application with a WAF policy in learning mode.

WAF policy in source repository
-------------------------------

#. If you store your WAF policy in a Source Control Repository, you can assign
   it via AS3 as follows.

#. Select the ``Lab 3``, ``HTTPS with external WAF policy`` request, and look
   at the ``Body``. Notice the Policy at the bottom and the ``policyWAF``
   referencing it, with the URL for the WAF Policy file:

   The body of the post will be as follows:

   .. code-block:: json
      :linenos:

      {
      "class": "AS3",
      "action": "deploy",
      "persist": true,
      "syncToGroup": "/Common/failoverGroup",
      "declaration": {
         "class": "ADC",
         "schemaVersion": "3.0.0",
         "id": "123abc",
         "label": "Sample 4",
         "remark": "HTTPS with sslbridging and external WAF",
         "Sample_04": {
         "class": "Tenant",
         "A1": {
               "class": "Application",
               "template": "https",
               "serviceMain": {
               "class": "Service_HTTPS",
               "virtualAddresses": [
                  "10.1.10.103"
               ],
               "pool": "web_pool",
               "policyWAF": {
                  "use": "My_AWAF_Policy"
               },
               "clientTLS": {
                  "bigip": "/Common/serverssl"
               },
               "serverTLS": "webtls"
               },
               "web_pool": {
               "class": "Pool",
               "loadBalancingMode": "predictive-node",
               "monitors": [
               "https"
               ],
               "members": [{
                  "servicePort": 443,
                  "shareNodes": true,
                  "serverAddresses": [
                  "10.1.10.31"
                  ]
               }]
               },
               "webtls": {
               "class": "TLS_Server",
               "certificates": [{
                  "certificate": "webcert"
               }]
               },
               "webcert": {
               "class": "Certificate",
               "remark": "in practice we recommend using a passphrase",
               "certificate": "-----BEGIN CERTIFICATE-----\nMIICnDCCAgWgAwIBAgIJAJ5n2b0OCEjwMA0GCSqGSIb3DQEBCwUAMGcxCzAJBgNVBAYTAlVTMRMwEQYDVQQIDApXYXNoaW5ndG9uMRAwDgYDVQQHDAdTZWF0dGxlMRQwEgYDVQQKDAtmNV9OZXR3b3JrczEbMBkGA1UEAwwSc2FtcGxlLmV4YW1wbGUubmV0MB4XDTE3MTEyNjE5NTAyNFoXDTE4MDIyNTE5NTAyNFowZzELMAkGA1UEBhMCVVMxEzARBgNVBAgMCldhc2hpbmd0b24xEDAOBgNVBAcMB1NlYXR0bGUxFDASBgNVBAoMC2Y1X05ldHdvcmtzMRswGQYDVQQDDBJzYW1wbGUuZXhhbXBsZS5uZXQwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBALEsuXmSXVQpYjrZPW+WiTBjn491mwZYT7Q92V1HlSBtM6WdWlK1aZN5sovfKtOX7Yrm8xa+e4o/zJ2QYLyyv5O+t2EGN/4qUEjEAPY9mwJdfzRQy6Hyzm84J0QkTuUJ/EjNuPji3D0QJRALUTzu1UqqDCEtiN9OGyXEkh7uvb7BAgMBAAGjUDBOMB0GA1UdDgQWBBSVHPNrGWrjWyZvckQxFYWO59FRFjAfBgNVHSMEGDAWgBSVHPNrGWrjWyZvckQxFYWO59FRFjAMBgNVHRMEBTADAQH/MA0GCSqGSIb3DQEBCwUAA4GBAJeJ9SEckEwPhkXOm+IuqfbUS/RcziifBCTmVyE+Fa/j9pKSYTgiEBNdbJeBEa+gPMlQtbV7Y2dy8TKx/8axVBHiXC5geDML7caxOrAyHYBpnx690xJTh5OIORBBM/a/NvaR+P3CoVebr/NPRh9oRNxnntnqvqD7SW0U3ZPe3tJc\n-----END CERTIFICATE-----",
               "privateKey": "-----BEGIN RSA PRIVATE KEY-----\nProc-Type: 4,ENCRYPTED\nDEK-Info: AES-256-CBC,D8FFCE6B255601587CB54EC29B737D31\n\nkv4Fc3Jn0Ujkj0yRjt+gQQfBLSNF2aRLUENXnlr7Xpzqu0Ahr3jS1bAAnd8IWnsR\nyILqVmKsYF2DoHh0tWiEAQ7/y/fe5DTFhK7N4Wml6kp2yVMkP6KC4ssyYPw27kjK\nDBwBZ5O8Ioej08A5sgsLCmglbmtSPHJUn14pQnMTmLOpEtOsu6S+2ibPgSNpdg0b\nCAJNG/KHe+Vkx59qNDyDeKb7FZOlsX30+y67zUq9GQqJEDuysPJ2BUNP0IJXAjst\nFIt1qNoZew+5KDYs7u/lPxcMGTirUhgI84Jy4WcDvSOsP/tKlxj04TbIE3epmSKy\n+TihHkwY7ngIGtcm3Sfqk5jz2RXoj1/Ac3SW8kVTYaOUogBhn7zAq4Wju6Et4hQG\nRGapsJp1aCeZ/a4RCDTxspcKoMaRa97/URQb0hBRGx3DGUhzpmX9zl7JI2Xa5D3R\nmdBXtjLKYJTdIMdd27prBEKhMUpae2rz5Mw4J907wZeBq/wu+zp8LAnecfTe2nGY\nE32x1U7gSEdYOGqnwxsOexb1jKgCa67Nw9TmcMPV8zmH7R9qdvgxAbAtwBl1F9OS\nfcGaC7epf1AjJLtaX7krWmzgASHl28Ynh9lmGMdv+5QYMZvKG0LOg/n3m8uJ6sKy\nIzzvaJswwn0j5P5+czyoV5CvvdCfKnNb+3jUEN8I0PPwjBGKr4B1ojwhogTM248V\nHR69D6TxFVMfGpyJhCPkbGEGbpEpcffpgKuC/mEtMqyDQXJNaV5HO6HgAJ9F1P6v\n5ehHHTMRvzCCFiwndHdlMXUjqSNjww6me6dr6LiAPbejdzhL2vWx1YqebOcwQx3G\n-----END RSA PRIVATE KEY-----",
               "passphrase": {
                  "ciphertext": "ZjVmNQ==",
                  "protected": "eyJhbGciOiJkaXIiLCJlbmMiOiJub25lIn0"
               }
               },
               "My_AWAF_Policy": {
                  "class": "WAF_Policy",
                  "ignoreChanges": false,
                  "url": "https://raw.githubusercontent.com/Larsende/Agility2020-AS3/masterimages/Common_test_policy__2020-1-13_9-38-13__bigip02.as3lab.com.xml"
               }
         }
         }
      }
      }

#. Click on ``Send``.  

#. Confirm the results of the POST, and make sure you receive a result of 200.

#. If you go to ``/Security/Application Security/Security Policies`` and then
   select the ``Sample_04`` partition, you will notice there are two security
   policies.  One in the ``Common`` partition and one in the ``Sample_04``
   partition.  The ``Sample_04`` instance is named ``My_AWAF_Policy``.

   Also notice in the Virtual Server Security settings that the new
   ``My_AWAF_Policy`` is applied to the ``serviceMain`` virtual server instead
   of the test-policy.

Setting WAF policy to Blocking mode:
------------------------------------

#. Select the ``Lab 3``, ``BIG-IP: HTTPS with external WAF policy in blocking
   mode``, and look at the ``Body``.

   In order to set blocking mode we can override what is defined in the Policy
   with an additional enforcementMode option in our WAF Policy declaration:

   .. code-block:: json
      :linenos:

      {
      "class": "AS3",
      "action": "deploy",
      "persist": true,
      "syncToGroup": "/Common/failoverGroup",
      "declaration": {
         "class": "ADC",
         "schemaVersion": "3.0.0",
         "id": "123abc",
         "label": "Sample 4",
         "remark": "HTTPS with sslbridging and external WAF",
         "Sample_04": {
         "class": "Tenant",
         "A1": {
               "class": "Application",
               "template": "https",
               "serviceMain": {
               "class": "Service_HTTPS",
               "virtualAddresses": [
                  "10.1.10.103"
               ],
               "pool": "web_pool",
               "policyWAF": {
                  "use": "My_AWAF_Policy"
               },
               "clientTLS": {
                  "bigip": "/Common/serverssl"
               },
               "serverTLS": "webtls"
               },
               "web_pool": {
               "class": "Pool",
               "loadBalancingMode": "predictive-node",
               "monitors": [
               "https"
               ],
               "members": [{
                  "servicePort": 443,
                  "shareNodes": true,
                  "serverAddresses": [
                  "10.1.10.31"
                  ]
               }]
               },
               "webtls": {
               "class": "TLS_Server",
               "certificates": [{
                  "certificate": "webcert"
               }]
               },
               "webcert": {
               "class": "Certificate",
               "remark": "in practice we recommend using a passphrase",
               "certificate": "-----BEGIN CERTIFICATE-----\nMIICnDCCAgWgAwIBAgIJAJ5n2b0OCEjwMA0GCSqGSIb3DQEBCwUAMGcxCzAJBgNVBAYTAlVTMRMwEQYDVQQIDApXYXNoaW5ndG9uMRAwDgYDVQQHDAdTZWF0dGxlMRQwEgYDVQQKDAtmNV9OZXR3b3JrczEbMBkGA1UEAwwSc2FtcGxlLmV4YW1wbGUubmV0MB4XDTE3MTEyNjE5NTAyNFoXDTE4MDIyNTE5NTAyNFowZzELMAkGA1UEBhMCVVMxEzARBgNVBAgMCldhc2hpbmd0b24xEDAOBgNVBAcMB1NlYXR0bGUxFDASBgNVBAoMC2Y1X05ldHdvcmtzMRswGQYDVQQDDBJzYW1wbGUuZXhhbXBsZS5uZXQwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBALEsuXmSXVQpYjrZPW+WiTBjn491mwZYT7Q92V1HlSBtM6WdWlK1aZN5sovfKtOX7Yrm8xa+e4o/zJ2QYLyyv5O+t2EGN/4qUEjEAPY9mwJdfzRQy6Hyzm84J0QkTuUJ/EjNuPji3D0QJRALUTzu1UqqDCEtiN9OGyXEkh7uvb7BAgMBAAGjUDBOMB0GA1UdDgQWBBSVHPNrGWrjWyZvckQxFYWO59FRFjAfBgNVHSMEGDAWgBSVHPNrGWrjWyZvckQxFYWO59FRFjAMBgNVHRMEBTADAQH/MA0GCSqGSIb3DQEBCwUAA4GBAJeJ9SEckEwPhkXOm+IuqfbUS/RcziifBCTmVyE+Fa/j9pKSYTgiEBNdbJeBEa+gPMlQtbV7Y2dy8TKx/8axVBHiXC5geDML7caxOrAyHYBpnx690xJTh5OIORBBM/a/NvaR+P3CoVebr/NPRh9oRNxnntnqvqD7SW0U3ZPe3tJc\n-----END CERTIFICATE-----",
               "privateKey": "-----BEGIN RSA PRIVATE KEY-----\nProc-Type: 4,ENCRYPTED\nDEK-Info: AES-256-CBC,D8FFCE6B255601587CB54EC29B737D31\n\nkv4Fc3Jn0Ujkj0yRjt+gQQfBLSNF2aRLUENXnlr7Xpzqu0Ahr3jS1bAAnd8IWnsR\nyILqVmKsYF2DoHh0tWiEAQ7/y/fe5DTFhK7N4Wml6kp2yVMkP6KC4ssyYPw27kjK\nDBwBZ5O8Ioej08A5sgsLCmglbmtSPHJUn14pQnMTmLOpEtOsu6S+2ibPgSNpdg0b\nCAJNG/KHe+Vkx59qNDyDeKb7FZOlsX30+y67zUq9GQqJEDuysPJ2BUNP0IJXAjst\nFIt1qNoZew+5KDYs7u/lPxcMGTirUhgI84Jy4WcDvSOsP/tKlxj04TbIE3epmSKy\n+TihHkwY7ngIGtcm3Sfqk5jz2RXoj1/Ac3SW8kVTYaOUogBhn7zAq4Wju6Et4hQG\nRGapsJp1aCeZ/a4RCDTxspcKoMaRa97/URQb0hBRGx3DGUhzpmX9zl7JI2Xa5D3R\nmdBXtjLKYJTdIMdd27prBEKhMUpae2rz5Mw4J907wZeBq/wu+zp8LAnecfTe2nGY\nE32x1U7gSEdYOGqnwxsOexb1jKgCa67Nw9TmcMPV8zmH7R9qdvgxAbAtwBl1F9OS\nfcGaC7epf1AjJLtaX7krWmzgASHl28Ynh9lmGMdv+5QYMZvKG0LOg/n3m8uJ6sKy\nIzzvaJswwn0j5P5+czyoV5CvvdCfKnNb+3jUEN8I0PPwjBGKr4B1ojwhogTM248V\nHR69D6TxFVMfGpyJhCPkbGEGbpEpcffpgKuC/mEtMqyDQXJNaV5HO6HgAJ9F1P6v\n5ehHHTMRvzCCFiwndHdlMXUjqSNjww6me6dr6LiAPbejdzhL2vWx1YqebOcwQx3G\n-----END RSA PRIVATE KEY-----",
               "passphrase": {
                  "ciphertext": "ZjVmNQ==",
                  "protected": "eyJhbGciOiJkaXIiLCJlbmMiOiJub25lIn0"
               }
               },
               "My_AWAF_Policy": {
                  "class": "WAF_Policy",
                  "url": "https://raw.githubusercontent.com/Larsende/Agility2020-AS3/masterimages/Common_test_policy__2020-1-13_9-38-13__bigip02.as3lab.com.xml",
                  "ignoreChanges": false,
                  "enforcementMode": "blocking",
                  "serverTechnologies": [
                     "PHP",
                     "MySQL"
                  ]
               }
         }
         }
      }
      }

#. Click on ``Send``.

#. Confirm the results of the POST, and make sure you receive a result of 200.

#. Now go to the BIG-IP configuration and look at the Security Policies.
   Select the ``My_AWAF_Policy`` and look at the Enforcement Mode.

   .. image:: images/lab3-blocking.png

Delete the Applications deployed
--------------------------------

#. This time we will delete all the AS3 declarations that are currently
   deployed.

#. In Postman open the ``Getting Started`` section.

#. Select the ``BIG-IP: Delete ALL declarations`` declaration, and look at the
   ``Body`` of the declaration.

#. In this instance we are setting the Action to ``remove``.  Also notice that
   we set a ``syncToGroup`` option in order to cause the HA pair to sync
   configurations.
