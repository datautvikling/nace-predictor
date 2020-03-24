SELECT timestamp, jsonPayload.*
FROM `api_log_name.table_name` -- Use the configured log sink and table name here
WHERE jsonPayload.response.meta.id is not null;
