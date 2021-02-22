Lab 2 - Using AS3 to Create a HTTPS application with SSL Offload
================================================================

In this portion of the lab, you will be creating an application via AS3 using the extension for ``VS CODE``.
The focus in this lab is creating an application that require SSL.  You will configure the virtual server to terminate the SSL connection and send the connection as HTTP to the application server.

HTTPS application with SSL Offload
----------------------------------

In this section we will start by using AS3 to build out a basic HTTPS application with
SSL Offload.

#. If you are not connected to ``VS CODE`` window, start the connection by clicking on ``VS CODE`` under ``client`` ``Access Methods``.

   .. image:: /class03/module1/images/AccessVScode.jpg

#. Once connected, click on the ``F5`` logo on the left-hand side of window.

   .. image:: /class03/module1/images/VScode_F5Logo.jpg

#. If ``BIG-IP`` host ``10.1.10.6`` is not listed under ``F5 HOSTS``, click on ``ADD HOST``.

   .. image:: /class03/module1/images/VScode_F5AddHost.jpg

#. When prompted, enter: admin@10.1.10.6

   .. image:: /class03/module1/images/VScode_F5AddBIGIP01.jpg

#. Now click on ``F5 -> Connect!`` at the bottom of the screen.

   .. image:: /class03/module1/images/VScode_F5Connect.jpg
  
#. When prompted choose ``admin@10.1.10.6`` from the list of choices:

   .. image:: /class03/module1/images/VScode_F5ConnectBIGIP01.jpg

#. Enter the password of ``admin`` when prompted.

#. You can confirm ``VS CODE`` is connected by looking at detail on ``F5 -> Connect!`` at bottom of screen.  In the status you can see the version of AS3 that is installed on the ``BIG-IP``.  In this case, it is version ``3.22.0``.

   .. image:: /class03/module1/images/VScode_F5ConnectedBIGIP01.jpg

#. Click ``New file`` under the ``Start`` option for ``VS CODE``:

   .. image:: /class03/module1/images/VScode_NewFile.jpg


#. Copy and paste the AS3 declaration below into the new file window.

    .. code-block:: json
        :linenos:

                    {
                      "class": "AS3",
                  "action": "deploy",
                  "persist": true,
                  "declaration": {
                    "class": "ADC",
                    "schemaVersion": "3.0.0",
                    "id": "123abc",
                    "label": "HTTPS Example",
                    "remark": "HTTPS with round-robin pool",
                    "TenantHTTPS": {
                      "class": "Tenant",
                      "A1": {
                        "class": "Application",
                        "template": "https",
                        "acmeVS": {
                          "class": "Service_HTTPS",
                          "virtualAddresses": [
                            "10.1.20.12"
                          ],
                          "pool": "web_pool",
                          "serverTLS": "webtls"
                        },
                        "web_pool": {
                          "class": "Pool",
                          "loadBalancingMode": "round-robin",
                          "monitors": [
                           "http"
                          ],
                          "members": [{
                            "servicePort": 80,
                            "shareNodes": true,
                            "serverAddresses": [
                              "10.1.10.33",
                              "10.1.10.34"
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

#. In the editing window, right click and select ``Post as AS3 declaration``.  

#. You will see a status window of the ``AS3`` declaration being sent to the ``BIG-IP``.

#. Login to the BIG-IP to confirm our changes. 

#. Login with the following credentials: username = admin , password = admin.

#. Expand Local Traffic and then Virtual Servers.  In the Partition expand
   ``TenantHTTPS``.  You should see the following:

   .. image:: /class03/module1/images/lab2-verify.png

#. In a new tab open ``http://10.1.20.101``.  This will automatically redirect
   to SSL and throw a certificate error since our cert doesn't match the
   hostname used.

#. Click through ignoring the certificate error and the application is working.


   - You can see the default values here:
     https://clouddocs.f5.com/products/extensions/f5-appsvcs-extension/latest/userguide/examples.html#example-2-https-application
