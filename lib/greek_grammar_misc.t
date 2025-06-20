#charset "utf-8"

// Γενικές εντολές / σύστημα

VerbRule(Help)
    ('βοήθεια' | 'βοήθησέ με')
    : HelpAction
;

VerbRule(Wait)
    ('περίμενε' | 'αναμονή')
    : WaitAction
;

VerbRule(Inventory)
    ('απογραφή' | 'τι έχω')
    : InventoryAction
;
// Εντολές συστήματος

VerbRule(Help)
    ('βοήθεια' | 'τι να κάνω')
    : HelpAction
;

VerbRule(Wait)
    ('περίμενε' | 'αναμονή')
    : WaitAction
;

VerbRule(Quit)
    ('έξοδος' | 'τερματισμός')
    : QuitGameAction
;
