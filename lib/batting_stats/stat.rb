
module BattingStats
  class Stat
    attr_accessor :team, :league, :hits, :at_bats, :doubles, :triples, :home_runs, :year, :rbis

    # H – hits
    # 2B – doubles
    # 3B – triples
    # HR – home runs
    # RBI – runs batted in
    def initialize(data)
      @team = data['teamID']
      @league = data['league']
      @hits = data['H'].to_i
      @at_bats = data['AB'].to_i
      @doubles = data['2B'].to_i
      @triples = data['3B'].to_i
      @home_runs = data['HR'].to_i
      @year = data['yearID'].to_i
      @rbis = data['RBI'].to_i
    end
  end
end
