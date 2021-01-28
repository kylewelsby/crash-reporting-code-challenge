class NotifierController < ApplicationController
  def create
    render nothing: true, status: :accepted
  end
end
