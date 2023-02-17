json.status do
  json.body @status.body
  json.display_name @status.user.display_name
  json.reply_peep true if @status.replied_to_status_id.present?
  json.media @status.media.length # (@status.media.filter { |m| m if m.url.present? }).length
end
