This is an example of a Docker container to run anonymous grid-ftp in a server.

### Deploying the container

Configuring the Gridftp container is through enviroment variables. The default
configuration of running:
~~~
./start_server.sh
~~~
Will start a Gridftp sever on the IP corresponding to the hostname, port 2801.
incoming data ports 50000-51000, mouting ./data as the /data in the
container, and MTU 1500.

To customize the configuration, set the following variables in the environment
or the .env file before running start_server.sh file

**Public IP**:
IP address to which Gridftp will listen to.
~~~
export PUBLIC_IP=10.10.1.2
~~~

**Incoming data ports**: Requires setting three values:
~~~
export GLOBUS_HI_DATA_TCP_PORT=50123
export GLOBUS_LOW_DATA_TCP_PORT=50000
export GLOBUS_TCP_PORT_RANGE=50000,50123
~~~

**Main gridftp port**:
~~~
export GLOBUS_CONNECT_PORT=2801
export GLOBUS_LOW_DATA_TCP_PORT=50000
export GLOBUS_TCP_PORT_RANGE=50000,50123
~~~

**Location of default Host to container folder mapping**

For origin in the host:
~~~
export GLOBUS_DATA_FOLDER_HOST="${HOME}/my_data_folder"
~~~

Location to map it in the container:

~~~
export GLOBUS_DATA_FOLDER_CONTAINER=/data
~~~

### Notes about network performance

- Always specify the interface to which the server will listens to:
Default configuration
makes Grid-ftp to listen to 1000 ports (50000-51000), in Docker this implies
1000 open sockets between the public interface and the docker bridge (one per
port). If no specific network interface is specified, n*1000 sockets are opened
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
