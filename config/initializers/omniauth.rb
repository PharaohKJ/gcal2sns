Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
           ENV['GOOGLE_CLIENT_ID'],
           ENV['GOOGLE_SECRET'],
           {
             image_size: 150,
             name: :google,
             access_type: 'offline',
             scope: %w(https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/calendar).join(' '),
             prompt: 'consent'
           }
end
