Lab 1.6: Build a Basic LTM Config using REST Transactions
---------------------------------------------------------

In this lab, we will build a basic LTM Config using iControlRest Transactions.

Task 1 - Create a Transaction
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Transactions are beneficial in cases where you would like to have discrete REST operations to act as a batch operation. As a result, the nature of a transaction is that either all the operations succeed or none of them do (all-or-nothing). This is very useful when we are creating a configuration that is linked together because it allows the rollback of operations in case one fails.  All the commands issued are queued one after the other in the Transaction. We will also review how to change the order of a queued command or remove a single command from the queued list before committing.

.. NOTE:: Transactions are essential to ensure that an Imperative process is **Atomic** in nature.

.. WARNING:: Transactions have a default timeout of 120 seconds.  Taking longer than the timeout period to execute a transaction will result in the automatic deletion of the Transaction.  **To avoid having to redo the steps in this task, please first read through the steps below and execute each of them promptly.**

Perform the following steps to complete this task:

#. Expand the ``Lab 1.6 - Build a Basic LTM Config using Transactions`` folder in the Postman collection:

   |lab-7-1|

#. Click the ``Step 1: Create a Transaction`` request. Examine the URL and JSON :guilabel:`Body`. We will send a ``POST`` to the ``/mgmt/tm/transaction`` endpoint with an empty JSON body to create a new transaction.

   |lab-7-2|

#. Click the :guilabel:`Send` button to send the request. Examine the response and find the ``transId`` attribute.  Additionally, notice that there are timeouts for both the submission of the Transaction and how long it would take to execute. Please be aware that upon exceeding the ``timeoutSeconds`` period, the ``transId`` will be silently removed:

   |lab-7-3|

   The ``transId`` value has been automatically populated for you in the
   ``bigip_transaction_id`` environment variable:

   |lab-7-4|

#. Click the ``Step 2: Add to Transaction: Create a HTTP Monitor`` request in the folder. This request is similar to a non-transaction enabled request in terms of the ``POST`` request method, URI, and JSON body. The difference is that a header named ``X-F5-REST-Coordination-Id`` with the value of the ``transId`` attribute is added to the Transaction:

   |lab-7-5|

#. Click the :guilabel:`Send` button and examine the response.

#. Examine and click :guilabel:`Send` on **Steps 3-6** in the folder.

#. Click ``Step 7: View the Transaction Queue``. Examine the request type and URI and click :guilabel:`Send`. This request allows you to see the current list of ordered commands in the Transaction.

Task 2 - Modify a Transaction
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Click the ``Step 8: View Queued Command 4 from Transaction`` request in the folder. Examine the request method and URI. We will ``GET`` command number **4** from the transaction queue.

   |lab-7-7|

#. Click the ``Step 9: Change Eval Order 4 -> 1`` request in the folder. Examine the request method, URI, JSON body, then click :guilabel:`Send`. We will PATCH our transaction resource and change the value of the ``evalOrder`` attribute from ``4`` to ``1`` to move to the first position of the transaction queue:

   |lab-7-8|

   .. NOTE:: Requests in the ordered transaction queue must obey the order of operations present in the underlying BIG-IP system.

   .. WARNING:: When sending the Header ``X-F5-REST-Coordination-Id``, the system assumes that you want to **ADD** an entry in the transaction queue. You **MUST** remove this header if you want to issue any other transaction queue changes (such as deleting an entry from the queue, changing the order, or committing a transaction). If you fail to remove the header, the system will respond with a ``400`` HTTP error code with the following error text:

      ``"message": "Transaction XXXXX operation .... is not allowed
      to be added to Transaction."``



#. Click the ``Step 10: View the Transaction Queue Changes`` request in the folder. Verify that command number ``4`` has moved into position ``1`` and the order of all other commands has been updated accordingly.

Task 3 - Commit a Transaction
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Click the ``Step 11: Commit the Transaction`` request in the folder. Examine the request type, URI, and JSON body. We will ``PATCH`` our transaction resource and change the value of the ``state`` attribute to submit the Transaction:

   |lab-7-6|

#. Click the :guilabel:`Send` button and examine the response.  The ``state`` may already be ``COMPLETED``. However, it is a good practice to explicitly check for this.

#. Click the ``Step 12: View the Transaction Status`` request in the folder and click the :guilabel:`Send` button.  Verify that the ``state`` of the Transaction is ``COMPLETED``.

#. You can verify the configuration was created on the BIG-IP device via the BIG-IP A GUI bookmark or at ``https://10.1.1.7``.

#. Verify that the virtual server works by opening ``http://10.1.10.120`` or using the ``Module 1 VIP01`` bookmark in Chrome web browser

   |lab-7-9|

.. |lab-7-1| image:: images/lab-7-1.png
.. |lab-7-2| image:: images/lab-7-2.png
.. |lab-7-3| image:: images/lab-7-3.png
.. |lab-7-4| image:: images/lab-7-4.png
.. |lab-7-5| image:: images/lab-7-5.png
.. |lab-7-6| image:: images/lab-7-6.png
.. |lab-7-7| image:: images/lab-7-7.png
.. |lab-7-8| image:: images/lab-7-8.png
.. |lab-7-9| image:: images/lab-7-9.png
