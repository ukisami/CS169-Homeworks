# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_hello_session',
  :secret      => 'c2a49873befb122821f0c2ef8b8e3b03d4b3522b31748fed2b3050a5e9ba984e1591886b033b198cf24fa11b7e8a8875089b8fdbc289a799fa138b1cda4196a7'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
