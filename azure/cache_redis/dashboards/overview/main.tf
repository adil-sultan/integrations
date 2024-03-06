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
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.azure_cache_redis_overview.id}"
  description = "OpenTelemetry Collector Cache Redis Dashboard URL"
}

resource "lightstep_dashboard" "azure_cache_redis_overview" {
  project_name          = var.lightstep_project
  dashboard_name        = "Cache Redis Metrics"
  dashboard_description = "[Beta] Monitor Cache Redis with this metrics overview dashboard."

  chart {
    name = "All Operations per Second"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_alloperationspersecond_maximum | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_shardid == $metadata_shardid) && (metadata_port == $metadata_port) && (metadata_primary == $metadata_primary)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "All Cache Hits"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_allcachehits_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_shardid == $metadata_shardid) && (metadata_port == $metadata_port) && (metadata_primary == $metadata_primary)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "All Cache Misses"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_allcachemisses_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_shardid == $metadata_shardid) && (metadata_port == $metadata_port) && (metadata_primary == $metadata_primary)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "All Used Memory %"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_allusedmemorypercentage_maximum | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_shardid == $metadata_shardid) && (metadata_port == $metadata_port) && (metadata_primary == $metadata_primary)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "All % Processor Time"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_allpercentprocessortime_maximum | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_shardid == $metadata_shardid) && (metadata_port == $metadata_port) && (metadata_primary == $metadata_primary)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "All Server Load"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_allserverload_maximum | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_shardid == $metadata_shardid) && (metadata_port == $metadata_port) && (metadata_primary == $metadata_primary)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "All Cache Read"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_allcacheread_maximum | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_shardid == $metadata_shardid) && (metadata_port == $metadata_port) && (metadata_primary == $metadata_primary)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "All Cache Write"
    rank = "7"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_allcachewrite_maximum | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_shardid == $metadata_shardid) && (metadata_port == $metadata_port) && (metadata_primary == $metadata_primary)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "All Evicted Keys"
    rank = "8"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_allevictedkeys_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_shardid == $metadata_shardid) && (metadata_port == $metadata_port) && (metadata_primary == $metadata_primary)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "All Expired Keys"
    rank = "9"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_allexpiredkeys_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_shardid == $metadata_shardid) && (metadata_port == $metadata_port) && (metadata_primary == $metadata_primary)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "All Connected Clients"
    rank = "10"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_allconnectedclients_maximum | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_shardid == $metadata_shardid) && (metadata_port == $metadata_port) && (metadata_primary == $metadata_primary)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "All Connections Closed per Second"
    rank = "11"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_allconnectionsclosedpersecond_maximum | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_shardid == $metadata_shardid) && (metadata_primary == $metadata_primary)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "All Connections Created per Second"
    rank = "12"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_allconnectionscreatedpersecond_maximum | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_shardid == $metadata_shardid) && (metadata_primary == $metadata_primary)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "All Get Commands"
    rank = "13"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_allgetcommands_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_shardid == $metadata_shardid) && (metadata_port == $metadata_port) && (metadata_primary == $metadata_primary)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "All Set Commands"
    rank = "14"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_allsetcommands_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_shardid == $metadata_shardid) && (metadata_port == $metadata_port) && (metadata_primary == $metadata_primary)) | delta | group_by [], sum
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
    name                     = "metadata_port"
    default_values           = []
    suggestion_attribute_key = "metadata_port"
  }

  template_variable {
    name                     = "metadata_primary"
    default_values           = []
    suggestion_attribute_key = "metadata_primary"
  }

  template_variable {
    name                     = "metadata_shardid"
    default_values           = []
    suggestion_attribute_key = "metadata_shardid"
  }
}
