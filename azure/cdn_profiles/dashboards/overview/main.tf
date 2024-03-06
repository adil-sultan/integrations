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
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.azure_cdn_profiles_overview.id}"
  description = "OpenTelemetry Collector CDN Profiles Dashboard URL"
}

resource "lightstep_dashboard" "azure_cdn_profiles_overview" {
  project_name          = var.lightstep_project
  dashboard_name        = "CDN Profiles Metrics"
  dashboard_description = "[Beta] Monitor CDN Profiles with this metrics overview dashboard."

  chart {
    name = "Requests"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_requestcount_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_clientcountry == $metadata_clientcountry) && (metadata_endpoint == $metadata_endpoint)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Origin Latency"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_originlatency_average | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_endpoint == $metadata_endpoint)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Total Latency"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_totallatency_average | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_clientcountry == $metadata_clientcountry) && (metadata_endpoint == $metadata_endpoint)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Origin Requests"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_originrequestcount_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_endpoint == $metadata_endpoint)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Byte Hit Ratio"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_bytehitratio_average | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_endpoint == $metadata_endpoint)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Origin Health %"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_originhealthpercentage_average | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Request Size"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_requestsize_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_clientcountry == $metadata_clientcountry) && (metadata_endpoint == $metadata_endpoint)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Response Size"
    rank = "7"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_responsesize_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_clientcountry == $metadata_clientcountry) && (metadata_endpoint == $metadata_endpoint)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Web Application Firewall Requests"
    rank = "8"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_webapplicationfirewallrequestcount_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_action == $metadata_action)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "4xx %"
    rank = "9"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_percentage4xx_average | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_endpoint == $metadata_endpoint) && (metadata_clientcountry == $metadata_clientcountry)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "5xx %"
    rank = "10"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_percentage5xx_average | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_endpoint == $metadata_endpoint) && (metadata_clientcountry == $metadata_clientcountry)) | delta | group_by [], sum
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
    name                     = "metadata_clientcountry"
    default_values           = []
    suggestion_attribute_key = "metadata_clientcountry"
  }

  template_variable {
    name                     = "metadata_endpoint"
    default_values           = []
    suggestion_attribute_key = "metadata_endpoint"
  }
}
