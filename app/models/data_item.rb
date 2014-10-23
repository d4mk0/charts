#encoding: utf-8
class DataItem < ActiveRecord::Base

  def self.import(file)
    file = "#{Rails.root}/data.csv"
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      data_item = DataItem.new
      attrs = row.to_hash.slice('date', 'store', 'rating', 'criterion', 'status')
      attrs['criterion'] = case attrs['criterion']
      when 'Да'
        true
      when 'Нет'
        false
      else
        nil
      end
      attrs['date'] = Date.strptime(row['date'], "%m/%d/%Y")
      data_item.attributes = attrs
      data_item.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file)
    when ".csv" then Roo::CSV.new(file, csv_options: {col_sep: ";"})
    when ".xls" then Roo::Excel.new(file)
    when ".xlsx" then Roo::Excelx.new(file)
    else raise "Unknown file type: #{file}"
    end
  end

  def self.line_chart_by_stores
    uniq.pluck(:store).sort.map do |s|
      hash = where(store: s).group_by_day(:date).count
      new_hash = {}
      hash.each do |time,_|
        time = time.strftime("%Y-%m-%d")
        a = where(store: s, date: time).pluck(:rating).compact
        new_hash[time] = a.inject{ |sum, el| sum + el }.to_f / a.size
      end
      {name: s, data: new_hash}
    end
  end

  def self.part_of_answers
    h = DataItem.group(:criterion).count
    h['Yes'] = h[true]
    h.delete(true)
    h['No'] = h[false]
    h.delete(false)
    h['Unknown'] = h[nil]
    h.delete(nil)
    h
  end


end
