resource "oci_database_management_externalpluggabledatabase_external_pluggable_dbm_features_management" "database_management_externalpluggabledatabase_external_pluggable_dbm_features_managements" {
  for_each = var.database_management_externalpluggabledatabase_external_pluggable_dbm_features_managements

  enable_external_pluggable_dbm_feature = each.value.enable_external_pluggable_dbm_feature
  external_pluggable_database_id        = each.value.external_pluggable_database_id
  feature                               = each.value.feature

  dynamic "feature_details" {
    for_each = each.value.feature_details != null ? [each.value.feature_details] : []
    content {
      dynamic "connector_details" {
        for_each = feature_details.value.connector_details != null ? [feature_details.value.connector_details] : []
        content {
          connector_type        = connector_details.value.connector_type
          database_connector_id = connector_details.value.database_connector_id
          management_agent_id   = connector_details.value.management_agent_id
          private_end_point_id  = connector_details.value.private_end_point_id
        }
      }
      feature = feature_details.value.feature
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

