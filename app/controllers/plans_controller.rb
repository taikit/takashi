class PlansController < ApplicationController
  before_action :set_plan, only: [:show,:destroy]
  before_action :authenticate_user!, :except => [:index, :show]

  # GET /plans
  # GET /plans.json
  def index
    if params[:area_name]
      @area = Area.find_by_name(params[:area_name])
      @plans = @area.plans
      @categories = Category.all
    elsif params[:category_name]
      @category = Category.find_by_name(params[:category_name])
      @plans = @category.plans
    else
      @plans = Plan.all
    end
  end

  # GET /plans/1
  # GET /plans/1.json
  def show
  end

  # GET /plans/new
  def new
    @plan = Plan.new
  end

  # GET /plans/1/edit
  def edit
    @plan = current_user.plans.find(params[:id])
  end

  # POST /plans
  # POST /plans.json
  def create
    @plan = Plan.new(plan_params)
    @plan.user = current_user
    respond_to do |format|
      if @plan.save
        format.html { redirect_to @plan, notice: 'Plan was successfully created.' }
        format.json { render :show, status: :created, location: @plan }
      else
        format.html { render :new }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plans/1
  # PATCH/PUT /plans/1.json
  def update
    @plan = current_user.plans.find(params[:id])
    respond_to do |format|
      if @plan.update(plan_params)
        format.html { redirect_to @plan, notice: 'Plan was successfully updated.' }
        format.json { render :show, status: :ok, location: @plan }
      else
        format.html { render :edit }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plans/1
  # DELETE /plans/1.json
  def destroy
    @plan.destroy
    respond_to do |format|
      format.html { redirect_to plans_url, notice: 'Plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_plan
    @plan = Plan.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def plan_params
    params.require(:plan).permit(:title, :image, :area_id, :category_id, :body, :amount, :days_attributes => [:id, :met_at, :plan_id, :_destroy])
  end
end
