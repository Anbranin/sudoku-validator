require 'pry'

class SudokuValidator
  def valid?(str)
    rows = str.split("\n").reject { |r| r == '------+------+------' }

    return false unless valid_horizontal_rows?(rows) && valid_vertical_rows?(str)

    valid_squares?(rows)
  end

  private

  def valid_horizontal_rows?(rows)
    rows.each do |row|
      row_items = []
      row.split(' ').each do |col|
        row_items.push(col) if col != '|'
      end
      return false if row_items.uniq.count < 9
    end
  end

  def valid_vertical_rows?(str)
    column_index = 0
    9.times do
      row_items = []
      str.split("\n").each do |row|
        row_items << row[column_index]
      end
      return false if row_items.uniq.count < 9

      column_index += 2
      column_index += 2 if str.split("\n").first[column_index] == '|'
    end
  end

  def valid_squares?(rows)
    row_indices = [0..2, 3..5, 6..8]
    column_indices = [0..5, 7..12, 15..20]
    valid_squares = row_indices.map do |row_index_range|
      column_indices.map do |column_index_range|
        square = rows[row_index_range].map { |row| row[column_index_range] }
        unique_numbers = square.join.gsub(/\s+/, '').split('').uniq
        unique_numbers.count == 9
      end
    end
    valid_squares.flatten.all? true
  end
end
