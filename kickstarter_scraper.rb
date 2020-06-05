require 'nokogiri'
require 'pry'

def create_project_hash
  projects = {}
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  projects_list = kickstarter.css("li.project.grid_4")
  projects_list.collect do |project|
    projects[project.css(".bbcard_name a").text] = {
      :image_link => project.css("img.projectphoto-little").attr("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta span.location-name").text,
      :percent_funded => project.css("ul.project-stats strong").text.to_i
    }
  end
  projects

end
