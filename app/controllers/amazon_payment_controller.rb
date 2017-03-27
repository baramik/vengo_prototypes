class AmazonPaymentController < ApplicationController
  def track
    AmazonPayment.create(client_id: params[:clientId])
    render nothing: true, status: 200
  end
end