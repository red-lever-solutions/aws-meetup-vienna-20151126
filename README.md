# AWS Vienna Meetup Nov. 26 2015
---

## Setup and get going
---
* Grep for \<AWS_KEY\>, \<AWS_SECRET\>, and \<BASTION_IP\> and replace them with the appropriate values.
* Create a new ssh key aws_meetup_rsa (located in `~/.ssh/aws_meetup_rsa(.pub)`)
* The terraform stuff is located in the `terraform` dir.
* With `source setenvs` you can set the required AWS creds (as environment variables) for terraform.
* `terraform plan` and `terraform apply`

## Consul demo
---
* Forward the Consul Web UI port (8500) to localhost.
`ssh -F ssh_config -N -L 8500:127.0.0.1:8500 10.0.5.10&`
* Open the Web UI in the Browser `localhost:8500` and take a look around. Note the loadbalancer IP.
* Connect to the loadbalancer.
`ssh -F ssh_config <LOADBALANCER_PRIVATE_IP>`
`lb> sudo su`
* Check the running Docker containers `docker ps`.
* Write out the haproxy config file.
`lb> docker exec loadbalancer_loadbalancer_1 cat /usr/local/etc/haproxy/haproxy.cfg`
* You can also check the processes running in the container. You should see a haproxy process and a consul-template process.
`lb> docker top loadbalancer_loadbalancer_1`
* Open the ELB domain name in the Browser, reload a few times, and check if all registered servers respond.
* Scale down the nginx nodes (via terraform if you want) and observe the `haproxy.cfg`.
