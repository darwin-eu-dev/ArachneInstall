# Installation and testing of Arachne

To install Arachne first install Docker.

Then clone this repo locally on the machine where you want to install Arachne

You only need three files to install Arachne: 

- docker-compose.yml (the docker compose file used to deploy Arachne)
- datanode.env (environment variables for datanode application)
- descriptor_base.json (the specification for the default environment. Not really used when in Docker mode)

You will need to edit the docker-compose.yml file.

Change the path name under volumes to match a path on your computer.

```
    volumes:
      - /tmp:/tmp
      - /var/run/docker.sock:/var/run/docker.sock
      - /tmp/executions:/etc/executions
      - /Users/ablack/Desktop/ArachneInstall:/runtimes
      
```

The path to the env file needs to be correct and point to a location on your computer

```
    env_file:
      - ~/Desktop/ArachneInstall/datanode.env  # Environment variables file
```

You might also need to change the port mappings if you have other services already running on the default ports. If you do change the port you may need to 
edit datanode.env to match the port you chose.

After making sure the paths point to correct locations on your system and making sure you have docker installed navigate to the folder with the docker-compose.yml file and run `docker compose up`

The app should take a couple minutes to start up and the be available on localhost:8082 (default port)

Log in with 

username: admin

password: ohdsi


If startup fails for some reason run `docker compose down` and `docker compose up` to restart the whole application.

You can see the running containers with `docker ps` and view the logs with `docker logs <container name>`

Next try configuring the database connections and then running the ArachneTest in the tests folder. To run the test, compress the R project called ArachneTest in the tests folder of this repo and upload it to Arachne. 

In the environment dialog box enter `executionengine.azurecr.io/darwin-base:v0.3`

If you get an error you may need to manually pull the image first by running the command ` docker pull executionengine.azurecr.io/darwin-base:v0.3` 




