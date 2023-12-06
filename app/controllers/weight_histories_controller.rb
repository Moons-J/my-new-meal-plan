class WeightHistoriesController < ApplicationController
  def create
    @weight_history = WeightHistory.new(weight_history_params)
    @weight_history.user = current_user
    if @weight_history.save
      redirect_to dashboard_path
    else
      render 'pages/dashboard'
    end
  end

  private

  def weight_history_params
    params.require(:weight_history).permit(:weight)
  end
end
