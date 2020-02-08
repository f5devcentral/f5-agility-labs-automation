Lab 3 (Optional) Build a declaration from scratch
=================================================

Up to this point we've given you the necessary declaration needed to onboard your **BIGIP**.

In this lab you will start from a blank state and build the declaration on your own.  Use the F5 schema reference and the published schema validation for
declarative onboarding to help you accomplish the task below.

Onboard a standalone **BIGIP** that includes the following in the declaration:
Licensing for the **BIGIP**
DNS
NTP
Regular user
Provision LTM, DNS, AFM
Internal VLAN
Non floating self IP on internal VLAN
External VLAN
Non floating self IP on external VLAN
Syslog destination
Enable an advisory message in the UI that show the hostname with a green background. **(Extra cool points if you use a JSON pointer for the hostname)**

..  note
    Use the table below for the necessary values in your declaration

..  list-table:: Declaration Values
    :widths: 25 25 25
    :header-rows: 1

    * - Heading row 1, column 1
      - Heading row 1, column 2
      - Heading row 1, column 3
    * - Row 1, column 1
      - Row 1, column 2
      - Row 1, column 3

The schema reference can be found at the following url: https://clouddocs.f5.com/products/extensions/f5-declarative-onboarding/latest/schema-reference.html#syslogremoteserver
Example declarations can be found at the following url: https://clouddocs.f5.com/products/extensions/f5-declarative-onboarding/latest/examples.html
