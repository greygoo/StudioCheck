class TestRunJob < Job
  @queue = :tests

  def self.perform(id)
    test_run = TestRun.find(id)
    log = test_run.log_file
    feature = test_run.feature_file
    logger.info "Processing test run: #{id}"

    File.open(feature, "w") { |f| f.write(test_run.test_description.description) }

    env = {
      'USER' => test_run.server.username,
      'PASS' => test_run.server.password,
      'URL'  => test_run.server.api_url,
      'RAILS_ENV' => 'test',
    }

    logger.info "Running cucumber"
    Open3.pipeline_r([env, "cucumber", "-S", feature, :err => :out], ["tee", "-a", log], :chdir => Rails.root) do |output, threads|
      test_run.log = output.readlines.join
      test_run.result = (threads.first.value == 0)
    end
  rescue Exception => e
    logger.info(e.backtrace)
    raise
  ensure
    logger.info "Done"
    test_run.save!
    FileUtils.rm(feature) if File.exists?(feature)
    FileUtils.rm(log) if File.exists?(log)
  end

end
