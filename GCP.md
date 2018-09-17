# Running on Google Compute Platform

## One-time
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



--create-disk=image=ubuntu-1604-lts,image-project=ubuntu-os-cloud \


