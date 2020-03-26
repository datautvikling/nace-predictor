select usage_req.*, prediction_req.* except(timestamp)
from `api_log_name.prediction_req_view` as prediction_req   -- Use the configured log sink and view name here
inner join `api_log.usage_req_view` as usage_req            -- and here
on prediction_req.meta.id = usage_req.usage.id
where meta.model is not null;
