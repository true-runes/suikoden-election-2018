# TODO: あとで消すやつ
class AjaxController < ApplicationController
  def index
    @message = "Hello, Ajax World!"
    @parameters = params
  end

  def show
    @parameters = params
    render json: { ufufu: "kanashimishikanai" }
  end
end
