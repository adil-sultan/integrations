terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.92.0"
    }
  }
  required_version = ">= v1.0.11"
}

variable "lightstep_project" {
  description = "Cloud Observability Project Name"
  type        = string
}

output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.azure_machinelearningservices_workspaces_onlineendpoints_deployments_overview.id}"
  description = "OpenTelemetry Collector Machine Learning Services Workspaces Online Endpoints Deployments Dashboard URL"
}

resource "lightstep_dashboard" "azure_machinelearningservices_workspaces_onlineendpoints_deployments_overview" {
  project_name          = var.lightstep_project
  dashboard_name        = "Machine Learning Services Workspaces Online Endpoints Deployments Metrics"
  dashboard_description = "[Beta] Monitor Machine Learning Services Workspaces Online Endpoints Deployments with this metrics overview dashboard."

  chart {
    name = "CPU Utilization %"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_cpuutilizationpercentage_average | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_instanceid == $metadata_instanceid)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "CPU Memory Utilization %"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_cpumemoryutilizationpercentage_average | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_instanceid == $metadata_instanceid)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "GPU Memory Utilization %"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_gpumemoryutilizationpercentage_average | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_instanceid == $metadata_instanceid)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "GPU Utilization %"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_gpuutilizationpercentage_average | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_instanceid == $metadata_instanceid)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Data Collection Errors Per Minute"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_datacollectionerrorsperminute_average | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_instanceid == $metadata_instanceid) && (metadata_type == $metadata_type)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Data Collection Events Per Minute"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_datacollectioneventsperminute_average | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_instanceid == $metadata_instanceid) && (metadata_type == $metadata_type)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Deployment Capacity"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_deploymentcapacity_average | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_instanceid == $metadata_instanceid) && (metadata_state == $metadata_state)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Disk Utilization"
    rank = "7"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_diskutilization_maximum | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_instanceid == $metadata_instanceid)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "GPU Energy Joules"
    rank = "8"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_gpuenergyjoules_average | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_instanceid == $metadata_instanceid)) | delta | group_by [], sum
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
    name                     = "metadata_instanceid"
    default_values           = []
    suggestion_attribute_key = "metadata_instanceid"
  }

  template_variable {
    name                     = "metadata_state"
    default_values           = []
    suggestion_attribute_key = "metadata_state"
  }

  template_variable {
    name                     = "metadata_type"
    default_values           = []
    suggestion_attribute_key = "metadata_type"
  }
}
