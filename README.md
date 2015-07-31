Role Name
=========

Installs elasticsearch role https://www.elastic.co/

Requirements
------------

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.

Role Variables
--------------

````
es_cluster_name: ansible-test #defines es_cluster_name if not specified in group_vars
es_config_lvm: false  #defines if additional lvm volume is to be created
es_config_nfs: false  #defines if an NFS mountpoint is to be mounted
es_curator_close_after_days: 14  #defines the number of days before closing indexes
es_curator_max_keep_days: 30  #defines the max number of days to keep indexes
es_fqdn: localhost
es_network_publish_host: []  #define a specific interface to bind elasticsearch on for clustering....usually not required...vagrant instances requires this...
es_nfs:
  - mount: []
    opts: defaults
    mountpoint: []
es_port: 9200
es_version: 1.7
install_bigdesk: true
install_curator: true
install_eshq: true
install_head: true
install_marvel: true
````

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: mrlesmithjr.elasticsearch }

License
-------

BSD

Author Information
------------------

Larry Smith Jr.
- @mrlesmithjr
- http://everythingshouldbevirtual.com
- mrlesmithjr [at] gmail.com
