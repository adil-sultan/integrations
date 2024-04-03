terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.93.2"
    }
  }
  required_version = ">= v1.0.11"
}

variable "lightstep_project" {
  description = "ServiceNow Cloud Observability Project Name"
  type        = string
}

output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.azure_storage_storageaccounts_objectreplicationpolicies_overview.id}"
  description = "OpenTelemetry Collector Storage Object Replication Policies Dashboard URL"
}

resource "lightstep_dashboard" "azure_storage_storageaccounts_objectreplicationpolicies_overview" {
  project_name          = var.lightstep_project
  dashboard_name        = "Storage Object Replication Policies Metrics"
  dashboard_description = "[Beta] Monitor Storage Object Replication Policies with this metrics overview dashboard."

  chart {
    name = "Pending Replication Bytes"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_pendingbytesforreplication_average | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_timebucket == $metadata_timebucket)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Pending Replication Operations"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_pendingoperationsforreplication_average | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_timebucket == $metadata_timebucket)) | delta | group_by [], sum
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
    name                     = "metadata_timebucket"
    default_values           = []
    suggestion_attribute_key = "metadata_timebucket"
  }
}
