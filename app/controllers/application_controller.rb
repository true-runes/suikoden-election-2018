class ApplicationController < ActionController::Base
  # TODO: あとで消すやつ
  def goodbye
    # text = 'Goodbye!'
    text = "params: #{params}"
    render plain: text
  end
end
