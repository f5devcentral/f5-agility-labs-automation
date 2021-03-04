Class 13: ADC Performance Monitoring and Autoscaling Lab
============================================================================

This instructor-led lab will provide hands on experience with the ADC performance-based autoscaling solution.  The solution, (see below) illustrates how
F5's Automation Toolchain can integrate with third party analytics provider(s) to provide cloud-agnostic centralized application delivery monitoring and autoscaling.
 
   .. image:: module1/images/lab_layout.png

During this lab attendees will:

#. Utilize various third-party technologies/services along with F5’s automation toolchain including:
   
   - **F5 BIG-IP(s)** providing L4/L7 ADC Services
   - **F5 Declarative Onboarding**, (DO) and **Application Services 3 Extension**, (AS3) to deploy to configure BIG-IP application services
   - **F5 Telemetry Streaming**, (TS) to stream telemetry data to a third party analytics provider
   - **GitHub Actions** for workflow automation 
   - **Azure** public cloud for application hosting
   - **Hashicorp Terraform** and **Consul** for infrastructure provisioning, service discovery and event logging
   - **Elastic ELK Stack**, (integrated with BIG-IP(s) via TS) for monitoring and alerting
   - **Locust.io** for load generation

#. Deploy a cloud-based application, along with related infrastructure. 

#. Manage autoscaling operations via a centralized ADPM environment and a third party analytics provider, (Elastic ELK stack) for
   monitoring/alerting.

Expected time to complete: **2 hours**

We will be using a jumpbox to connect to the lab environment. Go to the next section for details on how to connect to the lab environment.

.. toctree::
   :maxdepth: 1
   :glob:

   module*/startup*
   module*/lab*
