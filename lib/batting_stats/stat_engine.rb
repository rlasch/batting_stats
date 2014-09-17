module BattingStats
  class StatEngine
    attr_accessor :loader, :player_book, :file_name


    def initialize(batting_file)
      raise "Format not supported for #{batting_file}" unless valid_format?(batting_file)
      @file_name = batting_file
      @player_book = PlayerBook.new
      @naming = NameLookup.new("Master-small.csv")
    end


    def execute
      load_data

      # Most Improved Batting Average
      report_most_improved_batting_average

      # Slugging percentages for the 2007 Oakland A's
      report_slugging_pct_oak

      # Triple Crown Winners
      report_triple_crown

      # Add more reports here...
    end


    private
    def load_data
      CsvPlayerLoader.process(@file_name) do |data|
        @player_book.add(data)
      end
    end


    def name(id)
      @naming.name(id) || id
    end


      # playerID,yearID,league,teamID,G,AB,R,H,2B,3B,HR,RBI,SB,CS
      # hamiljo03,2010,AL,TEX,133,518,95,186,40,3,32,100,8,1^M
      # hamiljo03,2009,AL,TEX,89,336,43,90,19,2,10,54,8,3^
    def report_most_improved_batting_average
      puts "Most Improved Batting Average from 2009 to 2010"
      avg_nl, id_nl = @player_book.most_improved_record(:batting_average, 'NL', 2010)
      avg_al, id_al = @player_book.most_improved_record(:batting_average, 'AL', 2010)

      avg, id = avg_nl > avg_al ? [avg_nl, id_nl] : [avg_al, id_al]
      puts "2009-2010 #{name(id)} (#{id})  diff #{"%0.3f" % avg}"
      puts
    end


    def report_slugging_pct_oak
      puts "Slugging Percentages for 2007 Oakland A's"
      roster = @player_book.rosters[2007]['OAK']
      roster.each do |player|
        puts "#{name(player.id)} #{"%0.3f" % player.slugging_pct(2007)}"
      end
      puts
    end


    def report_triple_crown
      puts "Triple Crown Winners 2011-12"
      ['AL', 'NL'].each do |league|
        [2011, 2012].each do |year|
          winner = @player_book.triple_crown(league, year)
          if winner
            puts "#{year} #{league} triple crown winner #{name(winner)}"
          else
            puts "#{year} #{league} (No winner)"
          end
        end
      end
    end


    def valid_format?(file_name)
      file_name.end_with?('.csv')
    end
  end
end
