Secure Your App #13  
=====================

#### Before working on this section please make sure you have completed Step 12.2 ####
---------------------------------------------------------------------------------------

- This section contains declarations that aim to secure your Application using ASM WAF

To secure the application ASM module or BIG-IP Application Security Manager is used. If you need to read more aboput ASM module please refer to https://techdocs.f5.com/kb/en-us/products/big-ip_asm/manuals/product/asm-implementations-13-1-0.html

- Virtual service referencing an external security policy

This example creates an HTTP service, and attaches a Web Application Firewall (WAF) security policy hosted in an external location. See the BIG-IP ASM Implementations Guide for information on configuring security policies, and the Exporting ASM Policies chapter for information on exporting policies.

Note the URL in the following declaration does not resolve, you need to use a valid URL where you have uploaded the ASM policy you exported from a BIG-IP system. In this example we have a test policy located at https://raw.githubusercontent.com/scshitole/more-terraform/master/Sample_app_sec_02_waf_policy.xml


This declaration creates the following objects on the BIG-IP:
- Partition (tenant) named Sample_app_sec_02.
- A virtual server named serviceMain.
- A pool named Pool1 monitored by the default http health monitor.
- An LTM policy named _WAF__HTTP_Service which references the external ASM policy via URL.

.. code-block:: shell

  {
  "class": "ADC",
  "schemaVersion": "3.2.0",
  "id": "5489432",
  "label": "ASM_policy_external_URL",
  "remark": "ASM_policy_external_URL",
  "Sample_app_sec_02": {
    "class": "Tenant",
    "HTTP_Service": {
      "class": "Application",
      "template": "http",
      "serviceMain": {
        "class": "Service_HTTP",
        "virtualPort": 8080,
        "virtualAddresses": [
          "10.0.0.200"
        ],
        "snat": "auto",
        "pool": "Pool1",
        "policyWAF": {
          "use": "My_ASM_Policy"
        }
      },
      "Pool1": {
        "class": "Pool",
        "monitors": [
          "http"
        ],
        "members": [
          {
            "servicePort": 80,
            "serverAddresses": [
              "10.0.0.172"
            ]
          },
          {
            "servicePort": 80,
            "serverAddresses": [
              "10.0.0.173"
            ]
          }
        ]
      },
      "My_ASM_Policy": {
        "class": "WAF_Policy",
        "url": "https://raw.githubusercontent.com/scshitole/more-terraform/master/Sample_app_sec_02_waf_policy.xml",
        "ignoreChanges": true
      }
    }
  }
  }



.. Note:: Policy name is My_ASM_Policy
