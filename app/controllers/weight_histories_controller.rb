class WeightHistoriesController < ApplicationController
  def create
    @weight_history = WeightHistory.new(weight_history_params)
    @weight_history.user = current_user
    if @weight_history.save
      session[:weight_history_errors] = nil
      redirect_to root_path
    else
      session[:weight_history_errors] = @weight_history.errors.full_messages
      redirect_to root_path, status: :unprocessable_entity
    end
  end

  private

  def weight_history_params
    params.require(:weight_history).permit(:weight)
  end
end
