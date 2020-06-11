# require libraries/modules here
require "nokogiri"

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  docs = Nokogiri::HTML(html)
  allprojectshash = {}
  docs.css("li.project.grid_4").each do |project|
    prjtitle = project.css("h2.bbcard_name strong a").text
    allprojectshash[prjtitle] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end
   allprojectshash
end


