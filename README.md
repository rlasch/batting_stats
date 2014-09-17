# BattingStats

This is a simple application that prints out the following reports:

1) Most improved batting average( hits / at-bats) from 2009 to 2010. Only include players with at least 200 at-bats.
2) Slugging percentage for all players on the Oakland A's (teamID = OAK) in 2007.
3) Who was the AL and NL triple crown winner for 2011 and 2012. If no one won the crown, output "(No winner)"

## Considerations / Thoughts

Although the instructions provided stated to treat this as production, it also
stated to spend whatever amount of time you think is reasonable.  Since I know
this is truly not production code, there are a few things that *IF* this was
truly production code, I would do a bit different.

1. Write more tests.  There are clearly not enough, but this is only an exercise.
2. Extracted out the reports into report classes.
3. Configuration file with some parameters given, such as master file, etc.
4. Make the gem runnable from anywhere.

Unfortunately, I have way too many projects on my plate, so the work submitted will have to suffice.

## Installation

git clone https://github.com/rlasch/batting_stats

## Usage

bin/batting_stats <batting-data-file>

There is an example file given: Batting-07-12.csv.  To run this example, run:

bin/batting_stats <batting-data-file>

To run tests. run :

rake test


## Contributing

1. Fork it ( https://github.com/rlasch/batting_stats/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
