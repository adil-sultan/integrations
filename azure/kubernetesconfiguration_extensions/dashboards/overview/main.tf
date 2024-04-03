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
  description = "Cloud Observability Project Name"
  type        = string
}

output "dashboard_url" {
  value       = "https://app.lightstep.com/${var.lightstep_project}/dashboard/${lightstep_dashboard.azure_kubernetesconfiguration_extensions_overview.id}"
  description = "OpenTelemetry Collector Kubernetes Configuration Extensions Dashboard URL"
}

resource "lightstep_dashboard" "azure_kubernetesconfiguration_extensions_overview" {
  project_name          = var.lightstep_project
  dashboard_name        = "Kubernetes Configuration Extensions Metrics"
  dashboard_description = "[Beta] Monitor Kubernetes Configuration Extensions with this metrics overview dashboard."

  chart {
    name = "Active PDU Sessions"
    rank = "0"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_activesessioncount_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_3gppgen == $metadata_3gppgen) && (metadata_pccpid == $metadata_pccpid) && (metadata_siteid == $metadata_siteid)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Authentication Failures"
    rank = "1"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_authfailure_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_3gppgen == $metadata_3gppgen) && (metadata_pccpid == $metadata_pccpid) && (metadata_siteid == $metadata_siteid)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Authentication Successes"
    rank = "2"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_authsuccess_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_3gppgen == $metadata_3gppgen) && (metadata_pccpid == $metadata_pccpid) && (metadata_siteid == $metadata_siteid)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Service Request Failures"
    rank = "3"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_servicerequestfailure_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_3gppgen == $metadata_3gppgen) && (metadata_pccpid == $metadata_pccpid) && (metadata_siteid == $metadata_siteid)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Service Request Successes"
    rank = "4"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_servicerequestsuccess_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_3gppgen == $metadata_3gppgen) && (metadata_pccpid == $metadata_pccpid) && (metadata_siteid == $metadata_siteid)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Registration Failures"
    rank = "5"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_registrationfailure_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_3gppgen == $metadata_3gppgen) && (metadata_pccpid == $metadata_pccpid) && (metadata_siteid == $metadata_siteid)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Registration Successes"
    rank = "6"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_registrationsuccess_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_3gppgen == $metadata_3gppgen) && (metadata_pccpid == $metadata_pccpid) && (metadata_siteid == $metadata_siteid)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Session Establishment Failures"
    rank = "7"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_sessionestablishmentfailure_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_3gppgen == $metadata_3gppgen) && (metadata_pccpid == $metadata_pccpid) && (metadata_siteid == $metadata_siteid)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Session Establishment Successes"
    rank = "8"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_sessionestablishmentsuccess_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_3gppgen == $metadata_3gppgen) && (metadata_pccpid == $metadata_pccpid) && (metadata_siteid == $metadata_siteid)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Xn Handover Failures"
    rank = "9"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_xnhandoverfailure_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_3gppgen == $metadata_3gppgen) && (metadata_pccpid == $metadata_pccpid) && (metadata_siteid == $metadata_siteid)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Xn Handover Successes"
    rank = "10"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_xnhandoversuccess_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_3gppgen == $metadata_3gppgen) && (metadata_pccpid == $metadata_pccpid) && (metadata_siteid == $metadata_siteid)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "RAN Setup Failures"
    rank = "11"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_ransetupfailure_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_3gppgen == $metadata_3gppgen) && (metadata_pccpid == $metadata_pccpid) && (metadata_siteid == $metadata_siteid)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "RAN Setup Requests"
    rank = "12"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_ransetuprequest_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_3gppgen == $metadata_3gppgen) && (metadata_pccpid == $metadata_pccpid) && (metadata_siteid == $metadata_siteid)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Paging Failures"
    rank = "13"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_pagingfailure_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_3gppgen == $metadata_3gppgen) && (metadata_pccpid == $metadata_pccpid) && (metadata_siteid == $metadata_siteid)) | delta | group_by [], sum
EOT
    }
  }

  chart {
    name = "Paging Attempts"
    rank = "14"
    type = "timeseries"

    query {
      query_name   = "a"
      display      = "line"
      hidden       = false
      query_string = <<EOT
metric azure_pagingattempt_total | filter ((azuremonitor.subscription_id == $azuremonitor_subscription_id) && (azuremonitor.tenant_id == $azuremonitor_tenant_id) && (azuremonitor.resource_id == $azuremonitor_resource_id) && (location == $location) && (metadata_3gppgen == $metadata_3gppgen) && (metadata_pccpid == $metadata_pccpid) && (metadata_siteid == $metadata_siteid)) | delta | group_by [], sum
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
    name                     = "metadata_3gppgen"
    default_values           = []
    suggestion_attribute_key = "metadata_3gppgen"
  }

  template_variable {
    name                     = "metadata_pccpid"
    default_values           = []
    suggestion_attribute_key = "metadata_pccpid"
  }

  template_variable {
    name                     = "metadata_siteid"
    default_values           = []
    suggestion_attribute_key = "metadata_siteid"
  }
}
