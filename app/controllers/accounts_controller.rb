require_relative '../models/account'

class AccountsController < ApplicationController
  def new
    @account = Account.new
  end

  def create
    @account = Account.new
    @account.user_id = user_id
    @account.save
  end

  def edit
    @account = Account.find(params[:id])
  end

  def update
    @account = Account.find(params[:id])
    if @account.update(account_params)
      redirect_to :root, notice: "Account information updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def account_params
    params.require(:account).permit(:user_id, :birthday, :height, :weight, :active_level, :phase, :sex)
  end
end
