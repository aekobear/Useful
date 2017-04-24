require "open-uri"
require "nokogiri"
require "gmail"


loop do
  sleep(900) # 15 minutes

  source = open(open("http://cuyahogadogs.com/en-US/Adopt-Me.aspx").read.match(/<iframe src="(.*)"/).captures[0]).read

  html = Nokogiri::HTML source

  pugs = []
  html.css("td.list-item").each do |item|
    breed = item.css("div.list-animal-breed").text
    next unless breed.downcase.include? "pug"
    pugs << [breed, item.css("div.list-animal-name").text]
  end

  puts "found #{pugs.count} pugs."

  next if pugs.empty?

  email_body = ""

  pugs.each do |pug|
    email_body << "There is a #{pug[0]} named #{pug[1]} at cuyahogadogs.com!\n"
  end

  Gmail.connect(*ENV["credentials"].split(";")) do |gmail|
    gmail.deliver do
      to "kokumeiko@gmail.com"
      subject "PUGFINDER ALERT"
      text_part do
        body email_body
      end
    end
  end

end
