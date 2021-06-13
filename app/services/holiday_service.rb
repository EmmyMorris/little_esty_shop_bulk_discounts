# class HolidayService
#   def self.holidays
#     response = Faraday.get "https://date.nager.at/api/v2/NextPublicHolidays/us"
#     body = response.body
#     JSON.parse(body, symbolize_names: true)
#   end
# end
