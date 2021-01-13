docker build -t iantrisc/multi-client:latest -t iantrisc/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t iantrisc/multi-server:latest -t iantrisc/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t iantrisc/multi-worker:latest -t iantrisc/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push iantrisc/multi-client:latest
docker push iantrisc/multi-server:latest
docker push iantrisc/multi-worker:latest

docker push iantrisc/multi-client:$SHA
docker push iantrisc/multi-server:$SHA
docker push iantrisc/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=iantrisc/multi-server:$SHA
kubectl set image deployments/client-deployment client=iantrisc/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=iantrisc/multi-worker:$SHA