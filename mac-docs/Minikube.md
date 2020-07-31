[[TOC]]

# Install Minikube

Minkube allows you run kubernetes in a single VM on you laptop. Although Minikube can run under different VM technologies (ie Virtualbox, Vmware fusion), the set of instructions will run Minikube using Apple&#39;s core Hyperkit framework. Although most of the hooks for utilizing Hyperkit were installed in the Docker setup there is an additional driver that needs to be installed for Minikube. The instructions for installing minikube and the Hyperkit docker driver are based on the following web pages:

[https://blog.arkey.fr/2018/06/18/minikube-with-hyperkit/](https://blog.arkey.fr/2018/06/18/minikube-with-hyperkit/)  &amp; [https://kubernetes.io/docs/tasks/tools/install-minikube/](https://kubernetes.io/docs/tasks/tools/install-minikube/)

## Prerequisites

- Docker
- Environment setup as shown in the above steps.

## Install the bhyve driver for docker

The driver needs to be installed as root as it needs to be able to modify network configurations. In order to install this component as root this install will ask for your administrative password. The password is typically just your MacBook login password. To install the component run the following command:

curl -LO [https://storage.googleapis.com/minikube/releases/latest/docker-machine-driver-hyperkit](https://storage.googleapis.com/minikube/releases/latest/docker-machine-driver-hyperkit) &amp;&amp; sudo install -o root -g wheel -m 4755 docker-machine-driver-hyperkit /usr/local/bin/

### What is the command doing?

- curl -LO [https://storage.googleapis.com/minikube/releases/latest/docker-machine-driver-hyperkit](https://storage.googleapis.com/minikube/releases/latest/docker-machine-driver-hyperkit) - retrieves binary from remote
- sudo install -o root -g wheel -m 4755 docker-machine-driver-hyperkit /usr/local/bin/ - moves binary to /usr/local/bin with root privelage

### Post Install

Do a _&quot;ls -l /usr/local/bin/docker-machine-driver-hyperkit&quot;_ to verify that component was installed and is running as root.


## Install the minikube binary.

Minikube is a single binary that will be placed in the ~/mystuff/tools directory after running the following command:

curl -Lo minikube [https://storage.googleapis.com/minikube/releases/v0.32.0/minikube-darwin-amd64](https://storage.googleapis.com/minikube/releases/v0.32.0/minikube-darwin-amd64)&amp;&amp; chmod +x minikube &amp;&amp; mv minikube ~/mystuff/tools

### What is the command doing?

- curl -Lo minikube [https://storage.googleapis.com/minikube/releases/v0.32.0/minikube-darwin-amd64](https://storage.googleapis.com/minikube/releases/v0.32.0/minikube-darwin-amd64) - retrieve binary from remote
- chmod +x minikube - change permission bit to make minikube executable
- mv minikube ~/mystuff/tools - move minikube to ~/mystuff/tools

###


### Post Install

Do a ls ~/mystuff/tools/minikube to verify minikube was moved to that directory.

## Verify Minikube Installation

### Remove previous minikube configurations

Minikube will store its configuration and any machine images in ~/.minikube, lets remove ~/.minikube before we start. This is to make sure we clean out any previous installations of

minikube rm -rf ~/.minikube

### Initial start of Minikube

The default startup of minikube is to run under virtual box. In order to change this behavior we need to initially startup minikube telling it to run hyper kit with the following startup command:

minikube start --vm-driver=hyperkit


### List kubernetes pods running in minikube

When minikube is first started it will set the default kubernetes context to minikube. We can see this effect when we do a &#39; **gcp-enable**&#39; command. In the following example, I have done a &quot; **gcp-set-minikube**&quot; to correctly setup the google cloud context to disable and kubernetes context to minikube. In addition, it lists out the kubernetes system pods with a **&#39;kubectl get pods -n kube-system&#39;**


### List out the minikube Hyperkit process

Since Hyperkit is native to MacOS, you can list out the Hyperkit processes using **&#39;ps -aef | grep hyperkit&#39;**. Since docker uses Hyperkit there will be 1 or more Hyperkit instances running. The minikube Hyperkit instance will have minikube in the line.


### Stop Minikube

To stop minikube just run **&#39;minikube stop**&#39;

### Subsequent startup of Minikube

To start up minikube after the initial startup, you just need to run **&#39;minikube start&#39;**. Minikube will remember what vm framework to start in by a configuration entry stored in the ~/.minikube directory.

## Additional minikube documentation

[Minikube](./../..//wiki/spaces/DO/pages/803275403/Minikube)

[Multi-Stage Docker builds](./../..//wiki/spaces/DO/pages/803537541/Multi-Stage+Docker+builds) - Not necessary related to minikube but is helpful in creating docker images to run in Minikube
