#charset "utf-8"

// Ρήματα διαλόγου

VerbRule(TalkTo)
    ('μίλα' | 'συνομίλησε') ('στον' | 'στην' | 'στο') singleDobj
    : TalkToAction
;

VerbRule(AskAbout)
    ('ρώτα') singleDobj ('για') singleTopic
    : AskAboutTopicAction
;
// Ρήματα διαλόγου και επικοινωνίας

VerbRule(TalkTo)
    ('μίλα' | 'συνομίλησε') singleDobj
    : TalkToAction
;

VerbRule(AskAbout)
    ('ρώτα' | 'ρώτησε') singleDobj singleTopic
    : AskAboutAction
;

VerbRule(TellAbout)
    ('πες' | 'πείτε') singleDobj singleTopic
    : TellAboutAction
;

VerbRule(Show)
    ('δείξε') singleDobj singleIobj
    : ShowToAction
;

VerbRule(Give)
    ('δώσε') singleDobj singleIobj
    : GiveToAction
;
