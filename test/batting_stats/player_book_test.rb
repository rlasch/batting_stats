require_relative '../test_helper'

module BattingStats
  class PlayerBookTest < Minitest::Test
    def setup
      @stat = {"playerID" => "aardsda01", "yearID" => "2012", "league" => "AL",
          "teamID" => "NYA", "G" => "1", "AB" => "200", "R" => nil, "H" => '98',
          "2B" => "20", "3B" => "10", "HR" => "8", "RBI" => "3", "SB" => "1",
          "CS" => nil}
      @book = PlayerBook.new()
    end


    def add_stats
      stats = []
      stats << {"playerID" => "aardsda01", "yearID" => "2012", "league" => "AL",
          "teamID" => "NYA", "G" => "1", "AB" => "500", "R" => nil, "H" => '240',
          "2B" => "20", "3B" => "10", "HR" => "80", "RBI" => "100", "SB" => "1",
          "CS" => nil}
      stats << {"playerID" => "aardsda01", "yearID" => "2011", "league" => "AL",
          "teamID" => "NYA", "G" => "1", "AB" => "500", "R" => nil, "H" => '108',
          "2B" => "20", "3B" => "20", "HR" => "8", "RBI" => "3", "SB" => "1",
          "CS" => nil}
      stats << {"playerID" => "cardsda01", "yearID" => "2012", "league" => "AL",
          "teamID" => "NYA", "G" => "1", "AB" => "300", "R" => nil, "H" => '98',
          "2B" => "20", "3B" => "10", "HR" => "8", "RBI" => "3", "SB" => "1",
          "CS" => nil}
      stats << {"playerID" => "dardsda01", "yearID" => "2013", "league" => "AL",
          "teamID" => "NYA", "G" => "1", "AB" => "400", "R" => nil, "H" => '108',
          "2B" => "20", "3B" => "20", "HR" => "8", "RBI" => "3", "SB" => "1",
          "CS" => nil}
      stats.each { |s| @book.add(s) }
    end


    def test_record_most_improved_stat
      add_stats
      hi, id = @book.most_improved_record(:batting_average, 'AL', 2012)
      assert_equal 0.264, hi
      assert_equal 'aardsda01', id
    end


    def test_best_record
      add_stats
      hi, id = @book.best_record(:batting_average, 'AL', 2012)
      assert_equal 0.48, hi
      assert_equal 'aardsda01', id
    end


    def test_triple_crown
      add_stats
      id = @book.triple_crown('AL', 2012)
      assert_equal 'aardsda01', id

      id = @book.triple_crown('AL', 2013)
      assert_equal 'dardsda01', id

      id = @book.triple_crown('NL', 2012)
      assert_nil id
    end
  end
end
