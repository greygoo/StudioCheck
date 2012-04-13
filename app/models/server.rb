class Server < ActiveRecord::Base
  has_many :test_runs

  validates_presence_of :api_url
  validates_presence_of :username
  validates_presence_of :password

  validates_format_of :api_url, :with => /\/api\/v2\/user$/, :message => "The API URL path should point to /api/v2/user."
end
