Lab 2 - Configuring Alerts with Elastic Watcher
====================================================

In this lab, you will work with the `Elastic ELK stack <https://www.googleadservices.com/pagead/aclk?sa=L&ai=DChcSEwjh65f2-I3vAhVJIK0GHbgCCksYABABGgJwdg&ohost=www.google.com&cid=CAESQOD2xGL_Qsq9gfWp4kozhteXPPMQjsypONZyC2737CiFNRshpDdmVDQalm7-_tkmhRHDzzqXDgi9Nik47sSCDuc&sig=AOD64_1-DObBfzyggy5KdpxGHlb_N9uirg&q&adurl&ved=2ahUKEwitrJD2-I3vAhXloFsKHfgQCUQQ0Qx6BAgCEAE>`_ previously deployed in Lab 1.  The ELK stack provides
centralized storage, analysis and visualization of organizational data.  As part of your application deployment, 
BIG-IPs are preconfigured to use `F5 Telemetry Streaming <https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwjJlIOD-o3vAhXyNX0KHci7CukQtwIwAHoECAUQAw&url=https%3A%2F%2Fclouddocs.f5.com%2Fproducts%2Fextensions%2Ff5-telemetry-streaming%2Flatest%2F&usg=AOvVaw0VCdzaatz7XyBLeYDA0CYS>`_ to send telemetry 
data to the ELK stack.  As a student, your job will be to use configure your ELK stack to monitor the log data and
send alert triggers to the ADPM system when scaling of either the BIG-IP frontend or backend workloads are warrented.

**Exercise 1 - Create Index Pattern**

#. From your VS Code browser page, either copy of double-click on the link entitled **f_elk_public_address**.  You are 
   presented with the logon page shown below.  Use the relevant credentials provided in the startup section to log into
   Kibana, (the ELK stack visualization service and the '*K*' in ELK).

   .. image:: images/elk_login.png

#. Upon your initial login, you will be provided an option to add data or explore the environment on your own, (see below).
   Since we have already configured data ingestion via F5 Telemetry Streaming select *'Explore on my own'*.

   .. image:: images/elk_explore.png

#. Next, you will need to create an index pattern.  The index pattern will provide a starting base in which to query injested
   BIG-IP telemetry.  From the upper-left corner select the menu icon and navigate down the sidebar menu to the '*Analytics*'
   section and select '*Discover*', (see below).

   .. image:: images/elk_discover.png

#. From the center panel, select '*Create index pattern*', (see below).

   .. image:: images/index_1.png

#. On the *Create Index Pattern* screen enter ``F5-*`` for the index pattern name.  As the exmple below illustrates, you should
   several indexes listed below.  As telemetry data is streamed from the BIG-IP(s) to the ELK stack, (via Logstash - the '*L*' in ELK)
   it is assigned an index with a pattern of **f5-%{+YYYY.MM.dd.hh.mm}**.

   .. image:: images/index_2.png

#. Select **@timestamp** from the drop-down list for the '*Time Field*'.  Select '*Create index pattern*' to complete the process.

   .. image:: images/index_3.png

**Exercise 2 - Enable Elastic Trial License**

#. Your ELK stack will initially deploy with a free basic license.  However, to make use of alerts and webhook notifications,
   (either via Kibana or Watcher) you must first upgrade the ELK stack license.  To do this, you will enable a 30-day trial
   license.  From the upper-left corner select the menu icon and navigate down the sidebar menu to the bottom and select '*Stack Management*'
   to open the *Stack Management* side-bar submenu.  
   
   .. image:: images/stack_mgmt.png  
   
#. From the Stack Management menu scroll to the bottom and select '*License Management*' 
   
   .. image:: images/license_1.png

#. You will be presented with an option to either update your license or start a 30-day trial.  Select '*Start trial*' to activate 
   the license. 

   .. image:: images/license_2.png

#. You should be presented with a notification screen as shown below signifying license activation and expiration date.  

   .. image:: images/license_3.png

**Exercise 3 - Create Watcher Alerts**

#. You will be using Elastic Watcher to monitor telemetry data and alert.  While still in the *Stack Management* submenu
   navigate to and select '*Watcher*', (see above).  From the center panel select '*Create*' and then '*Create threshold alert*'.

   .. image:: images/create_watch.png

#.  

   .. image:: images/alert_1.png

#. 
   .. image:: images/alert_2.png

#. 
   .. image:: images/alert_3.png

#. 
   .. image:: images/alert2.png

#. 
   .. image:: images/alert_final.png


