class HomeController < ApplicationController
  def index
    @selected_stores = cookies[:stores].present? ? cookies[:stores].split(',') : DataItem.uniq.pluck(:store)
    js date: {min: DataItem.minimum(:date), max: DataItem.maximum(:date)}, default: {min: cookies[:date_min] || DataItem.minimum(:date), max: cookies[:date_max] || DataItem.maximum(:date)}
  end
end
