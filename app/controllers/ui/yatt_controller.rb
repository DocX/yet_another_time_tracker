class Ui::YattController < ApplicationController
  before_filter :authenticate_user!

  def main
    render 'main'
  end
end
