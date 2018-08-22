kafka_k8s_sandbox
=================
Run a local kafka cluster on your mac.

setup
-----
Install docker4mac edge
Enable edge
Install helm
helm init
helm repo add incubator http://storage.googleapis.com/kubernetes-charts-incubator

install kafka cluster w/ default config
---------------------------------------
helm install --name my-kafka incubator/kafka


install kafka cluster w/ external access enabled
------------------------------------------------
helm install --set external.enabled=true --name my-kafka incubator/kafka

install single broker cluster
-----------------------------
helm install --set replicas=1 --set external.enabled=true --name my-kafka incubator/kafka

get status of kafka cluster
---------------------------
helm status my-kafka

delete cluster
--------------
helm delete --purge my-kafka

get services
------------
k8 get services
`
Michaels-Air:kafka_k8s_sandbox grudkowm$ k8 get services
NAME                          TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                      AGE
kubernetes                    ClusterIP   10.96.0.1        <none>        443/TCP                      1d
my-kafka                      ClusterIP   10.96.87.100     <none>        9092/TCP                     5h
my-kafka-0-external           NodePort    10.101.206.219   <none>        19092:31090/TCP              5h
my-kafka-headless             ClusterIP   None             <none>        9092/TCP                     5h
my-kafka-nodeport             NodePort    10.109.48.97     <none>        9092:31357/TCP               1d
my-kafka-zookeeper            ClusterIP   10.103.113.92    <none>        2181/TCP                     5h
my-kafka-zookeeper-headless   ClusterIP   None             <none>        2181/TCP,3888/TCP,2888/TCP   5h
my-service                    NodePort    10.106.247.77    <none>        8080:30143/TCP               4h
`



get pods
--------
k8 get pods
`
Michaels-Air:~ grudkowm$ kubectl get pod
NAME                   READY     STATUS    RESTARTS   AGE
my-kafka-0             1/1       Running   0          11m
my-kafka-1             1/1       Running   0          9m
my-kafka-2             1/1       Running   0          9m
my-kafka-zookeeper-0   1/1       Running   0          11m
my-kafka-zookeeper-1   1/1       Running   0          10m
my-kafka-zookeeper-2   1/1       Running   0          10m
`

accessing kafka externally
--------------------------
Only the kafka service need be exposed if simply consuming / production.

Other use-cases require exposing the zk service as well.  For example, creating a topic using built in kafka-topics.sh script requires external access to zk.

If using the helm chart, the kafka service can be exposed using config overrides when initially creating the chart.  Otherwise, you can run...

kubectl expose svc my-kafka --name=my-kafka-nodeport --type=NodePort

ZK can be exposed similarly:
k8 expose svc my-kafka-zookeeper --name=my-kafka-zookeeper-nodeport --type=NodePort

t 


show services
-------------
kubernetes k8 services|grep my-kafka-nodeport
`
Michaels-MacBook-Air:k8s_external_access grudkowm$ k8 get services|grep my-kafka-nodeport
my-kafka-nodeport             NodePort    10.109.48.97     <none>        9092:31357/TCP               1d
`






`
Michaels-Air:~ grudkowm$ kubectl get pod
NAME                   READY     STATUS    RESTARTS   AGE
my-kafka-0             1/1       Running   0          11m
my-kafka-1             1/1       Running   0          9m
my-kafka-2             1/1       Running   0          9m
my-kafka-zookeeper-0   1/1       Running   0          11m
my-kafka-zookeeper-1   1/1       Running   0          10m
my-kafka-zookeeper-2   1/1       Running   0          10m
`

* Overriding template parameters
helm install -name my-kafka
--set replicas=1 \
--set persistence.enabled=false \
--set zookeeper.servers=1 \
--set zookeeper.persistence.enabled=false \
incubator/kafka

kubectl expose svc my-kafka --name=my-kafka-nodeport --type=NodePort
service/my-kafka-nodeport exposed




KAFKA_ADVERTISED_HOST_NAME
kubectl expose svc $YOUR_KAFKA_SERVICE_NAME --name=kafka-nodeport --type=NodePort
kubectl get svc kafka-nodeport -o yaml | grep nodePort. In this example, kafka broker will be accessible via this address: $KUBERNETES_NODE_IP:$NODEPORT


reference
---------
https://github.com/wurstmeister/kafka-docker/blob/master/README.md
https://github.com/helm/charts/tree/master/incubator/kafka
https://github.com/helm/helm
