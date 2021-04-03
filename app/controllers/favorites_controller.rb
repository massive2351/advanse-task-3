class FavoritesController < ApplicationController
  def create
    @bookfind = Book.find(params[:book_id])
    favorite = @bookfind.favorites.new(user_id: current_user.id)
    favorite.save
    redirect_to book_path(@bookfind)
    
  end

  def destroy
    @bookfind = Book.find(params[:book_id])
    favorite = @bookfind.favorites.find_by(user_id: current_user.id)
    favorite.destroy
    redirect_to book_path(@bookfind)
  end

end
