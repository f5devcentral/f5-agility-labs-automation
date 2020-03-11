Terraform Apply Step #10
========================
- Do Terraform apply to manifest the configuration

.. code-block:: shell
  
  terraform apply -auto-approve
  null_resource.download_as3: Creating...
  null_resource.download_as3: Provisioning with 'local-exec'...
  null_resource.download_as3 (local-exec): Executing: ["/bin/sh" "-c" "wget https:          //github.com/F5Networks/f5-appsvcs-extension/releases/download/v3.15.0/f5-appsvc          s-3.15.0-6.noarch.rpm"]
  null_resource.download_as3 (local-exec): --2020-02-12 19:39:22--  https://github          .com/F5Networks/f5-appsvcs-extension/releases/download/v3.15.0/f5-appsvcs-3.15.0          -6.noarch.rpm
  null_resource.download_as3 (local-exec): Resolving github.com (github.com)... 19          2.30.255.112
  null_resource.download_as3 (local-exec): Connecting to github.com (github.com)|1          92.30.255.112|:443... connected.
  null_resource.download_as3 (local-exec): HTTP request sent, awaiting response...
  null_resource.download_as3 (local-exec): 302 Found
  null_resource.download_as3 (local-exec): Location: https://github-production-rel          ease-asset-2e65be.s3.amazonaws.com/130101810/3910a100-f421-11e9-931f-177  c2d3dce0          b?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4 CSVEH53A%2F20200
  null_resource.install_as3: Still creating... [40s elapsed]
  null_resource.install_as3: Creation complete after 41s [id=5304610254458154139]
  bigip_as3.nginx: Creating...
  bigip_as3.nginx: Creation complete after 6s [id=demo]

  Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

  Outputs:

  To_Access_NGINX = http://BIG-IP-Virtual_IP:8080

