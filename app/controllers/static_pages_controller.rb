class StaticPagesController < ApplicationController
  def index
    @areas = Area.all
    @categories = Category.all
  end
end
