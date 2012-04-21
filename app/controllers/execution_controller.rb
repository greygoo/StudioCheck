class ExecutionController < ApplicationController
  def index
    @workers = []
    @schedule = []
    @queues = []

    @error = nil

    begin
      @workers = Resque.workers
      @schedule = Resque.schedule
      @queues = Resque.queues
    rescue Errno::ECONNREFUSED => e
      @error = e.message
    end

    respond_to do |format|
      if @error
        flash[:alert] = @error
        format.html { render action: :index }
        format.json { render json: @error, status: :unprocessable_entity }
      else
        format.html
        format.json { render json: { workers: @workers, queues: @queues } }
      end
    end
  end
end
