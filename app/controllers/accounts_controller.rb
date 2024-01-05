class AccountsController < ApplicationController

  def new
    @account = Account.new
  end

  private

  def account_params
    params.require(:account).permit(:user_id, :birthday, :height, :weight, :active_level, :phase)
  end
end
