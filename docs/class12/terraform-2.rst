Terraform: Step #2
==================

After you complete Step #1 you should see URLs for Consul and BIG-IP.

.. image:: ./images/terraform-1-complete.png

Visit these URLS.

Consul
------

.. image:: ./images/terraform-2-consul.png

BIG-IP
------

.. image:: ./images/terraform-2-big-ip.png

Install AS3
-----------

On the Ubuntu host run the following commands

.. code-block:: shell
  
  $ cd ~/f5-terraform-consul-sd-webinar/as3/
  $ terraform init
  $ terraform plan
  $ terraform apply
  
In this scenario we are executing a shell script that will install AS3 and deploy the "nginx.json" 
declaration that is configure to use Consul's API for service discovery.

You should see the following output.

.. image:: ./images/terraform-2-as3-installed.png

Follow the URL and you should see NGINX.

.. image:: ./images/terraform-2-nginx-1.png
