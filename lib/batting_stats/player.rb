
module BattingStats
  class Player
    attr_accessor :stats, :id

    def initialize(data)
      @id = data['playerID']
      @stats = {}
    end

    def add_year(data)
      year = data['yearID'].to_i
      @stats[year] = Stat.new(data)
    end

    def rbis(year)
      @stats[year].rbis if @stats[year]
    end

    def team(year)
      @stats[year].team if @stats[year]
    end

    def at_bats(year)
      @stats[year].at_bats if @stats[year]
    end

    def league(year)
      @stats[year].league if @stats[year]
    end

    def home_runs(year)
      @stats[year].home_runs if @stats[year]
    end

    def batting_average(year)
      return 0 unless @stats[year] && @stats[year].at_bats && @stats[year].at_bats > 0
      @stats[year].hits.to_f / @stats[year].at_bats
    end

    def slugging_pct(year)
      s = @stats[year]
      return nil unless s
      s1 = (s.hits - s.doubles - s.triples - s.home_runs)
      s2 = (2 * s.doubles) + (3 * s.triples) + (4 * s.home_runs)
      s.at_bats == 0 ? 0 : ((s1 + s2).to_f / s.at_bats)
    end
  end
end
