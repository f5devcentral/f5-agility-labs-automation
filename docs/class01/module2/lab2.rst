Lab 2.2: Install the AS3 Extension
----------------------------------

As mentioned previously, iControl LX Extensions are packaged using an RPM format.  We will use the REST API to install AS3 onto our BIG-IP device.

.. NOTE:: This lab work will be performed from ``Lab 2.2 - Install AS3 onto BIG-IP`` folder in the Postman Collection

   |lab-2-1|

Task 1 - View Installed iControl LX Extensions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Perform the following steps to complete this task:

#. :guilabel:`Send` the ``Step 1: Get Installed iControl LX Extensions`` request to view extensions installed on the BIG-IP device:

   |lab-2-2|

#. Review the JSON response :guilabel:`Body`.  The JSON payload shows extensions that are installed on the BIG-IP device in the ``items`` array. In this case, we have no extensions installed, so the ``items`` array is empty.

   |lab-2-3|

Task 2 - Install the AS3 Extension
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Perform the following steps to complete this task:

#. Click the ``Step 2: Upload AS3 Extension RPM`` request.

#. Click the :guilabel:`Body` tab, then click the :guilabel:`Select File` button:

   |lab-2-4|

#. Select the previously downloaded RPM file located in the ``Downloads`` folder on your Windows jump host.  Then click the :guilabel:`Send` button to upload the RPM file to the BIG-IP system:

   |lab-2-5|

#. Review the :guilabel:`Test Results` to ensure the file upload was successful:

   |lab-2-6|

#. Click the ``Step 3: Create AS3 Extension Install Task`` request and click :guilabel:`Send`.  This request will command the iControl LX framework to install the RPM uploaded in the previous step.  Because the installation task is an asynchronous operation, we need to check the status of the task in the next step.

#. Click the ``Step 4: Get AS3 Install Task Status`` request and click :guilabel:`Send`.

#. Check the **Response** :guilabel:`Body` and ensure the task ``status`` is ``FINISHED``:

   |lab-2-7|

#. Click the ``Step 5: Get AS3 Version Info`` request and click :guilabel:`Send`.  Review the **Response** :guilabel:`Body` to ensure the AS3 is installed and has started:

   |lab-2-8|

.. |lab-2-1| image:: images/lab-2-1.png
.. |lab-2-2| image:: images/lab-2-2.png
.. |lab-2-3| image:: images/lab-2-3.png
.. |lab-2-4| image:: images/lab-2-4.png
.. |lab-2-5| image:: images/lab-2-5.png
.. |lab-2-6| image:: images/lab-2-6.png
.. |lab-2-7| image:: images/lab-2-7.png
.. |lab-2-8| image:: images/lab-2-8.png
