require 'rubygems'
require 'sitemap_generator'

SitemapGenerator::Sitemap.default_host = 'http://thecollegestore.in'
SitemapGenerator::Sitemap.create do
  add '/home', :changefreq => 'daily', :priority => 0.9
  add '/contact_us', :changefreq => 'weekly'
  add '/book_groups/details/'
  BookGroup.find_each do |bg|
    add "/book_groups/details/#{bg.id}", :lastmod => bg.updated_at, :changefreq => 'weekly'
  end
end
SitemapGenerator::Sitemap.ping_search_engines