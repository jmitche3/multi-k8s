docker build -t jordanmitchell146/multi-client:latest -t jordanmitchell146/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jordanmitchell146/multi-server:latest -t jordanmitchell146/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jordanmitchell146/multi-worker:latest -t jordanmitchell146/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jordanmitchell146/multi-client:latest
docker push jordanmitchell146/multi-server:latest
docker push jordanmitchell146/multi-worker:latest

docker push jordanmitchell146/multi-client:$SHA
docker push jordanmitchell146/multi-server:$SHA
docker push jordanmitchell146/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jordanmitchell146/multi-server:$SHA
kubectl set image deployments/client-deployment client=jordanmitchell146/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jordanmitchell146/multi-worker:$SHA