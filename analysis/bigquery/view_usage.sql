SELECT
  timestamp,
  jsonPayload.usage
FROM `api_log_name.table_name` -- Use the configured log sink and table name here
WHERE jsonPayload.usage.id is not null;
