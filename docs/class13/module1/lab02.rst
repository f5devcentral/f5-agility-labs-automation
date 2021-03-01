Lab 2 - Configuring Alerts with Elastic Watcher
====================================================

In this lab, you will work with the `Elastic ELK stack<https://www.googleadservices.com/pagead/aclk?sa=L&ai=DChcSEwjh65f2-I3vAhVJIK0GHbgCCksYABABGgJwdg&ohost=www.google.com&cid=CAESQOD2xGL_Qsq9gfWp4kozhteXPPMQjsypONZyC2737CiFNRshpDdmVDQalm7-_tkmhRHDzzqXDgi9Nik47sSCDuc&sig=AOD64_1-DObBfzyggy5KdpxGHlb_N9uirg&q&adurl&ved=2ahUKEwitrJD2-I3vAhXloFsKHfgQCUQQ0Qx6BAgCEAE>`_ previously deployed in Lab 1.  The ELK stack provides
centralized storage, analysis and visualization of organizational data.  As part of your application deployment, 
BIG-IPs are preconfigured to use F5 Telemetry Streaming<https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwjJlIOD-o3vAhXyNX0KHci7CukQtwIwAHoECAUQAw&url=https%3A%2F%2Fclouddocs.f5.com%2Fproducts%2Fextensions%2Ff5-telemetry-streaming%2Flatest%2F&usg=AOvVaw0VCdzaatz7XyBLeYDA0CYS>'_ to send telemetry 
data to the ELK stack.  As a student, your job will be to use configure your ELK stack to monitor the log data and
send alert triggers to the ADPM system when scaling of either the BIG-IP frontend or backend workloads are warrented.

**Exercise 1 - Create Index Pattern**

#. From your VS Code browser page, either copy of double-click on the link entitled 'f_application_address'.  This points to the Azure load balancer
   frontend address, (VIP).  As BIG-IP instances are deployed they are added to the Azure load balancer's backend 
   pool.  No

**Exercise 2 - Enable Elastic Trial License**

**Exercise 3 - Create Watcher Alerts**