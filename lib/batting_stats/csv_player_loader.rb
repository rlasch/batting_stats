require 'csv'

module BattingStats
  class CsvPlayerLoader
    def self.process(file, &block)
      CSV.foreach(file, :headers => true) do |row|
        block.call(row) if block_given?
      end
    end
  end
end
