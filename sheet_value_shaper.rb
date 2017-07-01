module SheetValueShaper
  def self.kpi_str(values)
    values.reject! { |val| val.empty? }
    row_1 = values.shift
    row_2 = values.shift
    row_3 = values.shift
    row_4 = values.shift
    
    post_str = "#{row_1[0]}\n"
    post_str += "#{row_2[0]}:#{row_2[1]}人\n"
    post_str += "#{row_3[0]}:#{row_3[1]}人\n"
    post_str += "#{row_4[0]}:#{row_4[1]}人\n"
    post_str += "\n担当者実績\n"
    values.each do |row|
      count = row[1].empty? ? 0 : row[1]
      post_str += "#{row[0]}:#{count}人 残り:#{row[3]}人\n"
    end
    post_str
  end
end
