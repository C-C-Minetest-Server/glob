# `rm -rf *`
... Did you do something like this in your *nix terminal? This mod prings the same function to Minetest!

## Patterns
The following syntaxes are currently supported:

* `*`: Match any combination (zero or more) of any charactors (`.*`)
* `?`: Match exactly one any charactor (`.`)
* `[abc]`, `[A-Za-z]`: Match one of the charactors listed inside, or in the range specified. (`[abc]`)

### Error Handling
This mod does not check for wrong syntaxes. The mod or the player should have the responsibility to check the pattern, if it's needed.

## Chatcommands
### `/globkick <glob pattern> [<reason>]`
* `glob pattern`: The glob pattern to select players by their name
* `reason`: *(Optional)* The reason of kick

Select players by their name, and then kick them out with the reason provided.

## APIs
ALl APIs exists under the `glob` namespace. Please referr to it's own README for documentations.


