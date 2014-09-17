require_relative '../test_helper'

module BattingStats
  class PlayerTest < Minitest::Test
    def setup
      @stat = {"playerID" => "aardsda01", "yearID" => "2012", "league" => "AL",
          "teamID" => "NYA", "G" => "1", "AB" => "200", "R" => nil, "H" => '98',
          "2B" => "20", "3B" => "10", "HR" => "8", "RBI" => "3", "SB" => "1",
          "CS" => nil}
      @player = BattingStats::Player.new(@stat)
    end

    def test_batting_average
      @player.add_year(@stat)
      assert_equal (98.to_f/200), @player.batting_average(2012)
    end

    def test_batting_average_without_at_bats
      @stat = {"playerID" => "aardsda01", "yearID" => "2012", "league" => "AL",
          "teamID" => "NYA", "G" => "1", "AB" => "0", "R" => nil, "H" => '98',
          "2B" => "20", "3B" => "10", "HR" => "8", "RBI" => "3", "SB" => "1",
          "CS" => nil}
      @player = BattingStats::Player.new(@stat)
      assert_equal 0, @player.batting_average(2012)
    end


    def test_slugging_percentage
      @player.add_year(@stat)
      assert_equal (162.to_f/200), @player.slugging_pct(2012)
    end
  end
end
