class ExecutionController < ApplicationController
  def index
    @workers = []
    @jobs = []

    begin
      # Resque.size + 1 is needed otherwise redis would return the job hash,
      # insetad of list of hashes
      @jobs = Resque.peek(:tests, 0, Resque.size(:tests) + 1).to_a
      @workers = Resque.workers
    rescue Errno::ECONNREFUSED => e
      # stay silent
    end

    respond_to do |format|
      format.html
      format.json { render json: { workers: @workers, jobs: @jobs } }
    end
  end

  def redis_status
    @redis_up = true

    begin
      Resque.workers
    rescue Errno::ECONNREFUSED => e
      @redis_up = false
    end

    respond_to do |format|
        format.html { render :action => :redis_status, :layout => false }
    end
  end

  def workers_status
    @workers_working = 0
    @workers_all = 0

    begin
      workers = Resque.workers

      @workers_all = workers.count
      @workers_working = workers.select { |w| w.working? }.count
    rescue Errno::ECONNREFUSED => e
      @workers_working = "N/A"
      @workers_all = "N/A"
    end

    respond_to do |format|
      format.html { render :action => :workers_status, :layout => false }
    end
  end
end
