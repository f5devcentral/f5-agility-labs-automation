Review Infrastructure 
=====================
- You can login into the F5 BIG-IP using Public IP & Random password generated
- From the ubuntu machine (not the Jump box) give the command as shown below

.. code-block:: shell

  ubuntu@ip-10-1-1-4:~/FAS-provisoner-terraform$ terraform output
  F5_IP = 44.232.118.1
  F5_Password = 6OMcpiWXl3
  To_SSH_into_fas_ubuntu = ssh -i terraform-20200211233802558000000001.pem ubuntu@34.219.56.213
  ec2_ip = 34.219.56.213
  f5_ui = https://44.232.118.1:8443
  my_key = terraform-20200211233802558000000001.pem


Open the browser do  https://F5_IP:8443 and password is F5_Password shown above To ssh Jump Box use the above "To_SSH_into_fas_ubuntu" values.

.. image:: ../images/f5.png

