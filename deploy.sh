docker build -t hmsdt/multi-client:latest -t hmsdt/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hmsdt/multi-server:latest -t hmsdt/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hmsdt/multi-worker:latest -t hmsdt/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push hmsdt/multi-client:latest
docker push hmsdt/multi-server:latest
docker push hmsdt/multi-worker:latest

docker push hmsdt/multi-client:$SHA
docker push hmsdt/multi-server:$SHA
docker push hmsdt/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=hmsdt/multi-server:$SHA
kubectl set image deployments/client-deployment client=hmsdt/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=hmsdt/multi-worker:$SHA



