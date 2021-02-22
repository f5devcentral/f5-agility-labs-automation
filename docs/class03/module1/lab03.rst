Lab 3 - Converting existing configuration to AS3 using ACC - (AS3 Configuration Converter)
==========================================================================================




F5 Devices
---

F5 Device connection information for reference in the following tasks

bigip1 - mgmt - 10.1.1.6 - admin/admin



Quick FAST YAML Template
---

#. Connect to bigip1 in the vscode-f5 extension

#. Click on the ``bigip1.f5demos.com`` at the bottom of the window

    This shows the ``/mgmt/shared/identified-devices/config/device-info`` output, but also provides a json editor

#. Select All, delete.

    We need to delete all the next in the window to prepare for the next step

#. Type ``as`` and select the ``as3-sample_01`` that pops up from the text in the editor

    This flow should result in an example AS3 declaration that can be easiliy modified and deployed (might have seen it in the last lab)

#. Convert AS3 to FAST YAML

    Make sure nothing is highlighted in the editor, right-click, and select ``AS3 -> FAST YAML``

    This command should take the AS3 declaration in the editor, confirm it is a valid JSON object and wrap the entire declaration in the necessary paramters for a FAST YAML template

    .. NOTE:: YAML files for FAST templates is the recommended route since they provide an interface for customizing UI elements of the template

    .. NOTE:: Notice how the "tenant" definition has already been replaced with a FAST template string in line 22

#. Post as FAST template to F5

    Press ``F1``, type ``f5 fast``, then select ``F5-FAST: Post Template``

    See the pop-up at the top of the screen, enter to accept the default folder and template names

    This will take the text in the current editor and upload it as a FAST template to the connected F5.

    .. NOTE:: Like AS3 tenants, uploading a new template to an existing templates folder will over write all other templates.  Templates should be managed as "sets".  This individual template flow is just for development and testing of templates

    Once the process is complete, check the FAST view or the TMUI for the template we just uploaded



EXTRA: Render YAML template locally
---

    Using the same editor window with the YAML FAST Template, there is a was to test the rendered HTML output before uploading to an F5

    With nothing selected, right-click, then select ``Render FAST Template HTML Preview``

    This process will take the FAST template in the editor, and render the HTML output.

    This command can also be access from the F5 FAST view under templates, which will download a template from the F5 and render the the HTML preview locally.

    .. NOTE:: Rendering a FAST Template from an F5 only works when the template is self contained, meaning it doesn't reference any other files for schema or validation


EXTRA:  Render output of HTML Preview


