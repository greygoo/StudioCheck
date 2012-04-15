class TestRun < ActiveRecord::Base
  belongs_to :server
  belongs_to :test_description

  def run
    self.update_attributes!(:log => nil, :result => nil)
    Resque.enqueue(TestRunJob, self.id)
  end

  def log_file
    "#{filename}.log"
  end

  def feature_file
    "#{filename}.feature"
  end

  def run_log
    if File.exists?(log_file)
      File.read(log_file)
    else
      self.log
    end
  end

  private

  def filename
    File.join(Rails.root, "features", "#{self.test_description.id}-#{self.id}")
  end
end
