require 'nokogiri'

# require libraries/modules here

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
 
  kickstarter = Nokogiri::HTML(html)

  projects = {}

  kickstarter.css("li.project.grid_4").each do |elmnt| 
    title = elmnt.css("h2.bbcard_name strong a").text
    
    projects[title.to_sym] = {
      :image_link => elmnt.css("div.project-thumbnail a img").attribute("src").value,
      :description => elmnt.css("p.bbcard_blurb").text,
      :location => elmnt.css("ul.project-meta span.location-name").text,
      :percent_funded => elmnt.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end
  projects
  # write your code here
end