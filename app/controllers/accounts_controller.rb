# frozen_string_literal: true

# Main controller for account model
class AccountsController < ApplicationController
  before_action :validate_account_params, only: [:create]
  before_action :require_login, only: [:show]

  def new; end

  def show; end

  def create
    @account = Account.new(registration_params)
    if Account.where(email: @account.email)
      flash[:warning] = 'An account with that email already exists'
    end
    if @account.save
      if @account[:account_type] == 'Student'
        StudentChecklist.create!(account_id: @account.id)
      end
      flash[:notice] = 'Account registration successful'
      redirect_to root_path and return
    else
      flash[:alert] = 'Account registration failed, please try again.'
    end
    render :new # Account validation failed
  end

  private

  def registration_params
    params.require(:account).permit(:first_name, :last_name, :email, :password, :password_confirmation, :account_type)
  end

  def validate_account_params
    valid = true
    account_params = registration_params
    (flash[:warning] = 'Fields cannot be empty') and (valid = false) if account_params.any? { |_k, v| v.blank? }
    (flash[:warning] = 'Passwords do not match') and (valid = false) if account_params[:password] != account_params[:password_confirmation]
    (flash[:warning] = 'Please enter a valid email address') and (valid = false) if account_params[:email] !~
                                                                                    /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    (flash[:warning] = 'Password must be at least 8 characters') and (valid = false) if account_params[:password].length < 8
    render :new unless valid
  end
end
