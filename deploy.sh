docker build -t rmlowe/multi-client:latest -t rmlowe/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rmlowe/multi-server:latest -t rmlowe/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rmlowe/multi-worker:latest -t rmlowe/mutli-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rmlowe/multi-client:latest
docker push rmlowe/multi-server:latest
docker push rmlowe/multi-worker:latest

docker push rmlowe/multi-client:$SHA
docker push rmlowe/multi-server:$SHA
docker push rmlowe/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rmlowe/multi-server:$SHA
kubectl set image deployments/client-deployment client=rmlowe/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rmlowe/mutli-worker:$SHA