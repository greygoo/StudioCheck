class ExecutionController < ApplicationController
  def index
    @workers = []
    @schedule = []
    @queues = []

    begin
      @workers = Resque.workers
      @schedule = Resque.schedule
      @queues = Resque.queues
    rescue Errno::ECONNREFUSED => e
      # stay silent
    end

    respond_to do |format|
      format.html
      format.json { render json: { workers: @workers, queues: @queues } }
    end
  end

  def redis_status
    @redis_up = true

    begin
      Resque.redis.status?
    rescue Errno::ECONNREFUSED => e
      @redis_up = false
    end

    respond_to do |format|
        format.html { render :action => :redis_status, :layout => false }
    end
  end
end
