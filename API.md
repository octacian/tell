Tell API
========
Tell has a very simple API composed of three functions for use by other mods.

`tell.add(name, from, msg)`

* Adds a message to be shown when the recipient is active
* `name`: Name of recipient (not `userdata`)
* `from`: Name of sender
* `msg`: Message

`tell.remove(name, id)`

* Removes a message
* `name`: Name of recipient (not `userdata`)
* `id`: Numerical ID of the message (returned by `tell.add`)

`tell.show(name)`

* Shows all messages for the specified player
* `name`: Name of player (not `userdata`)