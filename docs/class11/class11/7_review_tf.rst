Review TF files  Step #7
====================================
- Change the directory to f5-as3-usecases

.. code-block:: shell
                 
  $ cd f5-as3-usecases
    ubuntu@ip-10-0-0-100:~/f5-as3-usecases$ pwd
    /home/ubuntu/f5-as3-usecases
  $ cat main.tf
  provider "bigip" {
  address  = var.address
  username = var.username
  password = var.password
  }

  # download rpm
  resource "null_resource" "download_as3" {
  provisioner "local-exec" {
    command = "wget ${var.as3_rpm_url}"
  }
  } 

  # install rpm to BIG-IP
  resource "null_resource" "install_as3" {
  provisioner "local-exec" {
    command = "./install_as3.sh ${var.address} admin:${var.password} ${var.as3_rpm}"
  }
  depends_on = [null_resource.download_as3]
  } 

  # deploy application using as3
  resource "bigip_as3" "nginx" {
  as3_json    = file("example1.json")
  config_name = "demo"
  depends_on  = [null_resource.install_as3]
  }

Now lets understand more 

.. code-block:: shell

  provider "bigip" {  <----- BIG-IP Provider is called here "bigip"
  address  = var.address    <------- var.address is BIG-IP Mgmt variable
  username = var.username   <------- var.username is BIG-IP username
  password = var.password   <------- var.passowrd is BIG-IP password
  }
Actual values of these variables is stored in terraform.tfvars file

