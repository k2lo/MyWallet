class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :edit, :update, :destroy]
  before_action :set_category

  # GET /expenses
  # GET /expenses.json
  def index
    @expenses = Expense.all
    if @setting = Setting.order("created_at").last == nil  
      @setting = Setting.new(:budget => 0, :currency => ISO4217::Currency.from_code('USD').symbol)
    else
      @setting = Setting.order("created_at").last
    end
  end

  # GET /expenses/1
  # GET /expenses/1.json
  def show
    if @setting = Setting.order("created_at").last == nil  
      @setting = Setting.new(:budget => 0, :currency => ISO4217::Currency.from_code('USD').symbol)
    else
      @setting = Setting.order("created_at").last
    end
  end

  # GET /expenses/new
  def new
    @expense = @category.expenses.new
   
  end

  # GET /expenses/1/edit
  def edit
  end

  # POST /expenses
  # POST /expenses.json
  def create
    @expense = @category.expenses.new(expense_params)
    @expense.user = current_user
    

    respond_to do |format|
      if @expense.save
        format.html { redirect_to categories_path, notice: 'Expense was successfully created.' }
        format.json { render :show, status: :created, location: @expense }
      else
        format.html { render :new }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expenses/1
  # PATCH/PUT /expenses/1.json
  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to category_path(@category), notice: 'Expense was successfully updated.' }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.json
  def destroy
    @expense.destroy
    respond_to do |format|
      format.html { redirect_to category_path(@category), notice: 'Expense was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      @expense = Expense.find(params[:id])
    end
    
    def set_category
      @category = Category.find(params[:category_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def expense_params
      params.require(:expense).permit(:value, :description)
    end
end
