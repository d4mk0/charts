class ChartsController < ApplicationController

  def part_answers
    render json: DataItem.part_of_answers(cookies)
  end

  def dynamic
    render json: DataItem.line_chart_by_stores(cookies)
  end

  def part
    render json: DataItem.by_cookies(cookies).group(:status).count
  end
end
