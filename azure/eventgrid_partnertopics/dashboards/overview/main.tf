terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.90.0"
    }
  }
  required_version = ">= v1.0.11"
}

variable "lightstep_project" {
  description = "Cloud Observability Project Name"
  type        = string
}

output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.azure_eventgrid_partnertopics_overview.id}"
  description = "OpenTelemetry Collector Event Grid Partner Topics Dashboard URL"
}

resource "lightstep_dashboard" "azure_eventgrid_partnertopics_overview" {
  project_name          = var.lightstep_project
  dashboard_name        = "Event Grid Partner Topics Metrics"
  dashboard_description = "[Beta] Monitor Event Grid Partner Topics with this metrics overview dashboard."

  chart {
    name = "Delivery Failed Events"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_deliveryattemptfailcount_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_eventsubscriptionname == $metadata_eventsubscriptionname)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Delivered Events"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_deliverysuccesscount_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_eventsubscriptionname == $metadata_eventsubscriptionname)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Dead Lettered Events"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_deadletteredcount_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_deadletterreason == $metadata_deadletterreason) && (metadata_eventsubscriptionname == $metadata_eventsubscriptionname)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Dropped Events"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_droppedeventcount_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_dropreason == $metadata_dropreason) && (metadata_eventsubscriptionname == $metadata_eventsubscriptionname)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Unmatched Events"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_unmatchedeventcount_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Matched Events"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_matchedeventcount_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_eventsubscriptionname == $metadata_eventsubscriptionname)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Published Events"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_publishsuccesscount_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Destination Processing Duration"
    rank = "7"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_destinationprocessingdurationinms_average | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_eventsubscriptionname == $metadata_eventsubscriptionname)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Advanced Filter Evaluations"
    rank = "8"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_advancedfilterevaluationcount_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_eventsubscriptionname == $metadata_eventsubscriptionname)) | delta | group_by [], sum
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
    name                     = "metadata_deadletterreason"
    default_values           = []
    suggestion_attribute_key = "metadata_deadletterreason"
  }

  template_variable {
    name                     = "metadata_dropreason"
    default_values           = []
    suggestion_attribute_key = "metadata_dropreason"
  }

  template_variable {
    name                     = "metadata_eventsubscriptionname"
    default_values           = []
    suggestion_attribute_key = "metadata_eventsubscriptionname"
  }
}
