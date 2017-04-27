# Create a Bunch of Windows VMs in Azure From a Base Image

A Docker image which uses [Terraform](https://www.terraform.io/) and a custom VM stored in a VHD file to provision a fleet of identical Windows VMs. 

Useful for workshops and test environments. 

Run a container passing environment variables for your Azure subscription and the desired setup. The container will output a CSV file with the DNS name, username and password for each VM.

## Credits

Most of this came from [Docker Captain](https://github.com/StefanScherer/windows-docker-workshop) [Stefan Scherer](https://stefanscherer.github.io) - his [windows-docker-workshop](https://github.com/StefanScherer/windows-docker-workshop) repo. 

Mine is modified to use a VM image rather than provisioning each VM with a script, and it adds username and password generation for the VMs.

## Secrets

Get your Azure IDs and secrets.

You will need Azure environment variables for terraform, e.g. in a file called `azure-keys.env`:

```
ARM_SUBSCRIPTION_ID="uuid"
ARM_CLIENT_ID="uuid"
ARM_CLIENT_SECRET="secret"
ARM_TENANT_ID="uuid"
```

> You need an Azure Service Principal to get these details. The [Terraform docs](https://www.terraform.io/docs/providers/azurerm/) tell you what to do, but are terse. [Toddy's blog post](http://toddysm.com/2016/12/08/how-to-configure-terraform-to-work-with-azure-resource-manager/) walks through step-by-step.

## Configuration

The scripts use environment variables to configure the deployment, e.g. in a file called `terraform-vars.env`.

### Mandatory config values

```
TF_VAR_resource_group=elton-workshop
TF_VAR_storage_account=eltonstorage
TF_VAR_dns_prefix=dcesws
TF_VAR_region=eastus
TF_VAR_image_vhd_uri=https://xyz.blob.core.windows.net/vhds/image.vhd
```

This creates the default of one D2_V2 sized VM in the East US region, from a named VHD image

Some things to note:

* Resource group and storage account names need to be unique.

* DNS prefix is used for the public VM name, so it should be short. 

* The VHD needs to be a proper image. Easiest way is to create a VM in a DevTest lab, set it up how you want, and then create an image from it in the portal - it will run sysprep for you.

* The VHD does need to be publicly accessible, but you can use a shared access token rather than make the container public.

* Terraform copies the original VHD into a new storage account for the deployment. That can take a long time - 15-30 minutes. It's faster if your original VHD is in the same region as the target deployment. 

### Optional config values

Adding these to `terraform-vars.env` creates 10 VMs, sized D4_V2:

```
TF_VAR_vm_count="10"
TF_VAR_vm_size="Standard_D4_v2"
```

## Plan

```bash
docker run --env-file azure-keys.env --env-file terraform-vars.env sixeyed/azure-vm-provisioner plan
```

> Terraform will list out what it intends to do to create the infrastructure.

## Create / Apply

```bash
docker run --env-file azure-keys.env --env-file terraform-vars.env -v "$(pwd)\creds:c:\out" sixeyed/azure-vm-provisioner apply
```

> The generated VM names, usernames and passwords are stored in `C:\out\{resource-group}_{region}_credentials.csv`. Mount the volume to save the creds on your host machine. That's what you'll distribute to the attendees.

> Terraform doesn't inspect your Azure quotas, the deplopyment will just fail if it hits them. You'll need to bump your quotas if you want to create a lot of VMs (default is 10 cores per region). You can increase cores to 100 per VM size per region with a support request which gets automatically actioned. The limit of 60 public IP addresses per region will need a phone call to increase. 

## Destroy

```bash
docker run sixeyed/azure-vm-provisioner destroy
```

> It's faster to delete the Resource Group directly from the portal or CLI.