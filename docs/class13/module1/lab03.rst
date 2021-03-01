Lab 3 - Generating Traffic and Monitoring Scaling Events
========================================================

In this lab, you will use a traffic generator, (`Locust<https://locust.io/>`_) to generate traffic.  Afterwards, you use 
your Consul server to view scaling logs entries and monitor service discovery.

**Exercise 1 - Generate Traffic**
---------------------------------

#. Before using Locust you must first start the locust application.  From VS Code browser tab open a new teriminal 
   window, (see below).

   .. image:: images/locust_1.png

#. Using the new terminal window, navigate to the locust directory and clone the repo using the below commands.

   ``cd /home/ubuntu/projects/locust && locust`` 

   .. image:: images/locust_2.png

#. Now with Locust running, return to your UDF deployment tab and navigate to the client component.  Select '*Locust*' from
   the *Access* drop-down menu.  A new browser tab, (Locust UI) will open.

   .. image:: images/locust_3.png

#. On the Locust UI, enter amounts for *Number of total users to simulate* and *Spawn rat*.  Enter the application address in
   host field; (if necessary refer back to the first terminal window). 

   .. image:: images/locust_5.png

#.  Select '*Start swarming*' to begin taffic generation.  You can monitor traffic from the statistics tab, (see below).

   .. image:: images/locust_6.png

**Exercise 2 - Monitor Scaling Operations**
-------------------------------------------
    
#. 

   .. image:: images/monitor_1.png

#. 

   .. image:: images/monitor_2.png

