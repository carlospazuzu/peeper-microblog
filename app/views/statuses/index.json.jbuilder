json.statuses @statuses.each do |status|
  json.id status.id
  json.body status.body.length > 150 ? status.body[0...150] + '...' : status.body
  json.full_body status.body unless status.body.length <= 150
  json.display_name status.user.display_name
  json.reply_peep true if status.replied_to_status_id
end
