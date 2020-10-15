---
id: 16100
title: Building a Time Machine for Salesforce Data, the Easy Way
date: 2020-10-15
author: Greg Nokes
layout: post
guid: http://greg.nokes.name/?p=16100
permalink: /2020/04/08/salesforce-time-machine/
categories:
 - Computers! and Code!
---
# Using Heroku’s Streaming Data Connectors to build a Salesforce Object Time Machine

### With Bad Pictures


So, you want to have every change made to the data in a Saleforce Object stored.. forever?

![IMG 0010 2](/wp-content/uploads/2020/10/IMG_0010_2.jpeg)
Let’s explore how CDG and I used out of the box tools and a little coding to build a time machine, and what it looked like after we ran it on test data for several months.

First about our test data environment:  We are using a test org with randomly generated accounts, and opportunities associated with those accounts. We also have a service that runs to make changes to a small subset of the accounts every few minutes. 

The first step was to set up an collector app. This app will emit all of the changes as messages into Kafka.

* Set up a Heroku App in a Private Space
* Add a Heroku Private Postgres Database
* Add Heroku Connect
* Choose and Configure the objects to sync in Heroku Connect

We then needed to stream changes somewhere:

* Add a Heroku Private Kakfa cluster to the app
* Configure the Streaming Data Connector to point at the Heroku Connect tables

We were then mirroring our Salesforce Data into Heroku Postgres, preforming CDC on the data, and streaming the changes into Kafka.

We decided to use Node to listen to the event stream in Kakfa, and take the updates and insert them into a table on Postgres.

* Created another Heroku App in the Private Space
* Share the Kafka add on with the new app
* Add a Heroku Private Postgres database
* Create a table in the Postgres database - insuring that the validations would allow for duplicate values in things like `External_id__c` and `sfid` fields.
* Write code that listens to Kafka for events, and inserts the events as new records into the TARDIS ..um.. Postgres.

![IMG 0011 2](/wp-content/uploads/2020/10/IMG_0011_2.jpeg)

This is not only scalable to many objects in a single Salesforce org, it’s also scaleable to many Salesforce orgs - including Work.com, Service Cloud and SalesCloud. Not only can you easily provide visibility across orgs, but you can capture changes and report on how records have changed over time across objects and orgs.

What are the results now that we have all of this data flowing? 

Looking at the collector app. We have just over 50k accounts total, and we are using only 350 MB of data. Picking an account at random, we can see that we have the most up to date info for that account in Postgres.


```
~ ☯ heroku pg:psql --app ggn-pg2k-test 

--> Connecting to postgresql-rigid-10449
psql (12.4)
SSL connection (protocol: TLSv1.2, cipher: ECDHE-RSA-AES256-GCM-SHA384, bits: 256, compression: off)
Type "help" for help.

ggn-pg2k-test::DATABASE=> SELECT pg_size_pretty(pg_total_relation_size('"salesforce"."account"'));
 pg_size_pretty 
----------------
 349 MB
(1 row)

ggn-pg2k-test::DATABASE=> select count(*) from salesforce.account;
 count  
--------
 501646
(1 row)

ggn-pg2k-test::DATABASE=> select name, sfid, score__c from salesforce.account 
where External_id__c = '7f4acaad-6c77-4342-a533-83bb580aaf681586878813' ORDER BY score__c;

           name           |        sfid        | score__c 
--------------------------+--------------------+----------
 Borer, Braun and Gutmann | 001f400001MDeYzAAL |        2
(1 row)
```

Switching over to the time machine app, we have a total of 88,577,70 records on the same data source - so on average over 160 changes per record stored. Looking in detail at a single account, we can see a total of 21 changes on it. 
 
The total data storage for all of the records and changes took just over 4GB of space.

```
~ ☯ heroku pg:psql --app pg2k-gregs-drain

--> Connecting to postgresql-rugged-63570
psql (12.4, server 12.3 (Ubuntu 12.3-1.pgdg16.04+1))
SSL connection (protocol: TLSv1.2, cipher: ECDHE-RSA-AES256-GCM-SHA384, bits: 256, compression: off)
Type "help" for help.

pg2k-gregs-drain::DATABASE=> SELECT pg_size_pretty(pg_total_relation_size('"account"'));
 pg_size_pretty 
----------------
 4274 MB
(1 row)

pg2k-gregs-drain::DATABASE=> select count(*) from account;
  count  
---------
 8857770
(1 row)

pg2k-gregs-drain::DATABASE=> select name, sfid, score__c, id from account 
where External_id__c = '7f4acaad-6c77-4342-a533-83bb580aaf681586878813' ORDER BY id;

           name           |        phone        | score__c |        sfid        |   id    
--------------------------+---------------------+----------+--------------------+---------
 Borer, Braun and Gutmann | 5555551212          |        1 | 001f400001MDeYzAAL |   33351
 Borer, Braun and Gutmann | 967-160-7974 x6487  |       15 | 001f400001MDeYzAAL |   34165
 Borer, Braun and Gutmann | 967-160-7974 x6487  |       15 | 001f400001MDeYzAAL |   34699
 Borer, Braun and Gutmann | 967-160-7974 x6487  |       15 | 001f400001MDeYzAAL |   35523
 Borer, Braun and Gutmann | 967-160-7974 x6487  |       15 | 001f400001MDeYzAAL |  376946
 Borer, Braun and Gutmann | 967-160-7974 x6487  |       15 | 001f400001MDeYzAAL |  971802
 Borer, Braun and Gutmann | 967-160-7974 x6487  |       15 | 001f400001MDeYzAAL | 1041819
 Borer, Braun and Gutmann | 5555551212          |       15 | 001f400001MDeYzAAL | 3006621
 Borer, Braun and Gutmann | 1-151-183-4668 x379 |        5 | 001f400001MDeYzAAL | 3006628
 Borer, Braun and Gutmann | 1-151-183-4668 x379 |        5 | 001f400001MDeYzAAL | 3006634
 Borer, Braun and Gutmann | 1-151-183-4668 x379 |        5 | 001f400001MDeYzAAL | 3006648
 Borer, Braun and Gutmann | 5555551212          |        5 | 001f400001MDeYzAAL | 5140095
 Borer, Braun and Gutmann | 504.976.9652 x047   |        2 | 001f400001MDeYzAAL | 5140108
 Borer, Braun and Gutmann | 504.976.9652 x047   |        2 | 001f400001MDeYzAAL | 5140114
 Borer, Braun and Gutmann | 504.976.9652 x047   |        2 | 001f400001MDeYzAAL | 5140120
 Borer, Braun and Gutmann | 504.976.9652 x047   |        2 | 001f400001MDeYzAAL | 5390250
 Borer, Braun and Gutmann | 504.976.9652 x047   |        2 | 001f400001MDeYzAAL | 5620956
 Borer, Braun and Gutmann | 504.976.9652 x047   |        2 | 001f400001MDeYzAAL | 7002900
 Borer, Braun and Gutmann | 504.976.9652 x047   |        2 | 001f400001MDeYzAAL | 7031300
 Borer, Braun and Gutmann | 504.976.9652 x047   |        2 | 001f400001MDeYzAAL | 7788503
 Borer, Braun and Gutmann | 504.976.9652 x047   |        2 | 001f400001MDeYzAAL | 7906202
(21 rows)
```


