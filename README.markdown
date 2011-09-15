#Install Ruby, MySQL and Rails
I found the following links very useful to accomplish this task<br />
On [Ubuntu 11.04](http://ryanbigg.com/2010/12/ubuntu-ruby-rvm-rails-and-you/)<br />
On [Windows 7 x64](http://allaboutruby.wordpress.com/2009/07/20/installing-rails-on-windows-3-years-later/)<br />
On [Cygwin for Windows 7 x64](http://robborex.wordpress.com/2011/05/03/159/)<br />
Cygwin and MySQL are not very close friends. Moreover, things will become messy if you have Ruby on both cygwin and Windows.<br />
Therefore I recomend you to use the Ruby Installer or the RailsInstaller when working on Windows. <br />
If you have problems using the mysql library, take a look at this nice [post](http://blog.mmediasys.com/2011/07/07/installing-mysql-on-windows-7-x64-and-using-ruby-with-it/)<br />

Ruby Database Connectivity
[Some popular methods](http://www.troubleshooters.com/codecorn/ruby/database/index.htm)

#Queries
The simplest way to know the table schema of a particular database at the UCSC, is by using raw queries with the mysql library. <br />
For example:<br/ >
<code> SELECT table_name FROM INFORMATION_SCHEMA.TABLES WHERE table_schema='hg19' ORDER BY table_name </code> <br/ >
or <br/ >
<code> SELECT table_name, column_name FROM INFORMATION_SCHEMA.COLUMNS WHERE table_schema = 'hg19' ORDER BY table_name </code> <br/ >
With the results of the first query you can easily write down a script for Hiro Mishimas's bio-ucsc-api. <br />
The results of the second query are useful for reviewing all the fields existing in every single table of a particular database. I personally accomplish this task by creating a simple crosstab query. <br />

Since not all the tables can be handled the same way, the first step for using Hiro's API is to know what tables can be queried by position. <br/ >
This can be done by using the Table Browser. However, that is a painful task! <br/ >
A better approach is to let bio-ucsc-api do the job for you! <br/ >
As described in the [bio-ucsc-api](https://github.com/misshie/bioruby-ucsc-api) you can query by genomic intervals by using ".with_interval_excl(gi).find(:all)". <br/ >
Therefore, tables that retrieve "NoMethodError: undefined method `with_interval'" by using ... " cannot be queried by position and should be treated differently. <br/ >
For example:<br/ >
Up to date there are 3992 tables in the Hg19 database. 2235 of them can be queried by position whereas 1752 can not. From the last, 1585 correspond to wgEncode tables that contain just two fields: fileName and Field0.
The remaining 167 tables have very different structures, so they have to be reviewed by hand (in process).

Special thanks to Hiroyuki Mishima for his guidance and help!