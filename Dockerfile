#FROM mrlesmithjr/ansible:ubuntu-12.04
FROM mrlesmithjr/ansible

MAINTAINER mrlesmithjr@gmail.com

# Installs git
RUN apt-get update && apt-get install -y \
  git \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create Ansible Folder
RUN mkdir -p /opt/ansible-playbooks/roles

# Clone GitHub Repo
RUN git clone --depth=50 --branch=2.1 https://github.com/mrlesmithjr/ansible-elasticsearch.git /opt/ansible-playbooks/roles/ansible-elasticsearch

# Copy Ansible playbooks
COPY playbook.yml /opt/ansible-playbooks/

# Run Ansible playbook to install elasticsearch
RUN ansible-playbook -i "localhost," -c local /opt/ansible-playbooks/playbook.yml

# Clean up APT
RUN apt-get clean

# Mountable data directories.
#VOLUME ["/usr/share/elasticsearch/logs", "/var/lib/elasticsearch", "/var/log/elasticsearch"]
VOLUME ["/usr/share/elasticsearch/logs"]

# Set Permissions on directories
RUN chown elasticsearch:elasticsearch /usr/share/elasticsearch/logs

# Expose ports
EXPOSE 9200
EXPOSE 9300
EXPOSE 54328/udp

# Change to user elasticsearch
USER elasticsearch

CMD ["/usr/share/elasticsearch/bin/elasticsearch", "-Des.path.conf=/etc/elasticsearch"]
