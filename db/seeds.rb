# frozen_string_literal: true

provinces = [
  { name: "Alberta", GST: 5, PST: 0, HST: 0 },
  { name: "British Columbia", GST: 5, PST: 7, HST: 0 },
  { name: "Manitoba", GST: 5, PST: 7, HST: 0 },
  { name: "New Brunswick", GST: 5, PST: 10, HST: 0 },
  { name: "Newfoundland and Labrador", GST: 5, PST: 10, HST: 0 },
  { name: "Northwest Territories", GST: 5, PST: 0, HST: 0 },
  { name: "Nova Scotia", GST: 5, PST: 10, HST: 0 },
  { name: "Nunavut", GST: 5, PST: 0, HST: 0 },
  { name: "Ontario", GST: 5, PST: 8, HST: 0 },
  { name: "Prince Edward Island", GST: 5, PST: 10, HST: 0 },
  { name: "Quebec", GST: 5, PST: 9.975, HST: 0 },
  { name: "Saskatchewan", GST: 5, PST: 6, HST: 0 },
  { name: "Yukon", GST: 5, PST: 0, HST: 0 }
]

provinces.each do |province|
  Province.create!(province)
end

Rails.logger.debug "Provinces seeded successfully!"
