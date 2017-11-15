This is an example of a Docker container to run anonymous grid-ftp in a server.

### Lessons learned

- Always specify the interface to which the server will listens to:
Default configuration
makes Grid-ftp to listen to 1000 ports (50000-51000), in Docker this implies
1000 open sockets between the public interface and the docker bridge (one per
port). If no specific network interface is specified, n*1000 sockets are open
(n=number of network interfaces).

- Consider reducing the grid-ftp open ports. Even for a single interface, 1000
connections can be a challenge for a mid-range host. This is done by setting
the enviroment variable:
~~~
export GLOBUS_TCP_PORT_RANGE=min,max
~~~


- NAT style configurations is required: The container has a private IP. If
grid-ftp is not informed of its public IP, it will ask clients to connect to
its private IP instead. This is done with the configuration pragma:
~~~
data_interface public_ip
~~~
