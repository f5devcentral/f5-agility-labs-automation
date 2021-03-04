Deploy a Web Application
-----------------------------------

In this lab we will use the AS3 API to programmatically deploy an application to th BIG-IP with a single REST call.

------------------------------------------------ 

**Exercise 1 - Explore BIG-IP**


#. Open Chrome and navigate to the BIG-IP GUI (https://10.1.1.9) or by clicking the bookmark. 


#. Login to the BIG-IP with the following credentials:

   +---------------+------------------------------------+
   | Username      |        admin                       |
   +---------------+------------------------------------+
   | Password      |    AgilityIsFun123!                |
   +---------------+------------------------------------+


#. Once you are logged in, navigate to 'Local Traffic' -> 'Virtual Servers' -> 'Virtual Servers List'. 

    .. image:: ./vslist.jpg

#. Note that you are in the 'Common' partition (top-right) and the BIG-IP has no Virtual Servers, Pools or Pool Members configured. 

    .. image:: ./vslistdisplay.jpg

------------------------------------------------ 

**Exercise 2 - Configure and Deploy the HTTP Application via AS3 With The Appropriate Telemetry Streaming Configuration**

The focus for this exercise is to deploy an application with the appropriate Telemetry Streaming configuration objects.

#. Minimize Chrome and open the Postman application.

    .. image:: ./mod4_1.png

#. Open the the Postman collection `Deploy Application` 

#. Click the `Create Application via AS3` request 

#. Click on the body tab and examine the request body. 

    .. image:: ./jsonbody.jpg

    **HINT:** Here is what is important in this declaration: 

   * The telemetry_local_rule allows traffic through port 6514  

   * The telemetry_traffic_log_profile builds a logging profile which specifies the log parameters 

    .. image:: ./as3snippet.jpg

#. Send the POST request by clicking the blue Send button.

#. Ensure you recieved a 'Status: 200 OK' response. 

    .. image:: ./200response.jpg

**NOTE:** By sending this GET request to ``https://10.1.1.9/mgmt/shared/appsvcs/declare`` with the correct credentials and current body we've built an application declaratively via AS3. 

**NOTE:** To learn more about AS3, visit https://clouddocs.f5.com/products/extensions/f5-appsvcs-extension/latest/ 

  

------------------------------------------------ 

**Exercise 3 - Verify Successful Deployment via BIG-IP GUI**


#. Open Chrome 

#. Click the BIG-IP bookmark or navigate to 'https://10.1.1.9'

#. Login to the BIG-IP with the following credentials:

   +---------------+------------------------------------+
   | Username      |        admin                       |
   +---------------+------------------------------------+
   | Password      |    AgilityIsFun123!                |
   +---------------+------------------------------------+


#. Once you are logged in, navigate to 'Local Traffic' -> 'Virtual Servers' -> 'Virtual Servers List'. 

    .. image:: ./vslist.jpg

#. Notice that you are currently in the `Common` partition and that there is now an application built named `opencart_vs`. 

    .. image:: ./ocbigip.jpg


------------------------------------------------ 

**Exercise 4 - Verify Web Application**


#. In Chrome, click on the 'OpenCart' bookmark. 

    .. image:: ./ocbookmark.jpg

#. Verify the application is working by clicking a few tabs and viewng products. 

    .. image:: ./opencart.jpg

