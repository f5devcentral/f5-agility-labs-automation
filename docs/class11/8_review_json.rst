Review AS3 Declarative JSON  Step #8
====================================
- While remianing in the same directory f5-as3-usecases display the example.json

.. code-block:: shell
   
   cat example1.json
   {
   "class": "AS3",
   "action": "deploy",
   "persist": true,
   "declaration": {
     "class": "ADC",
         "schemaVersion": "3.0.0",
         "id": "example-declaration-01",
         "label": "Sample 1",
         "remark": "Simple HTTP application with round robin pool",
         "Sample_new": {
             "class": "Tenant",
             "defaultRouteDomain": 0,
             "Application_1": {
                 "class": "Application",
                 "template": "http",
             "serviceMain": {
                 "class": "Service_HTTP",
                 "virtualPort": 8080,
                 "virtualAddresses": [
                     "10.0.0.200"
                 ],
                 "pool": "web_pool"
                 },
                 "web_pool": {
                     "class": "Pool",
                     "monitors": [
                         "http"
                     ],
                      "members": [
                         {
                             "servicePort": 80,
                             "serverAddresses": [
                                 "10.0.0.172",
                                 "10.0.0.173"
                             ]
                         }
                     ]
                 }
             }
         }
      }
      }
.. note:: The "10.0.0.172" and "10.0.0.173" these are the nginx server node members of "web_pool". Port "8080" shown in green is the Virtual IP Port, "10.0.0.200" is the Virtual Server IP which will be mapped to Public IP.

