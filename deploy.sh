docker build -t svdimchenko/multi-client:latest -t svdimchenko/multi-client:"$SHA" -f ./client/Dockerfile ./client
docker build -t svdimchenko/multi-server:latest -t svdimchenko/multi-server:"$SHA" -f ./server/Dockerfile ./server
docker build -t svdimchenko/multi-worker:latest -t svdimchenko/multi-worker:"$SHA" -f ./worker/Dockerfile ./worker

docker push svdimchenko/multi-client:latest
docker push svdimchenko/multi-server:latest
docker push svdimchenko/multi-worker:latest

docker push svdimchenko/multi-client:"$SHA"
docker push svdimchenko/multi-server:"$SHA"
docker push svdimchenko/multi-worker:"$SHA"

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=svdimchenko/multi-client:"$SHA"
kubectl set image deployments/server-deployment server=svdimchenko/multi-server:"$SHA"
kubectl set image deployments/worker-deployment worker=svdimchenko/multi-worker:"$SHA"
