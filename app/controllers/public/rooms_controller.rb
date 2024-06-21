class Public::RoomsController < ApplicationController
  before_action :authenticate_user!
  def index
    @rooms = current_user.rooms
  end
end
