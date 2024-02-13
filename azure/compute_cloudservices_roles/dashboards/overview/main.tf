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
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.azure_compute_cloudservices_roles_overview.id}"
  description = "OpenTelemetry Collector Compute Cloud Services Roles Dashboard URL"
}

resource "lightstep_dashboard" "azure_compute_cloudservices_roles_overview" {
  project_name          = var.lightstep_project
  dashboard_name        = "Compute Cloud Services Roles Metrics"
  dashboard_description = "[Beta] Monitor Compute Cloud Services Roles with this metrics overview dashboard."

  chart {
    name = "Percentage CPU"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_percentage_cpu_average | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_roleinstanceid == $metadata_roleinstanceid) && (metadata_roleid == $metadata_roleid)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Available Memory Bytes"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_available_memory_bytes_average | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_roleinstanceid == $metadata_roleinstanceid) && (metadata_roleid == $metadata_roleid)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Disk Read Operations/Sec"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_disk_read_operations/sec_average | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_roleinstanceid == $metadata_roleinstanceid) && (metadata_roleid == $metadata_roleid)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Disk Write Operations/Sec"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_disk_write_operations/sec_average | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_roleinstanceid == $metadata_roleinstanceid) && (metadata_roleid == $metadata_roleid)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Network In Total"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_network_in_total_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_roleinstanceid == $metadata_roleinstanceid) && (metadata_roleid == $metadata_roleid)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Network Out Total"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_network_out_total_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_roleinstanceid == $metadata_roleinstanceid) && (metadata_roleid == $metadata_roleid)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Disk Read Bytes"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_disk_read_bytes_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_roleinstanceid == $metadata_roleinstanceid) && (metadata_roleid == $metadata_roleid)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Disk Write Bytes"
    rank = "7"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_disk_write_bytes_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_roleinstanceid == $metadata_roleinstanceid) && (metadata_roleid == $metadata_roleid)) | delta | group_by [], sum
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
    name                     = "metadata_roleid"
    default_values           = []
    suggestion_attribute_key = "metadata_roleid"
  }

  template_variable {
    name                     = "metadata_roleinstanceid"
    default_values           = []
    suggestion_attribute_key = "metadata_roleinstanceid"
  }
}
