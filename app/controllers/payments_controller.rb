class PaymentsController < ApplicationController
  def new
    @payment = Payment.new(params[:id])
  end

  def create
    @payment = Payment.new(params[:payment])
    if @payment.save
      redirect_to payments_path
    else
      render action: "new", notice: "Your information is incomplete or incorrect. Please correct the fields below and try again!"
    end
  end 
end