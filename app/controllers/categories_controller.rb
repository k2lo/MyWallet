class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :set_settings
  
  
  def index
    @categories = Category.all
    @expenses = Expense.all
  end

  def show
    @category_expenses = @category.expenses
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)
    @category.user = current_user
    
    if @category.save
      flash[:success] = "Category was successfully created"
      redirect_to categories_path
    else
      render :new
    end
    
  end

  def update
    if @category.save
      flash[:success] = "Category was successfully updated"
      redirect_to category_path(@category)
    else
      render :edit
    end
  end


  def destroy
    @category.destroy
    flash[:danger] = "Category was succesfully deleted"
    redirect_to categories_path
  end

  
  def create_basic_categories
    @basic_categories = ["Bills", "Clothes", "Food", "House"]
    
    @basic_categories.each do |basic_categories|
      @category = Category.create(name: basic_categories, user: current_user)
    end
    
    if @category.save
      flash[:success] = "Basic categories created"
      redirect_to categories_path
    else
      redirect_to categories_path
    end
    
  end

  
  private
  
    def set_category
      @category = Category.find(params[:id])
    end
    
    def set_settings
      @setting = Setting.find_by(user_id: current_user.id)
    end

    def category_params
      params.require(:category).permit(:name)
    end

end
