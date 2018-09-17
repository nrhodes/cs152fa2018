# Running on Google Compute Platform

## One-time

Let's get the google cloud SDK installed, and get an instance created and running, and let's login to it.

1. Install [Google Cloud SDK[https://cloud.google.com/sdk/install] on your local machine. (For Mac OS, you'll want to use the interactive installer). Warning, when the instructions say to do:
```
gcloud init
```
Instead, run:
```
gcloud auth application-default login
```
2. Set your default Google Cloud zone (us-west1-b has GPU instances):
```
gcloud config set compute/zone us-west1-b
```
3. Add a firewall rule (this will allow incoming connections to your jupyter server):
```
gcloud compute firewall-rules create default-allow-jupyterx \
--allow tcp:8888-8889 \
--target-tags=jupyter
```
4. Create a GCE instance named cs15 (once complete, this instance *will be running*. Make sure to stop it once you are done):
```
gcloud compute instances create cs152x \
--accelerator=count=1,type=nvidia-tesla-k80 \
--boot-disk-size=30GB \
--image-family ubuntu-1604-lts \
--image-project ubuntu-os-cloud \
--machine-type=n1-standard-4 \
--preemptible \
--tags=jupyter 
```
    * If you want (and are willing to pay for) an SSD, add the following option to the previous command:
    ````
    --boot-disk-type=pd-ssd
    ```
5. Open an ssh window to your new instance. Note that we are setting up ssh forwarding so that any references to port 8888 on our local host will be redirected to port 8888 on our GCE instance (which, eventually, will be running our Jupyter server).
```
gcloud compute ssh cs152 --ssh-flag="-L" --ssh-flag="8888:localhost:8888"  
```

Now, it's time to start installing/configuring software

First, let's pull in our repository that contains our scripts (along with our notebooks, and so on):
```
  git clone https://github.com/nrhodes/cs152.git 
```

Next, let's run our first script:

```
cs152/bin/setup.sh
```



### Stopping and Starting

#### Stopping your instance
```
gcloud compute instances stop cs152
```

#### Starting your instance
```
gcloud compute instances start cs152
```




