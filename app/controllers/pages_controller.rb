class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def dashboard
    planning = current_user.plannings
    @updated_planning = []
    if current_user.plannings.length.positive?
      @arranged_plannings = planning.sort_by(&:start_time)
      @updated_planning = @arranged_plannings.select do |meal|
        meal.start_time >= Time.now
      end
      @updated_planning
    end
    raise
  end
end
