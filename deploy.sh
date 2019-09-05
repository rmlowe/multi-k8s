docker build -t rmlowe/multi-client -f ./client/Dockerfile ./client
docker build -t rmlowe/multi-server -f ./server/Dockerfile ./server
docker build -t rmlowe/multi-worker -f ./worker/Dockerfile ./worker
docker push rmlowe/multi-client
docker push rmlowe/multi-server
docker push rmlowe/multi-worker
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rmlowe/multi-server