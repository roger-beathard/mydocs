
# Install Helm

istio and some other tools rely on helm templating for its configuration files. So we need to install helm. Different version of helm can be found here: [https://github.com/helm/helm/releases](https://github.com/helm/helm/releases). The following will install v2.12 of helm.

Curl -LO [https://storage.googleapis.com/kubernetes-helm/helm-v2.12.1-darwin-amd64.tar.gz](https://storage.googleapis.com/kubernetes-helm/helm-v2.12.1-darwin-amd64.tar.gz) &amp;&amp; tar -zxvf helm-v2.12.1-darwin-amd64.tar.gz &amp;&amp; chmod +x darwin-amd64/helm &amp;&amp; mv darwin-amd64/helm ~/mystuff/tools

Verify that helm is moved to the ~/myjunk/tools directory by doing the following command:

- &#39;which helm&#39;

The output should be as follows: /Users/{your username}/myjunk/tools/helm

All the local helm configuration are managed in ~/.helm.

Remember to delete the downloaded artifacts.

- rm -rf darwin-amd64
- rm helm-v2.12.1-darwin-amd64.tar.gz

