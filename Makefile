export DOCKER_BUILDKIT=1
SPARK_VERSION?="3.3.4"
FILE_URL := https://dlcdn.apache.org/spark/spark-$(SPARK_VERSION)/spark-$(SPARK_VERSION)-bin-hadoop3.tgz

.PHONY: *

all: clean  

#.PHONY: download-spark
download-spark: 
	echo "Downlading the Apache Spark binaries..."
	wget $(FILE_URL)
	echo "Untarring the Apache Spark binaries..."
	tar -xf spark-$(SPARK_VERSION)-bin-hadoop3.tgz

#.PHONY: spark-dockerfiles
spark-dockerfiles: 
	echo "Preparing the Spark image..."
	./spark-$(SPARK_VERSION)-bin-hadoop3/bin/docker-image-tool.sh -r vinaymakam -t $(SPARK_VERSION) build
	echo "Preparing the Spark Python image..."
	./spark-$(SPARK_VERSION)-bin-hadoop3/bin/docker-image-tool.sh -r vinaymakam -t $(SPARK_VERSION) -p ./spark-$(SPARK_VERSION)-bin-hadoop3/kubernetes/dockerfiles/spark/bindings/python/Dockerfile build
	./spark-$(SPARK_VERSION)-bin-hadoop3/bin/docker-image-tool.sh -r vinaymakam -t $(SPARK_VERSION)  push

#.PHONY: deploy-spark-operator
deploy-spark-operator: 
	helm repo add spark-operator https://googlecloudplatform.github.io/spark-on-k8s-operator
	helm install my-release spark-operator/spark-operator \
		--namespace spark-operator \
		--set webhook.enable=true \
		--set image.repository=vinaymakam/spark-operator \
		--set image.tag=3.3.1 \
		--create-namespace
	kubectl apply -f `pwd`/spark-pi.yml

#.PHONY: install
install: download-spark spark-dockerfiles deploy-spark-operator

#.PHONY: clean
clean:
	rm -rf spark-$(SPARK_VERSION)-bin-hadoop3.tgz || true

#.PHONY: clean-all
clean-all:
	rm -rf spark-$(SPARK_VERSION)-bin-hadoop3.tgz || true
	rm -rf spark-$(SPARK_VERSION)-bin-hadoop3 || true
	docker image rm -f vinaymakam/spark:$(SPARK_VERSION) || true
	docker image rm -f vinaymakam/spark-py:$(SPARK_VERSION) || true
	helm uninstall my-release -n spark-operator --no-hooks
	kubectl delete namespace spark-operator
