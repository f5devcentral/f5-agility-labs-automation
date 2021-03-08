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

    This process takes the text in the editor and attempts to convert it to AS3.  A new editor tab with the converted object should appear

    .. NOTE:: For more detailed information about the converstion process, check out the f5-chariot OUTPUT window

    .. image:: /class03/images/lab01_vscode_chariot_output.png

#. Right-click on the declaration, then select ``Inject/Remove Schema Reference``

    This process will attempt to detect what type of declaration (as3/do/ts/cf) and inject the appropriate schema reference

    The schema reference provides real-time feedback during modification or authoring process.

    https://f5devcentral.github.io/vscode-f5/#/schema_validation

#. BONUS

    If you tried to deploy the AS3 declaration from the previous steps, it probably failed with something like:

    .. code-block:: json
        :linenos:

        {
            "id": "498aba1f-a27c-4a63-a08b-6acaae7a4c68",
            "results": [
                {
                    "code": 422,
                    "errors": [
                        "/schemaVersion: should be equal to one of the allowed values [\"3.0.0\",\"3.1.0\",\"3.2.0\",\"3.3.0\",\"3.4.0\",\"3.5.0\",\"3.6.0\",\"3.7.0\",\"3.8.0\",\"3.9.0\",\"3.10.0\",\"3.11.0\",\"3.12.0\",\"3.13.0\",\"3.14.0\",\"3.15.0\",\"3.16.0\",\"3.17.0\",\"3.18.0\",\"3.19.0\",\"3.20.0\",\"3.21.0\",\"3.22.0\"]"
                    ],
                    "declarationFullId": "",
                    "message": "declaration is invalid"
                }
            ],
            "declaration": {}
        }

    This is because the there is an older version of AS3 installed.
    
    There are two options:
        #. Change the ``schemaVersion`` in the declaration to ``3.22.0`` or less
        #. Update the installed AS3 version using the same method as we did with installing the FAST extension

        * ``F1``, ``F5: Install RPM``, select ``AS3``, then select a version (3.25.0 or newer)

