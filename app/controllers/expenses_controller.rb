class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :set_category
  before_action :set_settings
  
  def new
    @expense = @category.expenses.new
  end

  def edit
  end

  def create
    @expense = @category.expenses.new(expense_params)
    @expense.user = current_user
    
    if @expense.save
      flash[:success] = "Expense was successfully created"
      redirect_to categories_path
    else
      render :new
    end
    
  end

  def update
    if @expense.save
      flash[:success] = "Expense was successfully updated"
      redirect_to category_path(@category)
    else
      render :edit
    end
  end


  def destroy
    @expense.destroy
    flash[:danger] = "Expense was succesfully deleted"
    redirect_to category_path(@category)
  end

  private
    def set_expense
      @expense = Expense.find(params[:id])
    end
    
    def set_category
      @category = Category.find(params[:category_id])
    end
    
    def set_settings
      @setting = Setting.find_by(user_id: current_user.id)
    end

    def expense_params
      params.require(:expense).permit(:value, :description)
    end
end
