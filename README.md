# melodi-app
This is a test app.
kubernetes resources are created with helm.
terraform is used to deploy the app

requirements:

1) GCP Cluster
2) terraform
3) helm


Usage 

1) Create helm charts 

mkdir melodi
cd melodi
helm create melodi-app  ## this creates charts folder
modifiy values.yaml file in charts
helm install --name melodi

2) deploying with terraform

cd melodi
mkdir terraform
mv ./charts  ./terraform

3) create a terraform module:
cd terraform
vim melodi-module.tf

module "artemis_deploy" {
  source                 = "fuchicorp/chart/helm"
  deployment_name        = "artemis"
  deployment_environment = "dev"
  deployment_endpoint    = "artemis.${var.google_domain_name}"
  deployment_path        = "artemis"
}

4) Create variables file

vim variables.tf

variable "google_domain_name" {
  default = "fuchicorp.com"
  description = "Please change to your domain name"
}

5) create tfvar file

vim melodi.tfvars

google_domain_name = "davrononline.com"

6) softcode values.yaml file to use variables

hosts:
    - host: artemis.davrononline.com
      paths:
      - /

  tls:
    - secretName: artemis
      hosts:
      - artemis.davrononline.com
now we need to update it to this:

 hosts:
    - host: ${deployment_endpoint}
      paths:
      - /

  tls:
    - secretName: artemis
      hosts:
      - ${deployment_endpoint}
      
7) delete helm deployment

helm ls
helm --purge melodi

8) deploy with terraform to dev envirenment

terraform init
terraform plan -var-file melodi.tfvars
terraform apply -var-file melodi.tfvars


