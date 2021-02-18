docker build -t naveedmughal1208/multi-client:latest -t naveedmughal1208/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t naveedmughal1208/multi-server:latest -t naveedmughal1208/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t naveedmughal1208/multi-worker:latest -t naveedmughal1208/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push naveedmughal1208/multi-client:latest
docker push naveedmughal1208/multi-server:latest
docker push naveedmughal1208/multi-worker:latest


docker push naveedmughal1208/multi-client:$SHA
docker push naveedmughal1208/multi-server:$SHA
docker push naveedmughal1208/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=naveedmughal1208/multi-server:$SHA
kubectl set image deployments/client-deployment client=naveedmughal1208/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=naveedmughal1208/multi-worker:$SHA
