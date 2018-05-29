class AjaxController < ApplicationController
  def index
    @message = "Hello, Ajax World!"
    gon.message = @message
    @parameters = params
  end

  def show
    @parameters = params
    render json: { ufufu: "kanashimi" }
  end
end
