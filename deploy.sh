docker build -t crownley/complex-client:latest -t crownley/complex-client:$SHA -f ./client/Dockerfile ./client
docker build -t crownley/complex-server:latest -t crownley/complex-server:$SHA -f ./server/Dockerfile ./server
docker build -t crownley/complex-worker:latest -t crownley/complex-worker:$SHA -f ./worker/Dockerfile ./worker

docker push crownley/complex-client:latest
docker push crownley/complex-server:latest
docker push crownley/complex-worker:latest

docker push crownley/complex-client:$SHA
docker push crownley/complex-server:$SHA
docker push crownley/complex-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=crownley/complex-server:$SHA
kubectl set image deployments/client-deployment client=crownley/complex-client:$SHA
kubectl set image deployments/worker-deployment worker=crownley/complex-worker:$SHA