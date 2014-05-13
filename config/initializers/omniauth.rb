Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["989150701472.apps.googleusercontent.com"], ENV["boSDLkA-g22M1J6cEkJls4Pq"],
  {
      :name => "google",
      :scope => "email, profile",
      :prompt => "select_account",
      :image_aspect_ratio => "square",
      :image_size => 50
    }
end