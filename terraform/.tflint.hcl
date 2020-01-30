config {
  module = true
  deep_check = true
  force = false

  varfile = [
    "variables.tfvars"
  ]
}

rule "terraform_dash_in_resource_name" {
  enabled = true
}

rule "terraform_dash_in_output_name" {
  enabled = true
}

rule "terraform_documented_outputs" {
  enabled = true
}

rule "terraform_documented_variables" {
  enabled = true
}

rule "terraform_module_pinned_source" {
  enabled = true
}

rule "terraform_module_semver_source" {
  enabled = true
}
