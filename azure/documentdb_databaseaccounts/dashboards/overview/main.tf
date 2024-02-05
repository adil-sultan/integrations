terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.89.0"
    }
  }
  required_version = ">= v1.0.11"
}

variable "lightstep_project" {
  description = "ServiceNow Cloud Observability Project Name"
  type        = string
}

output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.azure_documentdb_databaseaccounts_overview.id}"
  description = "OpenTelemetry Collector DocumentDB Database Accounts Dashboard URL"
}

resource "lightstep_dashboard" "azure_documentdb_databaseaccounts_overview" {
  project_name          = var.lightstep_project
  dashboard_name        = "DocumentDB Database Accounts Metrics"
  dashboard_description = "Monitor DocumentDB Database Accounts with this metrics overview dashboard."

  chart {
    name = "Total Requests"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_totalrequests_count | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_databasename == $metadata_databasename) && (metadata_collectionname == $metadata_collectionname) && (metadata_region == $metadata_region)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Document Count"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_documentcount_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_collectionname == $metadata_collectionname) && (metadata_databasename == $metadata_databasename) && (metadata_region == $metadata_region)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Data Usage"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_datausage_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_collectionname == $metadata_collectionname) && (metadata_databasename == $metadata_databasename) && (metadata_region == $metadata_region)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Service Availability"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_serviceavailability_average | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Server Side Latency"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_serversidelatency_average | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_databasename == $metadata_databasename) && (metadata_collectionname == $metadata_collectionname) && (metadata_region == $metadata_region)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Metadata Requests"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_metadatarequests_count | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_databasename == $metadata_databasename) && (metadata_collectionname == $metadata_collectionname) && (metadata_region == $metadata_region)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Provisioned Throughput"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_provisionedthroughput_maximum | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_databasename == $metadata_databasename) && (metadata_collectionname == $metadata_collectionname)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Server Side Latency Direct"
    rank = "7"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_serversidelatencydirect_average | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_databasename == $metadata_databasename) && (metadata_collectionname == $metadata_collectionname) && (metadata_region == $metadata_region)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Total Request Units"
    rank = "8"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_totalrequestunits_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_databasename == $metadata_databasename) && (metadata_collectionname == $metadata_collectionname) && (metadata_region == $metadata_region)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Replication Latency"
    rank = "9"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_replicationlatency_average | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Autoscale Max Throughput"
    rank = "10"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_autoscalemaxthroughput_maximum | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_databasename == $metadata_databasename) && (metadata_collectionname == $metadata_collectionname)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Available Storage"
    rank = "11"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_availablestorage_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_collectionname == $metadata_collectionname) && (metadata_databasename == $metadata_databasename) && (metadata_region == $metadata_region)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Table Throughput Update"
    rank = "12"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_tabletablethroughputupdate_count | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location)) | delta | group_by [], sum
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
    name                     = "metadata_collectionname"
    default_values           = []
    suggestion_attribute_key = "metadata_collectionname"
  }

  template_variable {
    name                     = "metadata_databasename"
    default_values           = []
    suggestion_attribute_key = "metadata_databasename"
  }

  template_variable {
    name                     = "metadata_region"
    default_values           = []
    suggestion_attribute_key = "metadata_region"
  }
}
