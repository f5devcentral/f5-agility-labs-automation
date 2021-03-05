Lab 3 - Converting existing configuration to AS3 using ACC - (AS3 Configuration Converter)
==========================================================================================

ACC or AS3 Configuration Converter is another great tool from the F5 Automation Toolchain group.  This tool can help convert TMOS based applications to AS3 declarations.

This tool handles the bulk of the conversion process, but most customer configurations will require modification before deployment.

Things to keep in mind when migrating applications from TMOS to AS3:
    * Certificates/keys are not included in this process at this time
  
        * this includes any other secrets or pre-shared-keys

    * ACC/AS3 does not support ASM/APM policy converstion or deployment
    
        * AS3 supports ASM/APM policy reference
  
    * Don't forget to put the application into the appropriate tenant

#. Find and open the demo app in TMOS object form in the VSCode file explorer: ``testApp.conf``

#. Right-click in the editor, then select ``Convert with ACC``

    This process takes the text in the editor and attempts to convert it to AS3.  A new editor tab with the converted objects

    .. NOTE:: For more detailed information about the converstion process, check out the f5-chariot OUTPUT window

    .. image:: /class03/images/lab01_vscode_chariot_output.png

#. Right-click on the declaration, then select ``Inject/Remove Schema Reference``

    This process will attempt to detect what type of declaration (as3/do/ts/cf) and inject the appropriate schema reference

    The schema reference provides real-time feedback during modification or authoring process.

    https://f5devcentral.github.io/vscode-f5/#/schema_validation
