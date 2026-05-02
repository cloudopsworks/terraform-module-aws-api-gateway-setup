locals {
  local_vars  = yamldecode(file("./inputs.yaml"))
  spoke_vars  = yamldecode(file(find_in_parent_folders("spoke-inputs.yaml")))
  region_vars = yamldecode(file(find_in_parent_folders("region-inputs.yaml")))
  env_vars    = yamldecode(file(find_in_parent_folders("env-inputs.yaml")))
  global_vars = yamldecode(file(find_in_parent_folders("global-inputs.yaml")))

  local_tags  = jsondecode(file("./local-tags.json"))
  spoke_tags  = jsondecode(file(find_in_parent_folders("spoke-tags.json")))
  region_tags = jsondecode(file(find_in_parent_folders("region-tags.json")))
  env_tags    = jsondecode(file(find_in_parent_folders("env-tags.json")))
  global_tags = jsondecode(file(find_in_parent_folders("global-tags.json")))

  # Cross Account variables
  cross_account              = try(local.local_vars.cross_account.enabled, false)
  cross_account_alias        = try(local.local_vars.cross_account.alias, "cross_account")
  cross_account_region       = try(local.local_vars.cross_account.region, local.global_vars.default.region)
  cross_account_sts_role_arn = try(local.local_vars.cross_account.sts_role_arn, local.global_vars.default.sts_role_arn)

  tags = merge(
    local.global_tags,
    local.env_tags,
    local.region_tags,
    local.spoke_tags,
    local.local_tags
  )
}
{{ if .acm_enabled }}
dependency "acm" {
  config_path                             = "{{ .acm_path }}"
  mock_outputs_allowed_terraform_commands = ["validate", "destroy"]
  mock_outputs = {
    acm_certificate_arn = "arn:aws:acm:us-east-1:123456789012:certificate/12345678-1234-1234-1234-123456789012"
  }
}
{{ end }}
# Generate cross-account AWS provider block when the module validates Route53 records in another account.
generate "provider_l" {
  path        = "provider.l.tf"
  if_exists   = "overwrite_terragrunt"
  if_disabled = "remove_terragrunt"
  contents    = <<EOF_PROVIDER
provider "aws" {
  alias  = "${local.cross_account_alias}"
  region = "${local.cross_account_region}"

  assume_role {
    role_arn     = "${local.cross_account_sts_role_arn}"
    session_name = "terragrunt"
  }
}
EOF_PROVIDER
}

include "root" {
  path = find_in_parent_folders("{{ .RootFileName }}")
}

terraform {
  source = "{{ .sourceUrl }}"
}

inputs = {
  is_hub     = {{ .is_hub }}
  org        = local.env_vars.org
  spoke_def  = local.spoke_vars.spoke_def
  {{- range .requiredVariables }}
  {{- if ne .Name "org" }}
  {{ .Name }} = local.local_vars.{{ .Name }}
  {{- end }}
  {{- end }}
  {{- range .optionalVariables }}
  {{- if not (eq .Name "extra_tags" "is_hub" "spoke_def" "org") }}
  {{- if and $.acm_enabled (eq .Name "acm_certificate_arn") }}
  {{ .Name }} = dependency.acm.outputs.acm_certificate_arn
  {{- else }}
  {{ .Name }} = try(local.local_vars.{{ .Name }}, {{ .DefaultValue }})
  {{- end }}
  {{- end }}
  {{- end }}
  extra_tags = local.tags
}
