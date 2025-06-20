#charset "utf-8"
versionInfo: GameID
    name = "Greek Demo Game"
    byline = "του Νίκου Γ. Δαφνομήλη"
    version = "1.0"

gameMain: GameMainDef
    initialPlayerChar = me

startRoom: Room
    name = "Αφετηρία"
    desc = "Η αρχή της περιπέτειας."

me: Actor
    isPlayerChar = true
    location = startRoom
