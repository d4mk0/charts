class HomeController < ApplicationController
  def index
    js date: {min: DataItem.minimum(:date), max: DataItem.maximum(:date)}
  end
end
