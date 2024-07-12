# This file should ensure the existence of names required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "csv"
Vote.destroy_all
Campaign.destroy_all
Candidate.destroy_all


filepath = "app/assets/data/votes.txt"
def vote_log_parse(filepath)
  log_line_regex = /^VOTE \d+ Campaign:[\w_]+ Validity:(during|pre|post) Choice:[\w]* /

  File.foreach(filepath) do |row|
    row = row.encode('UTF-8', invalid: :replace, undef: :replace, replace: '')

    unless row.match(log_line_regex)
      puts "Invalid format: #{row}"
      next
    end
    section = row.split(" ")

    vote = section[0]
    timestamp = section[1]
    campaign = section[2].split(":")[1]
    validity = section[3].split(":")[1].downcase
    choice = section[4].split(":")[1].downcase.capitalize

    if choice.present?
      candidate = Candidate.find_or_create_by(name: choice)
    else
      candidate = Candidate.find_or_create_by(name: 'Unknown')
    end

    campaign_name = Campaign.find_or_create_by(name: campaign)

    Vote.create(
      campaign: campaign_name,
      candidate: candidate,
      validity: validity
    )
  end
end

puts "Seeding data from #{filepath}"
vote_log_parse(filepath)
