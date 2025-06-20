#charset "utf-8"

// Καθορισμός γλώσσας, libMessages, κατευθύνσεις, ναι/όχι

languageID: LanguageID 'el_gr'
languageName: 'Ελληνικά'

languageGlobals: object
    unicode: true
;

modify libMessages
    cantGoThatWayMsg = 'Δεν μπορείς να πας προς τα εκεί.'
    exitMsg = 'Έξοδος.'
    unknownCommandMsg = 'Δεν καταλαβαίνω αυτήν την εντολή.'
    nothingToDoMsg = 'Δεν υπάρχει κάτι να κάνεις με αυτό.'
    notHereMsg = 'Δεν βλέπω κάτι τέτοιο εδώ.'
    inventoryMsg = 'Έχεις:'
;

modify YesParser
    yesWords = ['ναι', 'ν']
    noWords = ['όχι', 'ο']
;

northDir: Direction 'βορράς'
southDir: Direction 'νότος'
eastDir: Direction 'ανατολή'
westDir: Direction 'δύση'
upDir: Direction 'πάνω'
downDir: Direction 'κάτω'