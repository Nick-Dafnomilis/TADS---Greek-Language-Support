#charset "utf-8"

// greek_parser_ext.t
// Υποστήριξη για εισαγωγή άρθρων/πτώσεων/μορφολογικών στοιχείων στο input

modify NounPhraseProduction
    // Ανίχνευση άρθρων για συμφωνία πτώσης
    initializeProduction() {
        inherited();

        // Παράδειγμα λέξεων άρθρων για συμφωνία
        if (theWord == 'ο' || theWord == 'η' || theWord == 'το') {
            curToken.nounCase = Nominative;
        }
        else if (theWord == 'τον' || theWord == 'την') {
            curToken.nounCase = Accusative;
        }
        else if (theWord == 'του' || theWord == 'της') {
            curToken.nounCase = Genitive;
        }
    }
;

// Ενισχύουμε την κατηγορία DirectionName ώστε να αποδέχεται ελληνικές μορφές
modify DirectionName
    resolveToken(tok) {
        local word = tok.getOrigText().toLower();
        return select (word)
            case 'βόρεια': northDirection
            case 'νότια': southDirection
            case 'ανατολικά': eastDirection
            case 'δυτικά': westDirection
            case 'πάνω': upDirection
            case 'κάτω': downDirection
            default: inherited(tok);
    }
;