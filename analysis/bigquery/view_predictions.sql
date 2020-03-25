SELECT 
  timestamp, 
  jsonpayload.request, 
  jsonPayload.response.predictions[OFFSET(0)] as best_prediction, 
  jsonpayload.response.meta
FROM `api_log_name.table_name` -- Use the configured log sink and table name here
WHERE jsonPayload.response.meta.id is not null;