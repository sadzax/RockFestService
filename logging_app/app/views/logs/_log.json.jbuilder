json.extract! log, :id, :id_ticket, :date, :name, :operation_type, :result, :created_at, :updated_at
json.url log_url(log, format: :json)
