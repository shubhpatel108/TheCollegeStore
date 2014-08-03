require 'rubygems'
require 'sitemap_generator'

SitemapGenerator::Sitemap.default_host = 'http://thecollegestore.in'
SitemapGenerator::Sitemap.create do
  add '/home', :changefreq => 'daily', :priority => 0.9
  add '/contact_us', :changefreq => 'weekly'
  add '/our_team', :changefreq => 'weekly'
  add '/privacy_policy', :changefreq => 'weekly'
  add '/disclaimer', :changefreq => 'weekly'
  add '/terms', :changefreq => 'weekly'
  add '/about_us', :changefreq => 'weekly'
  add '/shipping-details', :changefreq => 'weekly'
  add '/coupons', :changefreq => 'weekly'
  add '/login', :changefreq => 'weekly'
  add '/logout', :changefreq => 'weekly'
  add '/register', :changefreq => 'weekly'
  BookGroup.find_each do |bg|
    add "/book_groups/details/#{bg.id}", :lastmod => bg.updated_at, :changefreq => 'weekly'
  end
end
SitemapGenerator::Sitemap.ping_search_engines