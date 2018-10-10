# Set up a local kubernates cluster with Vagrant and VirtualBox
1. https://geraldonit.com/2018/03/26/deploying-a-kubernetes-cluster-with-vagrant-on-virtual-box/
2. Dashboard login https://docs.giantswarm.io/guides/install-kubernetes-dashboard/
3. Install htop into one of your worker
   ```
   wget http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
   sudo rpm -ivh epel-release-latest-7.noarch.rpm
   sudo yum install -y epel-release
   sudo yum install -y htop
   ```
4. Set up port forwarding
   ```
   sudo iptables -t nat -I PREROUTING -p tcp --dport 8099 -j DNAT --to-destination 127.0.0.1:8099
   sudo iptables -t nat -I PREROUTING -p tcp --dport 8069 -j DNAT --to-destination 127.0.0.1:8069
   sudo sysctl -w net.ipv4.conf.eth0.route_localnet=1
   ```
5. First scenario: one production pod with QoS burstable and one dev pod with QoS guaranted:   
   ```
      cd scenario1
      bash scenario1.sh
   ```
   Go to http://localhost:8099/-/mem and allocato 500Mb 3 times, then go to http://localhost:8069/-/mem and allocate 500 Mb. Kube will restart the production pod (Bad!)
6. Second scenario: one production pod with QoS guaranted and one dev pod with QoS burstable:   
   ```
      cd scenario2
      bash scenario2.sh
   ```
   Go to http://localhost:8099/-/mem and allocato 500Mb 3 times, then go to http://localhost:8069/-/mem and allocate 500 Mb. Kube will restart the dev pod and preserve the production one (Good!)
   
