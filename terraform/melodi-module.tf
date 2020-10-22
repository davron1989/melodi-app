module "artemis_deploy" {
  source                 = "fuchicorp/chart/helm"
  deployment_name        = "melodi"
  deployment_environment = "dev"
  deployment_endpoint    = "melodi.${var.google_domain_name}"
  deployment_path        = "melodi"
}
