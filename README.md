Role Name
=========

Installs elasticsearch role https://www.elastic.co/
######Configurable (cluster ready)

[![Build Status](https://travis-ci.org/mrlesmithjr/ansible-elasticsearch.svg?branch=master)](https://travis-ci.org/mrlesmithjr/ansible-elasticsearch)

Requirements
------------

None

Role Variables
--------------

````
---
# defaults file for ansible-elasticsearch
es_cluster_name: ansible-test #defines es_cluster_name if not specified in group_vars
es_cluster_setup: false  #defines if elasticsearch will be setup as a cluster of nodes...define here or in group_vars/group
es_config_lvm: false  #defines if additional lvm volume is to be created
es_config_nfs: false  #defines if an NFS mountpoint is to be mounted
es_curator_close_after_days: 14  #defines the number of days before closing indexes
es_curator_max_keep_days: 30  #defines the max number of days to keep indexes
es_data_node: true  #defines if node should be a data node in the cluster...default is true...define here or in group_vars/group
es_debian_repo: 'deb http://packages.elastic.co/elasticsearch/{{ es_version }}/debian stable main'
es_fqdn: localhost
es_heap_size: '{{ (ansible_memtotal_mb | int * es_heap_size_multiplier) | round | int }}m'
#defines the amount of memory to allocate...Heap Size (defaults to 256m min, 1g max)...50% of max memory is good.
es_heap_size_multiplier: 0.5  #defines multiplier for determining the amount of memory to allocate to ES
es_master_node: true  #defines if node should be a master node in the cluster...default is true...define here or in group_vars/group
es_memory_tuning:  #these settings help eliminate OOM conditions (More memory should be used in most cases but these settings can help) #define here or in group_vars/group
  - name: indices.breaker.fielddata.limit
    set: false
    value: 60%  #default 60%
  - name: indices.breaker.request.limit
    set: false
    value: 40%  #default 40%
  - name: indices.breaker.total.limit
    set: false
    value: 40%  #default 40%
  - name: indices.fielddata.cache.size
    set: false
    value: 40%  #default undefined
es_min_master_nodes: []  #defines the minimum number of master nodes in cluster to allow cluster to not become split brained...only required if es_cluster_setup == true
#es_network_publish_host: []  #define a specific interface to bind elasticsearch on for clustering....usually not required...vagrant instances requires this...
es_nfs:
  - mount: []
    opts: defaults
    mountpoint: []
es_plugin_bin: /usr/share/elasticsearch/bin/plugin
#es_plugin_install: -i  #define when ES vversion is below 2.x
es_plugin_install: install  #define when ES version is 2.x+
#es_plugin_list: -l  #define when ES version is below 2.x
es_plugin_list: list  #define when ES version is 2.x+
es_plugins_install:  #define plugins to install..naming is strange due to the way plugins are listed after installed
#  - plugin: elasticsearch/
#    name: marvel
#  - plugin: elastic/elasticsearch-
#    name: migration
#  - plugin: lukas-vlcek/
#    name: bigdesk
  - plugin: mobz/elasticsearch-
    name: head
  - plugin: royrusso/elasticsearch-
    name: HQ
es_port: 9200
es_replicas: 1  #defines the number of replicas per shard in cluster...default is 1...define here or in group_vars/group
es_repo_key: https://packages.elastic.co/GPG-KEY-elasticsearch
es_shards: 5  #defines the number of primary shards per index...default is 5...define here or in group_vars/group
es_version: 2.x
#es_version: 2.x  #ready for 2.x release of Elasticsearch
install_bigdesk: true
install_curator: true
install_eshq: true
install_head: true
install_marvel: true
````

Dependencies
------------

None

Example Playbook
----------------

#### Galaxy
-----------
    - hosts: servers
      roles:
         - mrlesmithjr.elasticsearch
#### GitHub
-----------
    - hosts: servers
      roles:
        - ansible-elasticsearch

Docker Info
-----------

In order to run as a Docker container you will need to run the following (below example spins up a container named elasticsearch).
Ex.
````
docker run -d --name elasticsearch -p 9200:9200 mrlesmithjr/elasticsearch
````
You can change the name of the elasticsearch cluster (default is ansible-test) after the container is spun up if desired.
By executing the following:
````
docker exec -it elasticsearch ansible-playbook -i "localhost," -c local /opt/ansible-playbooks/playbook.yml --extra-vars="es_cluster_name=docker-es" && docker restart elasticsearch
````
The above will change the configuration for the elasticsearch cluster name and then the container is restarted.

License
-------

BSD

Author Information
------------------

Larry Smith Jr.
- @mrlesmithjr
- http://everythingshouldbevirtual.com
- mrlesmithjr [at] gmail.com
