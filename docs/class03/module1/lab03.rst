Lab 3 - Converting existing configuration to AS3 using ACC - (AS3 Configuration Converter)
==========================================================================================

        ACC or AS3 Configuration Converter is another great tool from the F5 Automation Toolchain group.  This tool can help convert TMOS based applications to AS3 declarations.

        This tool handles the bulk of the conversion process, but most customer configurations **will require modification** before deployment.

        Things to keep in mind when migrating applications from TMOS to AS3:
            * Certificates/keys are not included in this process at this time
                * this includes any other secrets or pre-shared-keys
            * ACC/AS3 does not support ASM/APM policy converstion or deployment
                * AS3 supports ASM/APM policy reference
            * Don't forget to put the application into the appropriate tenant

#. In VSCODE tab select ``Explorer`` and then select ``Open Folder``. In the Open Folder dialog, type ``/home/ubuntu/project_folder/`` and select ``OK``.  
#. After the ``PROJECT_FOLDER`` has been added, select the ``files`` dropdown. 

#. Right click on bigip1.ucs and select ``Explore TMOS Config``

    .. image:: ../images/exploretmos.png
       :scale: 60%

#. Click on the F5 Extension in VSCODE and expand the ``CONFIG EXPLORER`` area.  Expand ``Partitions`` >> ``Common`` and select ``juiceshop_vs``.  Notice this is the entire configuration for the JuiceShop application, including virtual servers, pools, nodes, and iRules if any.

   .. image:: ../images/juiceshop.png
      :scale: 60%

#. Right-click in the editor, then select ``Convert with ACC``.  his process takes the text in the editor and attempts to convert it to AS3.  A new editor tab with the converted object should appear:

   .. NOTE:: In order to see the two docs side by side click on the highlighted icon in the image below, in the top right corner of VSCode.
       
   .. image:: ../images/lab01_vscode_chariot_output.png

   .. NOTE:: For more detailed information about the converstion process, check out the f5-chariot OUTPUT window

#. Right-click on the declaration (Untitled-1), then select ``Inject/Remove Schema Reference``

    This process will attempt to detect what type of declaration (as3/do/ts/cf) and inject the appropriate schema reference

    The schema reference provides real-time feedback during modification or authoring process.

    https://f5devcentral.github.io/vscode-f5/#/schema_validation


#. Modify line 10 of the AS3 declaration to publish the application to the appropriate tenant/partition.  "JuiceShop", for example.

   .. image:: ../images/accfixes.png
      :scale: 60%

#. Connect to Bigip2 (admin@10.1.1.7) and deploy the declaration by right-click, then select ``Post as AS3 declaration``. 

    The process should result in the following:

   .. image:: ../images/as3-declaration-success.png
      :scale: 60%

#. Login to the BIG-IP to confirm our changes. Go back to UDF deployment screen, and choose the component ``bigip2``.  Then choose the ``Access Method`` of ``TMUI``.  This will allow you to login to the ``BIG-IP`` GUI with userid ``admin`` and password ``admin``.

      .. image:: ../images/VSCode-bigip2_tmui_access.png
         :scale: 75%

#. Select Local Traffic, Virtual Servers.  Notice there is no virtual server listed.

#. Now go to the partitions section in the upper right corner and select the JuiceShop partition.

   .. image:: ../images/JuiceShop-partition.png
      :scale: 75%

#.  You should now see your juiceshop_vs virtual server.
