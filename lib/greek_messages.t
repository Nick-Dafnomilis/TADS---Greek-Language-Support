// Ελληνικά συστημικά μηνύματα για το TADS 3
// Κάθε μήνυμα αντικαθιστά το προεπιλεγμένο αγγλικό με ελληνικό

#charset "utf-8"

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