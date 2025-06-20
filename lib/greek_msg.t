#charset "utf-8"

/*
 * Greek System Message Overrides
 * Εδώ ορίζονται τα μηνύματα του συστήματος στα ελληνικά.
 */

modify Messages
    takenMsg(obj)        { "Πάρθηκε.
"; }
    alreadyHaveMsg(obj)  { "Ήδη το έχεις.
"; }
    cantSeeThatMsg       = "Δεν βλέπεις κάτι τέτοιο εδώ."
    actorNotPresentMsg   = "Δεν είναι εδώ."
    commandNotUnderstood = "Δεν κατάλαβα την εντολή."
    askForTopicMissing   = "Περί τίνος θέλεις να ρωτήσεις;"
    dropMsg(obj)         { "Αφήνεις " + obj.theName + ".
"; }
    openMsg(obj)         { "Ανοίγεις " + obj.theName + ".
"; }
    closeMsg(obj)        { "Κλείνεις " + obj.theName + ".
"; }
    inventoryHeader      = "Έχεις μαζί σου:"
;