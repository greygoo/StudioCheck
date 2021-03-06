class TestRunsController < ApplicationController
  # GET /test_runs
  # GET /test_runs.json
  def index
    @test_runs = TestRun.order("created_at DESC").all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @test_runs }
    end
  end

  # GET /test_runs/1
  # GET /test_runs/1.json
  def show
    @test_run = TestRun.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @test_run }
    end
  end

  # GET /test_runs/new
  # GET /test_runs/new.json
  def new
    @test_run = TestRun.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @test_run }
    end
  end

  # GET /test_runs/1/edit
  def edit
    @test_run = TestRun.find(params[:id])
  end

  # POST /test_runs
  # POST /test_runs.json
  def create
    @test_run = TestRun.new(params[:test_run])

    respond_to do |format|
      if @test_run.save
        format.html { redirect_to @test_run, notice: 'Test run was successfully created.' }
        format.json { render json: @test_run, status: :created, location: @test_run }
      else
        format.html { render action: "new" }
        format.json { render json: @test_run.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /test_runs/1
  # PUT /test_runs/1.json
  def update
    @test_run = TestRun.find(params[:id])

    respond_to do |format|
      if @test_run.update_attributes(params[:test_run])
        format.html { redirect_to @test_run, notice: 'Test run was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @test_run.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /test_runs/1
  # DELETE /test_runs/1.json
  def destroy
    @test_run = TestRun.find(params[:id])
    @test_run.destroy

    respond_to do |format|
      format.html { redirect_to test_runs_url }
      format.json { head :no_content }
    end
  end

  # GET /test_runs/1/run
  # GET /test_runs/1/run.json
  def run
    @test_run = TestRun.find(params[:id])
    @test_run.run

    respond_to do |format|
      format.html { redirect_to @test_run }
      format.json { head :no_content }
    end
  end

  # Get /test_runs/1/run_log.json
  def run_log
    @test_run = TestRun.find(params[:id])
    respond_to do |format|
      format.html { render layout: false }
      format.json { render json: @test_run.run_log }
    end
  end
end
