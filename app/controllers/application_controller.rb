class ApplicationController < ActionController::Base
  def goodbye
    # text = 'Goodbye!'
    text = "params: #{params}"
    render plain: text
  end
end
