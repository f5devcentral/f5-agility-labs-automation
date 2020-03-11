Modify main.tf  #14  
==========================
- Locate the waf_http.json file which has the declaration

.. code-block:: shell

  ubuntu@ip-10-0-0-100:~/f5-as3-usecases$ ls
  example1.json                   main.tf                   terraform.tfvars
  f5-appsvcs-3.15.0-6.noarch.rpm  outputs.tf                variables.tf
  install-terraform.sh            terraform.tfstate         waf_http.json
  install_as3.sh                  terraform.tfstate.backup
  ubuntu@ip-10-0-0-100:~/f5-as3-usecases$

  vi main.tf

Replace 

.. code-block:: shell
  
  resource "bigip_as3" "nginx" {
   as3_json    = file("example1.json")
   config_name = "Sample_new"
   depends_on  = [null_resource.install_as3]
  }

With

.. code-block:: shell
  
  resource "bigip_as3" "nginx" {
   as3_json    = file("waf_http.json")
   config_name = "Sample_app_sec_02"
   depends_on  = [null_resource.install_as3]
  } 

After making cahnges to save the file main.tf use command

.. code-block:: shell
  
  !wq

The file will be saved, use key "esc" to change the mode in 'vi'  


.. Note:: the "config_name" & "as3_json" values have changed to pickup the new secured WAF Declaration

