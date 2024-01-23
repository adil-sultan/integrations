terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.87.0"
    }
  }
  required_version = ">= v1.0.11"
}

variable "lightstep_project" {
  description = "ServiceNow Cloud Observability Project Name"
  type        = string
}

output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.azure_compute_disks_overview.id}"
  description = "OpenTelemetry Collector Compute Disks Dashboard URL"
}

resource "lightstep_dashboard" "azure_compute_disks_overview" {
  project_name          = var.lightstep_project
  dashboard_name        = "Compute Disks Metrics"
  dashboard_description = "Monitor Compute Disks with this metrics overview dashboard."

  chart {
    name = "Read Bytes/Sec"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_composite_disk_read_bytes/sec_average | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Read Operations/Sec"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_composite_disk_read_operations/sec_average | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id)   &&  (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Write Bytes/Sec"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_composite_disk_write_bytes/sec_average | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Write Operations/Sec"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_composite_disk_write_operations/sec_average | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Paid Burst Iops"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_diskpaidburstiops_average | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location)) | delta | group_by [], sum
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
}
