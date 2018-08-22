kgetpod:
	kubectl get pod

kgets:
	kubectl get service

hlist:
	helm list

hfetchkafka:
	helm fetch incubator/kafka

hdeletekafka:
	helm delete  --purge my-kafka

hinstallkefka:
	helm install --set external.enabled=true --name my-kafka incubator/kafka

hcreatekefka:
	helm create --set external.enabled=true --name my-kafka incubator/kafka

htemplate:
	helm template --set external.enabled=true kafka-0.8.8.tgz > kafka.yaml

hstatuskafka:
	helm status my-kafka


