terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.91.1"
    }
  }
  required_version = ">= v1.0.11"
}

variable "lightstep_project" {
  description = "Cloud Observability Project Name"
  type        = string
}

output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.azure_cdn_cdnwebapplicationfirewallpolicies_overview.id}"
  description = "OpenTelemetry Collector CDN Web Application Firewall Policies Dashboard URL"
}

resource "lightstep_dashboard" "azure_cdn_cdnwebapplicationfirewallpolicies_overview" {
  project_name          = var.lightstep_project
  dashboard_name        = "CDN Web Application Firewall Policies Metrics"
  dashboard_description = "[Beta] Monitor CDN Web Application Firewall Policies with this metrics overview dashboard."

  chart {
    name = "Web Application Firewall Requests"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_webapplicationfirewallrequestcount_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_policyname == $metadata_policyname) && (metadata_rulename == $metadata_rulename) && (metadata_action == $metadata_action)) | delta | group_by [], sum
EOT
    }
  }

  template_variable {
    name                     = "azuremonitor_resource_id"
    default_values           = []
    suggestion_attribute_key = "azuremonitor.resource_id"
  }

  template_variable {
    name                     = "azuremonitor_subscription_id"
    default_values           = []
    suggestion_attribute_key = "azuremonitor.subscription_id"
  }

  template_variable {
    name                     = "azuremonitor_tenant_id"
    default_values           = []
    suggestion_attribute_key = "azuremonitor.tenant_id"
  }

  template_variable {
    name                     = "location"
    default_values           = []
    suggestion_attribute_key = "location"
  }

  template_variable {
    name                     = "metadata_action"
    default_values           = []
    suggestion_attribute_key = "metadata_action"
  }

  template_variable {
    name                     = "metadata_policyname"
    default_values           = []
    suggestion_attribute_key = "metadata_policyname"
  }

  template_variable {
    name                     = "metadata_rulename"
    default_values           = []
    suggestion_attribute_key = "metadata_rulename"
  }
}
