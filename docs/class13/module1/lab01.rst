Lab 1 - Deploying Sample Application Infrastructure
====================================================
The ADC performance-based scaling, (ADPM) lab utilizes a centralized automation repo consisting of:

- Github Actions, (central repo providing automation)
- Hashicorp Terraform, (Application scaling operations)
- Hashicorp Consul Server, (scaling params, student Terraform remote state hosting, logging)
- Alert Forwarding service, (Nodejs proxy providing webhook normalization and security)

As a student you will perform the initial application deployment from your lab jump box utilizing Terraform.
The student terrafrom project utilizes a remote state file hosted on the central Consul server.  The central
ADPM system uses Terraform and the student's remote state file to perform scaling operations.

**Exercise 1 - Deploy Application Infrastructure**
--------------------------------------------------

#. From the UDF deployment, select the 'Components' tab and navigate to the client component and
   expand the 'Access' drop-down menu.  Select 'VS Code' to open the VS Code browser interface, (see below).

   .. image:: images/access_vscode.png


#. The client jump box has been preconfigured top interact with both the cloud environment, (Azure) and the
   ADPM central repo.  You will use VS Code to clone and deploy your application environment.  From VS Code, 
   select the 'Terminal' tab, navigate to the home directory and clone the repo using the below commands.
    
    ``cd $home && git clone https://github.com/f5businessdevelopment/adpm-agility.git``

   .. image:: images/vscode1.png

      
#. Navigate to the scripts directory and execute the application deployment script.

   ``cd adpm-agility/scripts && sh ./deploy.sh``
   
   The script, (deploy.sh) triggers a series of terraform projects that deploys a fully functioning sample
   application and associated infrastructure into the Azure public cloud.  Once the deployment has completed, 
   (10-15 minutes) you will be presented with a listing of outputs, (see below).  You will use these outputs
   to complete the lab.

   .. image:: images/outputs.png
   
**Exercise 2 - View Infrastructure Components**
-----------------------------------------------

As previously mentioned, the Terraform outputs provide the endpoints that you will use to interact with and
complete the lab.  Before continuing on to the next steps, (configuring alerts) take a few minutes to familiarize
yourself with your student environment.

#. Either copy of double-click on the link entitled **d_application_address**.  This points to the Azure load balancer
   frontend address, (VIP).  As BIG-IP instances are deployed they are added to the Azure load balancer's backend 
   pool.  The BIG-IP(s) in turn sit in front of the application pool, (NGINX webserver pool) providing load balancing and 
   advanced traffic services. In later exercises, you will be setting up alerts and scaling both the BIG-IP ADC cluster
   and the backend application pool.  **Note:** This solution does not make use of native cloud scaling mechanisms.  Rather, scaling decisions and
   actions are performed by the analytics provider, (Elastic "ELK" stack) and the ADPM system, (GitHub Actions)
   respectively.  Using your browser, navigate to application's frontpage; you will need to accept the certificate errors
   to continue.  Your front page will be similar to the example below.
   
   **Note:** If you are using the Chrome browser, you may need to enter ``thisisunsafe`` while on the page to bypass warnings.

   **Note:** If you are using the Chrome browser, you
   may need to enter ``thisisunsafe`` while on the page to bypass warnings.


   .. image:: images/app_page.png

#. Either copy of double-click on the link entitled **e_consul_public_address** to navigate to your consul server.  In
   addition to the central ADPM consul server, each student environment includes a consul server instance.  The consul
   server provides `application service discovery <https://clouddocs.f5.com/products/extensions/f5-appsvcs-extension/latest/declarations/discovery.html#service-discovery-using-hashicorp-consul>`_ as well as hosting scaling event telemetry data.

   As backend application, (NGINX) is scaled up/down, (initially deployed with 2 instances) the individual workloads are registered with consul service discovery.
   The associated BIG-IP(s) periodically poll the consul server and add/remove pool members accordingly.  Refer to the above
   link for specific guidance and information related to F5 Service Discovery with Consul.

   .. image:: images/consul_front.png

#. In addition to the above services, the Terraform deployment output includes the management address for the 
   single BIG-IP initially deployed.  While not necessary for this particular lab, you may use the supplied credentials and address to 
   connect to BIG-IP's management interface.  **Note:** The BIG-IP management interface is available via port *8443*.

**Lab Summary**
---------------
By successfully completing the previous exercises you will have:
   - Accessed and deployed a new student UDF lab blueprint
   - Cloned the lab GitHub repository to the UDF jump box using VS Code
   - Deployed a fully functioning infrastructure and application stack
   - Verified application connectivity

In the next lab, (Lab #2) you will configure your Elastic "ELK" stack for telemetry data ingestion and setup alerts, (via Watcher).


