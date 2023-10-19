1. create topic
	```bash
	kafka/client kafka-topics.sh \
		--zookeeper lab-zookeeper:2181/lab-kafka \
		--topic topic-demo \
		--create \
		--replication-factor 1 \
		--partitions 4
	```
	Created topic topic-demo.

2. examine the topic
	```bash
	kafka/client kafka-topics.sh \
		--zookeeper lab-zookeeper:2181/lab-kafka \
		--topic topic-demo \
		--describe
	```

3. start a consumer
	```bash
	kafka/client kafka-console-consumer.sh \
		--bootstrap-server lab-kafka:9092 \
		--topic topic-demo
	```

4. start a producer
	```bash
	kafka/client kafka-console-producer.sh \
		--bootstrap-server lab-kafka:9092 \
		--topic topic-demo
	```