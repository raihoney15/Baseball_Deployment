class VerifyController < ApplicationController
    skip_before_action :redirect_if_unverified
    before_action :authenticate_user!
  
    def new
      @user = current_user
      @resource_name = :user
    end
  
    def create
      current_user.send_pin!
      flash[:alert] = "Verification code has been sent to email address."
      redirect_to verify_url
    end
  
    def edit
      @user = current_user
    end
  
    def update
      code = "#{params[:user][:pin_0]}#{params[:user][:pin_1]}#{params[:user][:pin_2]}#{params[:user][:pin_3]}"
      @user = current_user
      if Time.now > current_user.pin_sent_at.advance(minutes: 1)
        flash.now[:alert] = "Your pin has expired. Please request another."
        render :edit and return
      elsif code.try(:to_i) == current_user.pin
        current_user.update_attribute(:verified, true)
        flash[:alert] = "Your email address has been verified!"
        redirect_to root_url
      else
        flash.now[:alert] = "The code you entered is invalid."
        render :edit
      end
    end
  end
  