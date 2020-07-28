docker build -t cqy186cqy/multi-client:latest -t cqy186cqy/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t cqy186cqy/multi-server:latest -t cqy186cqy/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t cqy186cqy/multi-worker:latest -t cqy186cqy/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push cqy186cqy/multi-client:latest
docker push cqy186cqy/multi-server:latest
docker push cqy186cqy/multi-worker:latest

docker push cqy186cqy/multi-client:$SHA
docker push cqy186cqy/multi-server:$SHA
docker push cqy186cqy/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=cqy186cqy/multi-server:$SHA
kubectl set image deployments/client-deployment client=cqy186cqy/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=cqy186cqy/multi-worker:$SHA