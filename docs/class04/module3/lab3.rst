Review API Calls
-----------------------------------

In this lab section we are introducing Postman, an API Development Environment that helps us structure API calls. We will send GET requests to obtain the RPM package that shows details of the API.

------------------------------------------------ 

**Exercise 1 - Setting Up Postman Environment**


#. Open Postman

------------------------------------------------ 

**Exercise 2 - Check Application Services 3 Extension (AS3) RPM Availability**
  
#. Open Postman 

#. Open the the Postman collection `Verify Installation`

    .. image:: ./postman1.jpg

#. Click the `Get AS3 RPM Package` request 

#. Examine the request. Note that we are sending a 'GET' request with an empty body. Send the GET request by clicking the blue 'Send' button. Also note that we have built in auth for you, using Basic username and password authentication. 

    .. image:: ./send1.jpg

#. You should see a similar response. 

    .. image:: ./as3rpm.jpg

**NOTE:** By sending this GET request to 'https://10.1.1.9/mgmt/shared/appsvcs/info' with the correct credentials, the response shows details of the AS3 API available on this BIG-IP. 

**NOTE:** This AS3 RPM package was pre-installed. For instructions, visit the link here: https://clouddocs.f5.com/products/extensions/f5-appsvcs-extension/latest/userguide/installation.html 


------------------------------------------------ 

**Exercise 3 - Check Telemetry Streaming RPM Availability**
  
#. Click the `Get TS RPM Package` request 

#. Examine the request. Note that we are sending a 'GET' request with an empty body. Send the GET request by clicking the blue 'Send' button. 

    .. image:: ./sendts.jpg

#. You should see a similar response. 

    .. image:: ./tsrpm.jpg

**NOTE:** By sending this GET request to 'https://10.1.1.9/mgmt/shared/telemetry/info' with the correct credentials, the response shows details of the TS API available on this BIG-IP. 

**NOTE:** This Telemetry Streaming RPM package was pre-installed. For instructions, visit the link here: https://clouddocs.f5.com/products/extensions/f5-telemetry-streaming/latest/userguide/installing-ts.html

------------------------------------------------ 
