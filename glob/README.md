## API Usage
### `glob.compile(globptn)`
* `globptn`: Glob pattern to be converted into Lua pattern

Convert a glob pattern into Lua pattern.

### `glob.match_in_list(list,globptn)`
* `list`: List of values to be matched
* `globptn`: The glob pattern used to match the values in `list`

Given a list of values and the glob pattern, return the matches.

### `glob.match_players(globptn)`
* `globptn`: The glob pattern used to match the list of player names

Given a glob pattern, return the player names matched.
