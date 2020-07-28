docker build -t cqyhahaha/multi-client:latest -t cqyhahaha/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t cqyhahaha/multi-server:latest -t cqyhahaha/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t cqyhahaha/multi-worker:latest -t cqyhahaha/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push cqyhahaha/multi-client:latest
docker push cqyhahaha/multi-server:latest
docker push cqyhahaha/multi-worker:latest

docker push cqyhahaha/multi-client:$SHA
docker push cqyhahaha/multi-server:$SHA
docker push cqyhahaha/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=cqyhahaha/multi-server:$SHA
kubectl set image deployments/client-deployment client=cqyhahaha/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=cqyhahaha/multi-worker:$SHA