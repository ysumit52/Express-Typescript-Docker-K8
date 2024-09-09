# Express-Typescript-Docker-K8
A boilerplate for creating API using Express, Typescript, MongoDB, Jest, Docker and K8s

### What is it?
Try to implement A Class Base Routing package (routing-controllers) with clean structure and in Node.js, Express.js, Typescript, Docker, K8s

### Features

- **Sentry** catch errors.
- **API Documentation** using **Swagger**.
- **Basic Security Features** using [Helmet](https://github.com/helmetjs/helmet), [hpp](https://github.com/analog-nico/hpp) and [xss clean](https://github.com/jsonmaur/xss-clean).
- **Validation** using [class-validator](https://github.com/typestack/class-validator)
- **class base routing** using [routing-controllers](https://github.com/typestack/routing-controllers)
- **Authentication** - using [Passport.js](https://github.com/jaredhanson/passport) [passport-jwt](https://github.com/mikenicholson/passport-jwt) which is compatible with Express.js and is a authentication middleware for Node.js.
- **Database** using [mongoose](https://mongoosejs.com/) odm for interacting with mongoDB.
- **run testing** using [Jest](https://jestjs.io/)
- **linting** using [ESLint](https://eslint.org/)
- **prettier** using [Prettier](https://prettier.io/)

<br />

## Getting Started

 install dependencies

```bash
yarn install
```
<br>

### Without Docker
Note: It is assumed here that you have MongoDB running in the background.

set `.env.development.local` file with your credentials.(like DB URL)

Run the app
```bash
yarn dev
```

### With Docker
Note: It is assumed here that you have installed Docker and running in the background.

You can check the status of the docker if it's running

```bash
docker info
```

This command will go through the Dockerfile and create new images with the changes.

```bash
docker-compose up --build
```

After rebuilding the images, you'll need to recreate the containers to apply the changes. You can use the docker-compose up command with the --force-recreate option to do this. This will stop and remove existing containers and create new ones based on the rebuilt images.

```bash
docker-compose up --force-recreate
```

if the docker compose file is in different directory

```bash
docker-compose -f /path/to/your/folder/docker-compose.yml up --build
```

Run 
```bash
http://127.0.0.1:3000/api/
```

To remove the build cache, you can use:

```bash
docker builder prune
```

If you want to force the prune operation without a confirmation prompt and clean all cache, use:

```bash
docker builder prune --all --force
```

Stop and remove containers (when you're done testing):

```bash
docker-compose down
```
Remove a specific image by ID or tag:

```bash
docker rmi <image_id_or_tag>
```

Remove all unused images (dangling images):

```bash
docker image prune
```

Remove a specific volume by name:

```bash
docker volume rm <volume_name>
```
Remove all unused volumes:

```bash
docker volume prune
```

### With K8
Note: It is assumed here that you have installed Kubectl, minikube and running in the background.

Check Minikube Status:

```bash
minikube status
```

If Minikube is not running, you can start it with:

```bash
minikube start
```
Check Kubernetes Cluster Status:

```bash
kubectl get nodes
```

If kubectl shows an error like "Unable to connect to the server," ensure that Minikube is running and that your kubectl context is set to Minikube. You can set the context with:

```bash
kubectl config use-context minikube
```

Ensure you are logged in to Docker Hub:

```bash
docker login
```

Build the docker images with the below command

```bash
docker build -t <docker_image_name_on_hub>:<tag_name_if_any> .
```
If wanted to rebuild your Docker image from scratch to avoid caching issues:

```bash
docker build --no-cache -t <docker_image_name_on_hub>:<tag_name_if_any> .
```

Run the Docker Container if you want to test it else skip this step:

```bash
docker run -d --name my_container -p 3000:3000 <docker_image_name_on_hub>:<tag_name_if_any>
```

If you need any specific environment variables or volume mounts, you can add those to the docker run command. For example:

```bash
docker run -d --name my_container -p 3000:3000 -e ENV_VAR=value -v /host/path:/container/path <docker_image_name_on_hub>:<tag_name_if_any>
```

Find the details of the images created

```bash
docker images
```

Push the docker image to the docker hub

```bash
docker push <docker_image_name_on_hub>:<tag_name_if_any>
```

If you want to Tag the image and push it to your Docker Hub repository:

```bash
docker tag your-image-name:latest your-dockerhub-username/your-image-name:latest
docker push your-dockerhub-username/your-image-name:latest
```

After push to docker hub, you can apply them in Kubernetes using the following commands:
```bash
kubectl apply -f ./deployments/mongodb-deployment.yaml
kubectl apply -f ./deployments/mongodb-service.yaml
kubectl apply -f ./deployments/nodejs-deployment.yaml
kubectl apply -f ./deployments/nodejs-service.yaml
```

Check if everything is running correctly:

```bash
kubectl get pods
kubectl get svc
```

To delete the above Kubernetes pods, you can use

```bash
kubectl delete pod <use the ood name or id>
```

Alternatively, if these pods are part of a deployment, you might want to delete the deployment itself to recreate all pods associated with it:

```bash
kubectl delete deployment <deployment-name>
```

# Minikube

Starts a local Kubernetes cluster.

```bash
minikube start
```
Stops the Minikube cluster without deleting it.

```bash
minikube stop
```

Deletes the Minikube cluster and all its data.

```bash
minikube delete
```
Enables a specific addon (e.g., metrics-server, ingress).

```bash
minikube addons enable <addon-name>
```
Creates a tunnel to make LoadBalancer services accessible on localhost.

```bash
minikube tunnel
```

Change Resource Allocations (CPU, Memory):

```bash
minikube config set memory <amount>
minikube config set cpus <number>
```

To get the URL for a service running in Minikube, you can use the minikube service command. Here’s how to do it:

Get the URL:

```bash
minikube service <service-name>
```

If you only want the URL without opening it in the browser, use:

```bash
minikube service <service-name> --url
```

# MongoDB

If you have mongosh (the MongoDB Shell) installed, you can use it to check connectivity. Run:

```bash
mongosh --host <host> --port <port>
```

If you need to connect from another Docker container, use a command like this:

```bash
docker run -it --network <network_name> --rm mongo:6.0 mongosh --host <mongodb_container_name> --port 27017
```

If you face issues, checking the logs of the MongoDB container can provide insight into potential problems:

```bash
docker logs <mongodb_container_name>
```

Ensure that your MongoDB container is configured correctly to accept connections. The configuration file (mongod.conf) should have the bindIp setting appropriately set. For example:

```bash
net:
  bindIp: 0.0.0.0
```