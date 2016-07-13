json.array!(@transactions) do |transaction|
  json.extract! transaction, :id, :item_id, :type, :amount, :target_id, :notes
  json.url transaction_url(transaction, format: :json)
end
