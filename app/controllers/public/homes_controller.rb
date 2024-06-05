class Public::HomesController < ApplicationController
  def top
    @current_user = current_user
  end

  def about
    @current_user = current_user
  end
end
