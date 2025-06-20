#charset "utf-8"
#include "en_us.h"

verbRule(Κοίτα)
    ('κοίτα' | 'παρατήρησε') singleDobj
    : LookAction
;

verbRule(Πάρε)
    ('πάρε' | 'σήκωσε') singleDobj
    : TakeAction
;

verbRule(Άσε)
    ('άσε' | 'άφησε') singleDobj
    : DropAction
;

verbRule(Πήγαινε)
    ('πήγαινε' | 'προχώρησε' | 'πήγαινε προς') singleDir
    : GoAction
;

verbRule(Άνοιξε)
    ('άνοιξε') singleDobj
    : OpenAction
;

verbRule(Κλείσε)
    ('κλείσε') singleDobj
    : CloseAction
;

verbRule(Μίλα)
    ('μίλα' | 'συζήτησε') singleDobj
    : TalkToAction
;

verbRule(Ρώτα)
    ('ρώτα') singleDobj singleTopic
    : AskAboutAction
;
