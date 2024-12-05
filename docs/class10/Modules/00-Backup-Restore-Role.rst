Use-Case 00: Backup And Restore Role
====================================

OVERVIEW
--------

This is a great example of best practices when doing major configurations with a BIG-IP. Having a backup of your previous configuration ensures that you can return to a point in time that was a known working configuration if something were to break.

Backup-Role.yaml is a templated Ansible play that utilizes an underlying Role that demonstrates the ability to backup a BIG-IP Configuration to a UCS File then download that UCS file to /tmp/Use-Case-00-backup.ucs on the local ansible box. This is to ensure a backup within the BIG-IP and a backup local to your machine.

Restore-Role.yaml is a templated Ansible play that utilizes an underlying Role that demonstrates the ability to restore a BIG-IP Configuration with the locally stored UCS File in "/tmp/Use-Case-00-backup.ucs". This play has a check to ensure that the UCS file exists before it can run a restore.

.. attention::

   The restore command will produce an error in some builds of Ansible even though the restoration does complete. It is a known bug.

RUN THE TEMPLATE
----------------

Running this template assumes that a F5 BIG-IP instance, necessary webservers and Ansible node are available. To deploy a sandbox infrastructure in AWS users can use the `Ansible Workshops <https://github.com/ansible/workshops>`__

   1. Login to the Ansible Host

   2. Change Directory in the Ansible Host to the use-cases repo previously downloaded

      .. code:: bash
      
         cd ~/f5-bd-ansible-labs/201-F5-Advanced/Modules/00-Backup-Restore-Role/

   3. **(Optional)** Edit 'f5_vars.yml' file in the vars folder to customize the existing variables. For example: File-Name: ‘mybackup.ucs'

   4. Run the Ansible Playbook ‘Backup-Role.yaml’:

      .. note:: 
         
         If you have run the modules section of this lab and already executed a backup then this run is necessary.

      .. code:: bash
      
         ansible-navigator run Backup-Role.yaml --mode stdout

      In this example, the playbook looks for the Folder-Location and File-Name variables as specified in the vars/f5_vars.yaml file and uses that information to tell the BIG-IP to run a backup and then export that file to where the Folder-Location and File-Name variables points to.

   5. **(Optional)** Run the Ansible Playbook ‘Restore-Role.yaml’:
      If you have run the AS3 section of this lab and already executed a backup and want to test the AS3 section then it is **(Recommended)** to run a restore
           
      .. code:: bash
      
         ansible-navigator run Restore-Role.yaml --mode stdout

      .. note::

         you might see an error that looks like `fatal: [f5]: FAILED! => {"changed": false, "msg": "{'code': 503, 'message': 'There is an active asynchronous task executing.', 'errorStack': [], 'apiError': 32964609}"}`  this can happen and doesnt impact the effect of the restore.  
         
         after the command is run wait up to 5 minutes for the restore to complete.

      .. note::

         after the restoration of the backup you might see notifications that the F5 needs to be rebooted, this is something that can be ignored for this lab as it has to deal with the deprovisioning of modules, it doesnt impact the lab and future runs. 

         after the command is run wait up to 5 minutes for the restore to complete.

      In this example, the playbook looks for the Folder-Location and File-Name variables as specified in the vars/f5_vars.yaml file and uses that information to upload the configuration (if exists) to the BIG-IP to run a restore.

TESTING AND VALIDATION
-----------------------

**BIG-IP CONFIGURATION VERIFICATION:**

This section is optional and for testing and verification purposes only. It assumes knowledge of how to operate BIG-IP commands and networking.



   **Ansible Host:**

   - Within a terminal window run `ls /tmp/f5/Use-Case-00-backup.ucs` to verify the backup file exists, this is also assuming that the variables file was not changed.


   **F5 BIG-IP**

   - BIG-IP - (In UDF --> Components --> BIG-IP --> Access --> TMUI)  - This will popup a webpage to access the F5 Login Page

      - Login to the BIG-IP instance  
      - Navigate to System --> Archives  
      - There should be an archive file called "Use-Case-00-backup.ucs"  

   - Login information for the BIG-IP:
   
      * username: admin 
      * password: **found in the inventory hosts file**
