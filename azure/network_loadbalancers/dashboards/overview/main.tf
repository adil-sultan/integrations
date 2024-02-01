terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.88.0"
    }
  }
  required_version = ">= v1.0.11"
}

variable "lightstep_project" {
  description = "Cloud Observability Project Name"
  type        = string
}

output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.azure_network_loadbalancers_overview.id}"
  description = "OpenTelemetry Collector Network Load Balancers Dashboard URL"
}

resource "lightstep_dashboard" "azure_network_loadbalancers_overview" {
  project_name          = var.lightstep_project
  dashboard_name        = "Network Load Balancers Metrics"
  dashboard_description = "[Beta] Monitor Network Load Balancers with this metrics overview dashboard."

  chart {
    name = "Global Backend Availability"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_globalbackendavailability_average | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_frontendipaddress == $metadata_frontendipaddress) && (metadata_frontendport == $metadata_frontendport) && (metadata_backendipaddress == $metadata_backendipaddress)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Allocated SNAT Ports"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_allocatedsnatports_average | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_frontendipaddress == $metadata_frontendipaddress) && (metadata_backendipaddress == $metadata_backendipaddress)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Packet Count"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_packetcount_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_frontendipaddress == $metadata_frontendipaddress) && (metadata_frontendport == $metadata_frontendport)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Byte Count"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_bytecount_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_frontendipaddress == $metadata_frontendipaddress) && (metadata_frontendport == $metadata_frontendport)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Used SNAT Ports"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_usedsnatports_average | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_frontendipaddress == $metadata_frontendipaddress) && (metadata_backendipaddress == $metadata_backendipaddress)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "SNAT Connection Count"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_snatconnectioncount_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_frontendipaddress == $metadata_frontendipaddress) && (metadata_backendipaddress == $metadata_backendipaddress)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Health Probe Status"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_dipavailability_average | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_frontendipaddress == $metadata_frontendipaddress) && (metadata_frontendport == $metadata_frontendport) && (metadata_backendipaddress == $metadata_backendipaddress)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "SYN Count"
    rank = "7"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_syncount_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_frontendipaddress == $metadata_frontendipaddress) && (metadata_frontendport == $metadata_frontendport)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Data Path Availability"
    rank = "8"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_vipavailability_average | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_frontendipaddress == $metadata_frontendipaddress) && (metadata_frontendport == $metadata_frontendport)) | delta | group_by [], sum
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
    name                     = "metadata_backendipaddress"
    default_values           = []
    suggestion_attribute_key = "metadata_backendipaddress"
  }

  template_variable {
    name                     = "metadata_frontendipaddress"
    default_values           = []
    suggestion_attribute_key = "metadata_frontendipaddress"
  }

  template_variable {
    name                     = "metadata_frontendport"
    default_values           = []
    suggestion_attribute_key = "metadata_frontendport"
  }
}
