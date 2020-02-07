Lab 5 - How to work with multiple tenants using AS3
===================================================

In this lab, you will work with multiple tenants on a BIG-IP platform.

**Exercise 1 - Deploy Applications for First Tenant**

#. Expand the AS3 collections folder that we imported by clicking on it.

#. Open the ``Lab 5`` folder.

#. Click and examine the ``BIG-IP Authenticate`` declaration. Click ``Send``
   and ensure a 200 OK response in the Postman response window. 

   .. image:: images/Postname200OK_Highlighted.JPG

#. Locate the ``Tenant 1: HTTP Multi-Applications (2 Apps)`` request in the
   same folder.  If you look at the ``Body`` of the request, you will see a
   declaration to create 2 applications in the tenant named ``http_tenant``.

#. Click ``Send`` to send the declaration to the BIG-IP.

#. Confirm the results of the POST, and make sure you receive a result of 200.

#. Locate the ``BIG-IP: Get list of first tenant's deployed declarations``
   request.  In the request note that you will only retrieve the applications
   deployed for ``http_tenant`` tenant.

   .. image:: images/Postman_GetTenantDeclaration-Highlighted.JPG

#. Click ``Send`` to retrieve the deployed applications on the BIG-IP.  

#. In the response, you will see the declaration of the both applications.

#. If you login to the BIG-IP, you will see the applications deployed in the
   ``http_tenant`` partition.

**Exercise 2 - Deploy Application for Second Tenant**

#. Locate the ``Tenant 2: HTTP Application`` request in the same folder. If you
   look at the ``Body`` of the request, you will see a declaration to create an
   application in the tenant named ``http_tenant_2``.

#. Click ``Send`` to send the declaration to the BIG-IP.

#. You should receive an error ``422 Unprocessable Entity``.  The reason you
   received this error is that the second tenant is attemping to use the same
   pool member IP addresses in the declaration.  In order to use the same pool
   members in the second tenant, you must use the ``ShareNodes`` option in the
   pool declaration.

   .. image:: images/Postman_Tenant2_Error.JPG

#. Open the declaration ``BIG-IP: Delete first tenants declarations`` in order
   to delete the applications for tenant ``http_tenant``.

#. Click ``Send`` to delete the applications.

#. Verify that you received a ``HTTP 200 OK`` response.

#. Open the declaration ``Tenant 1: HTTP Multi-Applications (2 Apps) -
   ShareNodes``.

#. Scroll down the declaration to see the ``ShareNodes`` option set to
   ``true``.  The default setting for this is ``false``.

   .. image:: images/Postman_Tenant1_ShareNodes-Highlighted.JPG

#. Click ``Send`` to send the updated declaration to the BIG-IP.

#. Verify that you received a ``HTTP 200 OK`` response.

#. If you look on the BIG-IP now, you will see the Nodes have been created in
   the ``Common`` partition.  This will allow the second tenant to use the same
   Nodes in its applications.

#. Open the declaration ``Tenant 2: HTTP Application``.  You will notice that
   this declaration is for a second tenant, ``http_tenant_2``.  It also has the
   ``ShareNodes`` set to ``true`` for the pool members.

#. Click ``Send`` to send the updated declaration to the BIG-IP.

#. Verify that you received a ``HTTP 200 OK`` response.

#. Locate the ``BIG-IP: Get list of ALL deployed declarations`` request.  In
   the request note that you will retrieve the applications deployed for all
   tenants.

   .. image:: images/Postman_GetAllTenantDeclarations.JPG

#. Click ``Send`` to retrieve the deployed applications on the BIG-IP.  If you
   look at the response, you will see the declaration of the both applications.

#. If you look at the BIG-IP, you will also see a new partition for
   ``http_tenant_2`` has been added.  

#. If you look at the ``Nodes`` in the ``Local Traffic`` section, you will see
   that there are two nodes in the ``Common`` partition.

#. Open the declaration ``BIG-IP: Delete ALL declarations``.  This will delete
   all applications for all tenants on the BIG-IP.

#. Click ``Send`` to send the updated declaration to the BIG-IP.

#. Verify that you received a ``HTTP 200 OK`` response.
