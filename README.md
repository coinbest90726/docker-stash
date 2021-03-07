# README #

### What is this repository for? ###

* Logstash is an open source, server-side data processing pipeline that ingests data from a multitude of sources simultaneously, transforms it, and then sends it to your favorite "stash."
* In our case we will use it to generate different pipelines from mysql to elasticsearch

### How do I get set up? ###

* Execut cp .env.dist .env
* Modify .env if necessary
* Execute make run

### Contribution guidelines ###

* Add versioning on dockerfile
* To add a new pipeline copy the sample file in the pipelines folder and edit it
* To add a new mapping and index generate a yml with the necessary fields and mapping configurations
* On run it will update and refresh those mappings

### Who do I talk to? ###

* Repo owner or admin