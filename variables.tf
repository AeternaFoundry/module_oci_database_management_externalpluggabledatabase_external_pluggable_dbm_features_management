variable "database_management_externalpluggabledatabase_external_pluggable_dbm_features_managements" {
  description = <<EOT
Map of database_management_externalpluggabledatabase_external_pluggable_dbm_features_managements, attributes below
Required:
    - enable_external_pluggable_dbm_feature
    - external_pluggable_database_id
Optional:
    - feature
    - feature_details (block):
        - connector_details (optional, block):
            - connector_type (optional)
            - database_connector_id (optional)
            - management_agent_id (optional)
            - private_end_point_id (optional)
        - feature (required)
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
EOT

  type = map(object({
    enable_external_pluggable_dbm_feature = bool
    external_pluggable_database_id        = string
    feature                               = optional(string)
    feature_details = optional(object({
      connector_details = optional(object({
        connector_type        = optional(string)
        database_connector_id = optional(string)
        management_agent_id   = optional(string)
        private_end_point_id  = optional(string)
      }))
      feature = string
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.database_management_externalpluggabledatabase_external_pluggable_dbm_features_managements : (
        v.feature == null || (contains([for v in ["DB_LIFECYCLE_MANAGEMENT", "DIAGNOSTICS_AND_MANAGEMENT", "SQLWATCH"] : lower(v)], lower(v.feature)))
      )
    ])
    error_message = "must be one of: \"DB_LIFECYCLE_MANAGEMENT\", \"DIAGNOSTICS_AND_MANAGEMENT\", \"SQLWATCH\""
  }
  validation {
    condition = alltrue([
      for k, v in var.database_management_externalpluggabledatabase_external_pluggable_dbm_features_managements : (
        v.feature_details == null || (v.feature_details.connector_details == null || (v.feature_details.connector_details.connector_type == null || (contains([for v in ["DIRECT", "EXTERNAL", "MACS", "PE"] : lower(v)], lower(v.feature_details.connector_details.connector_type)))))
      )
    ])
    error_message = "must be one of: \"DIRECT\", \"EXTERNAL\", \"MACS\", \"PE\""
  }
}

