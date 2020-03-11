Terraform Commands #9
=====================
- How to Check Terraform Version

.. code-block:: shell
  
  terraform version
  Terraform v0.12.20
  + provider.bigip v1.1.1
  + provider.null v2.1.2

When we do "terraform version" it list out terraform version being used which 0.12.20, 
It also provides information of BIG-IP Terraform Provider Version which v1.1.1


.. code-block:: shell

 terraform plan
 Refreshing Terraform state in-memory prior to plan...
 The refreshed state will be used to calculate this plan, but will not be
 persisted to local or remote state storage.


 ------------------------------------------------------------------------

 An execution plan has been generated and is shown below.
 Resource actions are indicated with the following symbols:
  + create

 Terraform will perform the following actions:

  # bigip_as3.nginx will be created
  + resource "bigip_as3" "nginx" {
      + as3_json    = jsonencode(
            {
              + action      = "deploy"
              + class       = "AS3"
              + declaration = {
                  + Sample_new    = {
                      + Application_1      = {
                          + class       = "Application"
                          + serviceMain = {
                              + class            = "Service_HTTP"
                              + pool             = "web_pool"
                              + virtualAddresses = [
                                  + "10.0.0.200",
                                ]
                              + virtualPort      = 8080
                            }
                          + template    = "http"
                          + web_pool    = {
                              + class    = "Pool"
                              + members  = [
                                  + {
                                      + serverAddresses = [
                                          + "10.0.0.172",
                                          + "10.0.0.173",
                                        ]
                                      + servicePort     = 80
                                    },
                                ]
                              + monitors = [
                                  + "http",
                                ]
                            }
                        }
                      + class              = "Tenant"
                      + defaultRouteDomain = 0
                    }
                  + class         = "ADC"
                  + id            = "example-declaration-01"
                  + label         = "Sample 1"
                  + remark        = "Simple HTTP application with round robin pool"
                  + schemaVersion = "3.0.0"
                }
              + persist     = true
            }
        )
      + config_name = "demo"
      + id          = (known after apply)
    }

  # null_resource.download_as3 will be created
  + resource "null_resource" "download_as3" {
      + id = (known after apply)
    }

  # null_resource.install_as3 will be created
  + resource "null_resource" "install_as3" {
      + id = (known after apply)
    }

  Plan: 3 to add, 0 to change, 0 to destroy.

  ------------------------------------------------------------------------

  Note: You didn't specify an "-out" parameter to save this plan, so Terraform
  can't guarantee that exactly these actions will be performed if
  "terraform apply" is subsequently run.
 
  terraform validate
  Success! The configuration is valid.

