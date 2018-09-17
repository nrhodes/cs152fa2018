# Running on Google Compute Platform

## One-time

### Get Google Cloud SDK Installed


1. Install [Google Cloud SDK](https://cloud.google.com/sdk/install) on your local machine. (For Mac OS and Windows, you'll want to use the interactive installer at [https://cloud.google.com/sdk/docs/downloads-interactive]).  Run only steps 1 and steps 2 (_don't *run step 3 ```gcloud init``` yet_). For steps 1 and 2, you can answer any questions with default (just hit Enter).

2. Go to the [GCP Console](console.cloud.google.com) 

3. Create a Service account

    1. On the left bar, go to IAM & admin -> Service accounts
    2. Add a Service Account name
    3. Specify project role as owner [project -> owner]
    4. Select “furnish a new private key”
    5. Select type as JSON
	   A json file will be downloaded. Save file locally and find the path to json file
       
3. Now it's time to authenticate:
```
gcloud auth activate-service-account [client_email] --key-file=[json_file_path]```
        where client\_email is in the json file (look for the ```client_email`` field in the json file) downloaded and json\_file\_path is the path to the json file
		
4. Now, you can run ```gcloud init``` from your local terminal window
    1. Use defaults except:
		 * when prompted *API [cloudresourcemanager.googleapis.com] not enabled on project. Would you like to anable and retry (this wkll take a few minutes)?*, answer ```Y```
	     * when asked  *Which Google Compute Engine zone would you like to use as project default?*, answer ```[11] us-west1-b``.




### Use Google Cloud SDK to get an instance created and running
Run all these commands from your local terminal window.

3. Add a firewall rule (this will allow incoming connections to your jupyter server):
```
gcloud compute firewall-rules create default-allow-jupyterx \
--allow tcp:8888-8889 \
--target-tags=jupyter
```
4. Create a GCE instance named cs15 (once complete, this instance *will be running*. Make sure to stop it once you are done):
```
gcloud compute instances create cs152 \
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

After this is successful, then restart your GCP instance:
```
sudo reboot
```

Now, ssh back into your instance:
```
gcloud compute ssh cs152 --ssh-flag="-L" --ssh-flag="8888:localhost:8888"  
```


Next, let's run our second script:

```
cs152/bin/setup2.sh
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

Once your instance is running, you can ssh into it: 
```
gcloud compute ssh cs152 --ssh-flag="-L" --ssh-flag="8888:localhost:8888"  
```
and then run jupyter notebook (from your SSH window):
```
source activate cs152 # enter cs152 virtual environment
jupyter lab    # run jupyter lab
```

You'll see a line in the jupyter lab output that looks like:




