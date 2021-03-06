module Docs
  class Cordova < UrlScraper
    self.name = 'Cordova'
    self.type = 'cordova'
    self.release = '6.0.0'
    self.base_url = "https://cordova.apache.org/docs/en/#{release}/"
    self.root_path = 'index.html'
    self.links = {
      home: 'https://cordova.apache.org/'
    }

    html_filters.push 'cordova/clean_html', 'cordova/entries', 'title'

    options[:container] = ->(filter) { filter.root_page? ? '#home' : '#page-toc-source' }
    options[:title] = false
    options[:root_title] = 'Apache Cordova'
    options[:skip] = %w(page_index.html)

    options[:attribution] = <<-HTML
      &copy; 2012&ndash;2016 The Apache Software Foundation<br>
      Licensed under the Apache License 2.0.
    HTML
  end
end
