class TestDescription < ActiveRecord::Base
  has_many :test_runs

  validates_presence_of :description

  def summary
    @summary ||= description.split("\n").first
  end
end
