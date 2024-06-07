class Public::SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @current_user = current_user
    @model = params[:model]
    @content = params[:content]
    
    if @model == "user"
      @records = User.search_for(@content)
    else
      @records = Post.search_for(@content)
    end
    
  end
  
end
