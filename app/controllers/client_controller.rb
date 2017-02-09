class ClientController < ApplicationController
  skip_before_action :authenticate_request

  def index
    render file: 'public/index.html'
  end
end
