class SettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_setting
  
  def edit
  end
        
  def update
    if params[:commit] == 'Set budget'
      if @setting.update(params.require(:setting).permit(:budget))
        flash[:success] = "Budget was successfully updated"
        redirect_to categories_path
      else
        flash.now[:danger] = "Budget has not been updated"
        render :edit
      end
    elsif params[:commit] == 'Set currency'
      if @setting.update(params.require(:setting).permit(:currency))
        flash[:success] = "Currency was successfully updated"
        redirect_to categories_path
      else
        flash.now[:danger] = "Currency has not been updated"
        render :edit
      end
    elsif params[:commit] == 'Set both'
      if @setting.update(setting_params)
        flash[:success] = "Settings were successfully updated"
        redirect_to categories_path
      else
        flash.now[:danger] = "Settings were not been updated"
        render :edit
      end
    end
  end

  private
    def set_setting
      @setting = Setting.find(params[:id])
    end

    def setting_params
      params.require(:setting).permit(:budget, :currency)
    end
end
