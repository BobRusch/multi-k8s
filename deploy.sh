docker build -t slickrighty/multi-client:latest -t slickrighty/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t slickrighty/multi-server:latest -t slickrighty/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t slickrighty/multi-worker:latest -t slickrighty/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push slickrighty/multi-client:latest
docker push slickrighty/multi-server:tatest
docker push slickrighty/multi-worker:latest

docker push slickrighty/multi-client:$SHA
docker push slickrighty/multi-server:$SHA
docker push slickrighty/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=slickrighty/multi-server:$SHA
kubectl set image deployments/client-deployment server=slickrighty/multi-client:$SHA
kubectl set image deployments/worker-deployment server=slickrighty/multi-worker:$SHA