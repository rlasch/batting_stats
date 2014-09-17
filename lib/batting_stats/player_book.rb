require 'pry'

module BattingStats
  class PlayerBook
    attr_accessor :players, :records, :record_holders, :rosters

    def initialize
      @players = {}
      @rosters = {}
      @records = {}
      @record_holders = {}
    end


    def most_improved_record(statistic, league, year)
      id = nil
      return [nil, nil] unless @records[year] && @records[year][league]
      hi = @records[year][league][:"improved_#{statistic}"]
      id = @record_holders[year][league][:"improved_#{statistic}"]
      binding.pry
      [hi, id]
    end


    def triple_crown(league, year)
      if @record_holders[year] && @record_holders[year][league]
        bat_avg_champ = @record_holders[year][league][:batting_average]
        hr_champ = @record_holders[year][league][:home_runs]
        rbis_champ = @record_holders[year][league][:rbis]
        rbis_champ == hr_champ && hr_champ == bat_avg_champ ? hr_champ : nil
      else
        nil
      end
    end


    def best_record(stat, league, year)
      if @records[year] && @records[year][league] && @records[year][league][stat]
        [@records[year][league][stat], @record_holders[year][league][stat]]
      else
        [nil, nil]
      end
    end


    def add(data)
      id = data['playerID']
      if @players[id].nil?
        @players[id] = Player.new(data)
      end
      @players[id].add_year(data)
      player = @players[id]
      year = data['yearID'].to_i
      league = player.league(year)
      team = player.team(year)

      [:home_runs, :rbis, :batting_average].each do |s|
        record_most_stat(s, player, year, 400)
      end

      (0..1).each do |i|
        record_most_improved_stat(:batting_average, player, year + i, 200)
      end

      @rosters[year] = {} unless @rosters[year]
      @rosters[year][team] = [] unless rosters[year][team]
      @rosters[year][team] << player
    end

    private
    def record_most_improved_stat(statistic, player, year, min_at_bats)
      previous = player.send(statistic, year - 1)
      current = player.send(statistic, year)
      previous_ab = player.at_bats(year - 1)
      current_ab = player.at_bats(year)

      return unless current && previous
      league = player.league(year)

      if current > 0 && previous > 0 && previous_ab >= min_at_bats && current_ab >= min_at_bats
        @records[year] = {} unless @records[year]
        @records[year][league] = {} unless @records[year][league]
        improvement = current - previous
        # binding.pry if player.id == 'hamiljo03'
        if @records[year][league][:"improved_#{statistic}"].nil? || improvement > @records[year][league][:"improved_#{statistic}"]
          @records[year][league][:"improved_#{statistic}"] = improvement
          @record_holders[year][league][:"improved_#{statistic}"] = player.id
        end
      end
    end


    def record_most_stat(statistic, player, year, min_at_bats)
      league = player.league(year)

      @records[year] = {} unless @records[year]
      @records[year][league] = {} unless @records[year][league]

      @record_holders[year] = {} unless @record_holders[year]
      @record_holders[year][league] = {} unless @record_holders[year][league]

      current = records[year][league][statistic]

      if (current.nil? || player.send(statistic, year) > current) && player.at_bats(year) >= min_at_bats
        @records[year][league][statistic] = player.send(statistic, year)
        @record_holders[year][league][statistic] = player.id
      end
    end

  end
end
