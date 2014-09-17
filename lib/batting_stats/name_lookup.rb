require 'csv'

module BattingStats
  class NameLookup
    attr_accessor :names

    def initialize(file)
      @names = {}
      CSV.foreach(file, :headers => true) do |row|
        if row['playerID'] && row['nameFirst'] && row['nameLast']
          @names[row['playerID']] = row['nameFirst'] + " " + row["nameLast"]
        end
      end
    end

    def name(id)
      @names[id]
    end
  end
end
