![Screenshot](.gh-screenshot.png)

Message offline players [tell]
================================
* License: MIT (see [LICENSE](https://github.com/octacian/tell/blob/master/LICENSE))
* [Download Latest](https://github.com/octacian/tell/archive/master.zip)

It happens all the time (to me anyways), you join a server needing to tell someone something, but they aren't online. Sure, some servers have an email/mailbox system, but for many, such systems are overly complex. That's why I made tell.

Tell introduces a single command, `/tell` (note: if you have `mesecons_commandblock`, the command is renamed to `/tellafk` due to a conflict). It accepts the same parameters as does `/msg`, however, it does not require that the player be online. Instead, it registers the message sent (as well as the time the message was sent) to be shown next time the player specified is active. Whenever a player joins or sends a chat message, tell checks its internal table of messages and displays any that were meant for the player. This is useful both when you don't know when a player will come back online, or when a player is AFK (as the message is not shown until they send another chat message). __Warning:__ If you accidentally enter the wrong player username, the message will be stored anyway (even if the specified player has never joined before).

Tell also has a simple API, documented in [API.md](https://github.com/octacian/tell/blob/master/API.md). This is a rolling release, meaning that there are no version numbers due to the simplicity of this mod.