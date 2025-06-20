#charset "utf-8"

// Πυρήνας: εντολές δράσης

VerbRule(Take)
    ('πάρε' | 'παίρνω') singleDobj
    : TakeAction
;

VerbRule(Drop)
    ('άφησε' | 'αφήνω') singleDobj
    : DropAction
;

VerbRule(Examine)
    ('κοίτα' | 'κοίταξε' | 'εξέτασε') singleDobj
    : ExamineAction
;

VerbRule(Go)
    ('πήγαινε' | 'προχώρα') singleDir
    : GoAction
;

VerbRule(Open)
    ('άνοιξε') singleDobj
    : OpenAction
;

VerbRule(Close)
    ('κλείσε') singleDobj
    : CloseAction
;
// Επιπλέον βασικά ρήματα

VerbRule(Open)
    ('άνοιξε' | 'ανοίγω') singleDobj
    : OpenAction
;

VerbRule(Close)
    ('κλείσε' | 'κλείνω') singleDobj
    : CloseAction
;

VerbRule(Unlock)
    ('ξεκλείδωσε' | 'ξεκλειδώνω') singleDobj singleIobj
    : UnlockWithAction
;

VerbRule(Lock)
    ('κλείδωσε' | 'κλειδώνω') singleDobj singleIobj
    : LockWithAction
;

VerbRule(Inventory)
    ('αντικείμενα' | 'τι έχω' | 'inventory')
    : InventoryAction
;
