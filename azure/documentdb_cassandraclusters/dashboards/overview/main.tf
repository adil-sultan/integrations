terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.91.7"
    }
  }
  required_version = ">= v1.0.11"
}

variable "lightstep_project" {
  description = "ServiceNow Cloud Observability Project Name"
  type        = string
}

output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.azure_documentdb_cassandraclusters_overview.id}"
  description = "OpenTelemetry Collector DocumentDB Cassandra Clusters Dashboard URL"
}

resource "lightstep_dashboard" "azure_documentdb_cassandraclusters_overview" {
  project_name          = var.lightstep_project
  dashboard_name        = "DocumentDB Cassandra Clusters Metrics"
  dashboard_description = "[Beta] Monitor DocumentDB Cassandra Clusters with this metrics overview dashboard."

  chart {
    name = "CPU"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_cpu_average | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Memory %"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_percent_mem_average | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Cache Capacity"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_cassandra_cache_capacity_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_cassandra_datacenter == $metadata_cassandra_datacenter) && (metadata_cassandra_node == $metadata_cassandra_node) && (metadata_cache_name == $metadata_cache_name)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Cache Entries"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_cassandra_cache_entries_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_cassandra_datacenter == $metadata_cassandra_datacenter) && (metadata_cassandra_node == $metadata_cassandra_node) && (metadata_cache_name == $metadata_cache_name)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Cache Hit Rate"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_cassandra_cache_hit_rate_average | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_cassandra_datacenter == $metadata_cassandra_datacenter) && (metadata_cassandra_node == $metadata_cassandra_node) && (metadata_cache_name == $metadata_cache_name)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Cache Requests Total"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_cassandra_cache_requests_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_cassandra_datacenter == $metadata_cassandra_datacenter) && (metadata_cassandra_node == $metadata_cassandra_node) && (metadata_cache_name == $metadata_cache_name)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Client Request Failures"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_cassandra_client_request_failures_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_cassandra_datacenter == $metadata_cassandra_datacenter) && (metadata_cassandra_node == $metadata_cassandra_node)) | delta | group_by [], sum
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
metric azure_disk_utilization_average | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Table Read Latency"
    rank = "8"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_cassandra_table_read_latency_average | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_cassandra_datacenter == $metadata_cassandra_datacenter) && (metadata_cassandra_node == $metadata_cassandra_node)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Table Write Latency"
    rank = "9"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_cassandra_table_write_latency_average | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_cassandra_datacenter == $metadata_cassandra_datacenter) && (metadata_cassandra_node == $metadata_cassandra_node)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Cache Size Total"
    rank = "10"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_cassandra_cache_size_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_cassandra_datacenter == $metadata_cassandra_datacenter) && (metadata_cassandra_node == $metadata_cassandra_node) && (metadata_cache_name == $metadata_cache_name)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Table Speculative Retries"
    rank = "11"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_cassandra_table_speculative_retries_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_cassandra_datacenter == $metadata_cassandra_datacenter) && (metadata_cassandra_node == $metadata_cassandra_node)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Thread Pools Active Tasks"
    rank = "12"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_cassandra_thread_pools_active_tasks_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_cassandra_datacenter == $metadata_cassandra_datacenter) && (metadata_cassandra_node == $metadata_cassandra_node)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Thread Pools Pending Tasks"
    rank = "13"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_cassandra_thread_pools_pending_tasks_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_cassandra_datacenter == $metadata_cassandra_datacenter) && (metadata_cassandra_node == $metadata_cassandra_node)) | delta | group_by [], sum
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
    name                     = "metadata_cache_name"
    default_values           = []
    suggestion_attribute_key = "metadata_cache_name"
  }

  template_variable {
    name                     = "metadata_cassandra_datacenter"
    default_values           = []
    suggestion_attribute_key = "metadata_cassandra_datacenter"
  }

  template_variable {
    name                     = "metadata_cassandra_node"
    default_values           = []
    suggestion_attribute_key = "metadata_cassandra_node"
  }
}
