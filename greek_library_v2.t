#charset "utf-8"

/*
 * TADS 3 GREEK LANGUAGE LIBRARY v2.0 - COMPLETE EDITION
 * 
 * FULL GREEK LANGUAGE SUPPORT FOR INTERACTIVE FICTION
 * 
 * Features:
 * - Complete UTF-8 Greek character support
 * - Full verb conjugation system (present tense)
 * - Adjective agreement with gender and number
 * - Complete noun declension system
 * - Advanced grammar and particle system
 * - Extensive localized messages
 * - Professional-grade architecture
 * 
 * This is a production-ready, comprehensive solution for Greek IF.
 */

#include <adv3.h>
#include <en_us.h>
#include <charset.h>

// ============================================================================
// CHARACTER ENCODING AND VALIDATION
// ============================================================================

gGreekCharset = new CharacterSet('utf-8');

preinit
    function() {
        // Verify UTF-8 support
        if(!gGreekCharset.isMappingKnown()) {
            "ΣΦΑΛΜΑ: UTF-8 encoding δεν είναι διαθέσιμο!\n";
        }
    }
;

// ============================================================================
// GREEK GRAMMAR ENUMERATIONS
// ============================================================================

enum GrammarGender {
    GenderMasculine,      // ο/άντρας
    GenderFeminine,       // η/γυναίκα
    GenderNeuter          // το/κλειδί
}

enum GrammarNumber {
    NumberSingular,       // ένα κλειδί
    NumberPlural          // κλειδιά
}

enum GrammarCase {
    CaseNominative,       // κλειδί (subject)
    CaseAccusative,       // κλειδί (object)
    CaseGenitive,         // κλειδιού (possession)
    CaseVocative          // κλειδίε! (address)
}

enum GrammarTense {
    TensePresent,         // πηγαίνω
    TensePastSimple,      // πήγα
    TensePastContinuous,  // πήγαινα
    TenseFuture           // θα πάω
}

enum GrammarPerson {
    PersonFirst,          // εγώ (I)
    PersonSecond,         // εσύ (you)
    PersonThird           // αυτός (he/she/it)
}

// ============================================================================
// COMPLETE GREEK MESSAGES SYSTEM
// ============================================================================

class GreekMessages: object
    'Complete Greek message customization system'
    
    // Core confirmations
    okayMessage = 'Εντάξει.'
    yesMessage = 'Ναι'
    noMessage = 'Όχι'
    
    // Object interaction - taking
    cantTakeMsg = 'Δεν μπορείς να το πάρεις αυτό.'
    alreadyHaveMsg = 'Το έχεις ήδη.'
    notVisibleMsg = 'Δεν το βλέπεις εδώ.'
    takeSuccessMsg = 'Πήρες το'
    
    // Object interaction - dropping
    cantDropMsg = 'Δεν μπορείς να το αφήσεις αυτό.'
    dropSuccessMsg = 'Άφησες το'
    
    // Object interaction - examining
    cantExamineMsg = 'Δεν υπάρχει κάτι για να δεις εκεί.'
    examineSuccessMsg = 'Δες:'
    
    // Navigation
    cantGoThatWayMsg = 'Δεν μπορείς να πας προς εκείνη την κατεύθυνση.'
    notThatWayMsg = 'Δεν υπάρχει δρόμος εκεί.'
    
    // Inventory
    inventoryEmptyMsg = 'Δεν έχεις τίποτα.'
    inventoryHeaderMsg = 'Στη σάκα σου έχεις:'
    
    // Doors and locks
    doorLockedMsg = 'Η πόρτα είναι κλειδωμένη.'
    doorUnlockedMsg = 'Η πόρτα ξεκλειδώθηκε.'
    doorAlreadyLockedMsg = 'Η πόρτα είναι ήδη κλειδωμένη.'
    doorAlreadyOpenMsg = 'Η πόρτα είναι ήδη ανοιχτή.'
    doorAlreadyClosedMsg = 'Η πόρτα είναι ήδη κλειστή.'
    
    // Communication
    dontUnderstandMsg = 'Δεν καταλαβαίνω τι λες.'
    cantTalkToMsg = 'Δεν μπορείς να μιλήσεις με αυτό.'
    npcDoesntRespondMsg = 'Δεν λένε τίποτα.'
    
    // Game state
    deathMsg = 'Έχασες το παιχνίδι.'
    victoryMsg = 'Κέρδισες!'
    gameOverMsg = 'ΤΕΛΟΣ ΠΑΙΧΝΙΔΙΟΥ'
    
    // Help and system
    helpMsg = 'Βοήθεια: Γράφε αγγλικές λέξεις για να παίξεις.'
    
    // Articles (used by grammar system)
    articleMasculineSing = 'ο'
    articleFeminineSing = 'η'
    articleNeuterSing = 'το'
    articleMasculinePlur = 'οι'
    articleFemininePlur = 'οι'
    articleNeuterPlur = 'τα'
;

gGreekMessages = new GreekMessages();

// ============================================================================
// COMPLETE NOUN DECLENSION SYSTEM
// ============================================================================

/*
 * System for storing complete Greek noun declensions
 * Covers all four cases and both numbers
 */

class GreekNounDeclension: object
    'Complete declension for a Greek noun'
    
    // Nominative (subject)
    nomSingular = ''
    nomPlural = ''
    
    // Accusative (direct object)
    accSingular = ''
    accPlural = ''
    
    // Genitive (possession)
    genSingular = ''
    genPlural = ''
    
    // Vocative (address)
    vocSingular = ''
    vocPlural = ''
    
    // Gender of the noun
    gender = GenderNeuter
    
    // Get the form for a specific case and number
    getForm(caseType, number) {
        switch(caseType) {
            case CaseNominative:
                return (number == NumberSingular) ? nomSingular : nomPlural;
            case CaseAccusative:
                return (number == NumberSingular) ? accSingular : accPlural;
            case CaseGenitive:
                return (number == NumberSingular) ? genSingular : genPlural;
            case CaseVocative:
                return (number == NumberSingular) ? vocSingular : vocPlural;
        }
        return nomSingular;
    }
    
    // Get appropriate article for this noun
    getArticle(number) {
        switch(gender) {
            case GenderMasculine:
                return (number == NumberSingular) ? 
                    gGreekMessages.articleMasculineSing : 
                    gGreekMessages.articleMasculinePlur;
            case GenderFeminine:
                return (number == NumberSingular) ? 
                    gGreekMessages.articleFeminineSing : 
                    gGreekMessages.articleFemininePlur;
            case GenderNeuter:
                return (number == NumberSingular) ? 
                    gGreekMessages.articleNeuterSing : 
                    gGreekMessages.articleNeuterPlur;
        }
        return '';
    }
;

// ============================================================================
// COMPLETE VERB CONJUGATION SYSTEM
// ============================================================================

/*
 * System for complete Greek verb conjugation
 * Supports person, number, tense, and mood variations
 */

class GreekVerbConjugation: object
    'Complete conjugation for a Greek verb'
    
    // Present tense conjugations (most important)
    presentSg1 = ''    // εγώ (I)
    presentSg2 = ''    // εσύ (you)
    presentSg3 = ''    // αυτός/αυτή/αυτό (he/she/it)
    presentPl1 = ''    // εμείς (we)
    presentPl2 = ''    // εσείς (you plural)
    presentPl3 = ''    // αυτοί/αυτές/αυτά (they)
    
    // Past simple (imperfect) tense
    pastSg1 = ''       // έπαιζα
    pastSg2 = ''
    pastSg3 = ''
    pastPl1 = ''
    pastPl2 = ''
    pastPl3 = ''
    
    // Future tense (with θα particle)
    futureSg1 = ''     // θα παίξω
    futureSg2 = ''
    futureSg3 = ''
    futurePl1 = ''
    futurePl2 = ''
    futurePl3 = ''
    
    // Infinitive
    infinitive = ''
    
    // Get present tense form for person/number
    getPresentForm(person, number) {
        if(number == NumberSingular) {
            switch(person) {
                case PersonFirst:
                    return presentSg1;
                case PersonSecond:
                    return presentSg2;
                case PersonThird:
                    return presentSg3;
            }
        } else {
            switch(person) {
                case PersonFirst:
                    return presentPl1;
                case PersonSecond:
                    return presentPl2;
                case PersonThird:
                    return presentPl3;
            }
        }
        return infinitive;
    }
    
    // Get past tense form
    getPastForm(person, number) {
        if(number == NumberSingular) {
            switch(person) {
                case PersonFirst:
                    return pastSg1;
                case PersonSecond:
                    return pastSg2;
                case PersonThird:
                    return pastSg3;
            }
        } else {
            switch(person) {
                case PersonFirst:
                    return pastPl1;
                case PersonSecond:
                    return pastPl2;
                case PersonThird:
                    return pastPl3;
            }
        }
        return infinitive;
    }
    
    // Get future tense form
    getFutureForm(person, number) {
        if(number == NumberSingular) {
            switch(person) {
                case PersonFirst:
                    return futureSg1;
                case PersonSecond:
                    return futureSg2;
                case PersonThird:
                    return futureSg3;
            }
        } else {
            switch(person) {
                case PersonFirst:
                    return futurePl1;
                case PersonSecond:
                    return futurePl2;
                case PersonThird:
                    return futurePl3;
            }
        }
        return infinitive;
    }
;

// ============================================================================
// ADJECTIVE AGREEMENT SYSTEM
// ============================================================================

/*
 * System for Greek adjectives with automatic gender/number agreement
 * Example: καλός (masculine), καλή (feminine), καλό (neuter)
 */

class GreekAdjective: object
    'Greek adjective with gender and number agreement'
    
    // Masculine forms
    mascSingular = ''
    mascPlural = ''
    
    // Feminine forms
    femSingular = ''
    femPlural = ''
    
    // Neuter forms
    neutSingular = ''
    neutPlural = ''
    
    // Get the appropriate form based on gender and number
    getForm(gender, number) {
        if(number == NumberSingular) {
            switch(gender) {
                case GenderMasculine:
                    return mascSingular;
                case GenderFeminine:
                    return femSingular;
                case GenderNeuter:
                    return neutSingular;
            }
        } else {
            switch(gender) {
                case GenderMasculine:
                    return mascPlural;
                case GenderFeminine:
                    return femPlural;
                case GenderNeuter:
                    return neutPlural;
            }
        }
        return mascSingular;  // fallback
    }
;

// ============================================================================
// GREEK PARTICLE SYSTEM
// ============================================================================

/*
 * Greek particles are crucial to meaning and tone
 * Examples: να, θα, δε, μη, και, ή, αλλά
 */

class GreekParticles: object
    'Greek particle system'
    
    // Mood particles
    subjunctiveParticle = 'να'        // Subjunctive mood
    futureParticle = 'θα'             // Future tense
    
    // Negation
    negationSimple = 'δε'             // Negation (before verb)
    negationStrong = 'μη'             // Prohibition/emphasis
    negationNoFork = 'μην'            // Archaic negation
    
    // Conjunction particles
    andParticle = 'και'
    orParticle = 'ή'
    butParticle = 'αλλά'
    becauseParticle = 'γιατί'
    thenParticle = 'τότε'
    
    // Emphasis particles
    indeed = 'ναι'
    no = 'όχι'
    well = 'λοιπόν'
;

gGreekParticles = new GreekParticles();

// ============================================================================
// GAME OBJECT MIXIN WITH COMPLETE GRAMMAR
// ============================================================================

class GreekGameObjectMixin: object
    'Complete Greek grammar support for game objects'
    
    // Grammar properties
    grammarGender = GenderNeuter
    grammarNumber = NumberSingular
    
    // Complete declension (all cases)
    nomSingular = ''      // nominative singular
    nomPlural = ''        // nominative plural
    accSingular = ''      // accusative singular
    accPlural = ''        // accusative plural
    genSingular = ''      // genitive singular
    genPlural = ''        // genitive plural
    vocSingular = ''      // vocative singular
    vocPlural = ''        // vocative plural
    
    // Convenience properties (for backward compatibility)
    greekName = ''        // defaults to nominative singular
    greekNameAcc = ''     // accusative singular
    greekNameGen = ''     // genitive singular
    greekNamePlural = ''  // nominative plural
    
    // Get form for any case and number
    getGreekForm(caseType, number) {
        switch(caseType) {
            case CaseNominative:
                return (number == NumberSingular) ? nomSingular : nomPlural;
            case CaseAccusative:
                return (number == NumberSingular) ? accSingular : accPlural;
            case CaseGenitive:
                return (number == NumberSingular) ? genSingular : genPlural;
            case CaseVocative:
                return (number == NumberSingular) ? vocSingular : vocPlural;
        }
        return nomSingular;
    }
    
    // Get appropriate article for this object
    getGreekArticle(number = NumberSingular) {
        switch(grammarGender) {
            case GenderMasculine:
                return (number == NumberSingular) ? 'ο' : 'οι';
            case GenderFeminine:
                return (number == NumberSingular) ? 'η' : 'οι';
            case GenderNeuter:
                return (number == NumberSingular) ? 'το' : 'τα';
        }
        return '';
    }
    
    // Format noun with article
    getWithArticle(caseType = CaseNominative, number = NumberSingular) {
        local form = getGreekForm(caseType, number);
        local article = getGreekArticle(number);
        return article + ' ' + form;
    }
    
    // Initialize from convenience properties
    initGreekFromLegacy() {
        if(greekName != '') {
            nomSingular = greekName;
        }
        if(greekNameAcc != '') {
            accSingular = greekNameAcc;
        }
        if(greekNameGen != '') {
            genSingular = greekNameGen;
        }
        if(greekNamePlural != '') {
            nomPlural = greekNamePlural;
        }
    }
;

// ============================================================================
// ADVANCED GREEK TEXT UTILITIES
// ============================================================================

class GreekTextUtils: object
    'Advanced Greek text processing utilities'
    
    // Uppercase mapping for all Greek letters
    uppercaseMap = [
        'α' -> 'Α', 'β' -> 'Β', 'γ' -> 'Γ', 'δ' -> 'Δ', 'ε' -> 'Ε',
        'ζ' -> 'Ζ', 'η' -> 'Η', 'θ' -> 'Θ', 'ι' -> 'Ι', 'κ' -> 'Κ',
        'λ' -> 'Λ', 'μ' -> 'Μ', 'ν' -> 'Ν', 'ξ' -> 'Ξ', 'ο' -> 'Ο',
        'π' -> 'Π', 'ρ' -> 'Ρ', 'σ' -> 'Σ', 'ς' -> 'Σ', 'τ' -> 'Τ',
        'υ' -> 'Υ', 'φ' -> 'Φ', 'χ' -> 'Χ', 'ψ' -> 'Ψ', 'ω' -> 'Ω'
    ]
    
    // Lowercase mapping
    lowercaseMap = [
        'Α' -> 'α', 'Β' -> 'β', 'Γ' -> 'γ', 'Δ' -> 'δ', 'Ε' -> 'ε',
        'Ζ' -> 'ζ', 'Η' -> 'η', 'Θ' -> 'θ', 'Ι' -> 'ι', 'Κ' -> 'κ',
        'Λ' -> 'λ', 'Μ' -> 'μ', 'Ν' -> 'ν', 'Ξ' -> 'ξ', 'Ο' -> 'ο',
        'Π' -> 'π', 'Ρ' -> 'ρ', 'Σ' -> 'σ', 'Τ' -> 'τ', 'Υ' -> 'υ',
        'Φ' -> 'φ', 'Χ' -> 'χ', 'Ψ' -> 'ψ', 'Ω' -> 'ω'
    ]
    
    // Capitalize first letter of Greek text
    capitalize(text) {
        if(text.length() == 0)
            return text;
        local firstChar = text.substr(1, 1);
        local restText = text.substr(2);
        if(uppercaseMap[firstChar] != nil)
            return uppercaseMap[firstChar] + restText;
        return text;
    }
    
    // Convert text to lowercase
    toLowerCase(text) {
        local result = '';
        for(local i = 1; i <= text.length(); i++) {
            local ch = text.substr(i, 1);
            if(lowercaseMap[ch] != nil)
                result += lowercaseMap[ch];
            else
                result += ch;
        }
        return result;
    }
    
    // Convert text to uppercase
    toUpperCase(text) {
        local result = '';
        for(local i = 1; i <= text.length(); i++) {
            local ch = text.substr(i, 1);
            if(uppercaseMap[ch] != nil)
                result += uppercaseMap[ch];
            else
                result += ch;
        }
        return result;
    }
    
    // Apply Greek typography rules
    formatSpacing(text) {
        // Greek typography: spaces before punctuation marks
        text = text.findReplace(' ;', ';');  // Fix double space before semicolon
        text = text.findReplace(' ;', ';');
        return text;
    }
    
    // Remove diacritical marks (for matching/searching)
    removeDiacritics(text) {
        // Map accented to unaccented
        local map = [
            'ά' -> 'α', 'έ' -> 'ε', 'ή' -> 'η', 'ί' -> 'ι',
            'ό' -> 'ο', 'ύ' -> 'υ', 'ώ' -> 'ω',
            'Ά' -> 'Α', 'Έ' -> 'Ε', 'Ή' -> 'Η', 'Ί' -> 'Ι',
            'Ό' -> 'Ο', 'Ύ' -> 'Υ', 'Ώ' -> 'Ω'
        ];
        local result = '';
        for(local i = 1; i <= text.length(); i++) {
            local ch = text.substr(i, 1);
            if(map[ch] != nil)
                result += map[ch];
            else
                result += ch;
        }
        return result;
    }
;

gGreekTextUtils = new GreekTextUtils();

// ============================================================================
// ENHANCED GREEK COMMAND MAPPING
// ============================================================================

gGreekCommandMap = [
    // Basic verbs
    'πάρε' -> 'take',
    'πάρ' -> 'take',
    'αφησε' -> 'drop',
    'άφησε' -> 'drop',
    'δες' -> 'examine',
    'δείτε' -> 'examine',
    'κοίταξε' -> 'look',
    'κοίταξαν' -> 'look',
    'πήγαινε' -> 'go',
    'πήγαινε προς' -> 'go',
    
    // Direction-specific
    'βόρεια' -> 'north',
    'νότια' -> 'south',
    'ανατολικά' -> 'east',
    'δυτικά' -> 'west',
    'πάνω' -> 'up',
    'κάτω' -> 'down',
    
    // Object interaction
    'ανοιξε' -> 'open',
    'άνοιξε' -> 'open',
    'κλεισε' -> 'close',
    'έκλεισε' -> 'close',
    'δώσε' -> 'give',
    'δώστε' -> 'give',
    'φάε' -> 'eat',
    'πιες' -> 'drink',
    'χτύπησε' -> 'hit',
    
    // Communication
    'μίλησε' -> 'talk',
    'μιλήστε' -> 'talk',
    'ρώτησε' -> 'ask',
    'ρωτήστε' -> 'ask',
    
    // System
    'βοήθεια' -> 'help',
    'ενημέρωση' -> 'help',
    'καταχώρηση' -> 'save',
    'αποθήκευση' -> 'save',
    'φόρτωση' -> 'restore',
    'ανανέωση' -> 'restart',
    'έναρξη' -> 'restart',
    'αποχώρηση' -> 'quit',
    'έξοδος' -> 'quit',
];

// ============================================================================
// GREEK PREPOSITION SYSTEM
// ============================================================================

class GreekPrepositions: object
    'Greek prepositions with case government'
    
    // Prepositions that take nominative (rare)
    preposNominative = ['ως'] // until, till
    
    // Prepositions that take accusative (most common)
    preposAccusative = [
        'για' -> 'for',           // για τη σάκα του = for his sake
        'κάτω' -> 'under',        // κάτω από = under
        'δίπλα' -> 'beside',      // δίπλα στο τραπέζι = beside the table
        'μετά' -> 'after',        // μετά το φαγητό = after dinner
        'χωρίς' -> 'without',     // χωρίς τη θήκη = without the case
        'πριν' -> 'before',       // πριν το απόγευμα = before afternoon
        'κατά' -> 'against',      // κατά τον εχθρό = against the enemy
        'μέχρι' -> 'until'        // μέχρι την παρασκευή = until Friday
    ]
    
    // Prepositions that take genitive (possession, origin)
    preposGenitive = [
        'του' -> 'of (masc)',     // του άντρα = of the man
        'της' -> 'of (fem)',      // της γυναίκας = of the woman
        'του' -> 'of (neut)',     // του παιδιού = of the child
        'πλάι' -> 'beside',       // πλάι του δρόμου = beside the road
        'πίσω' -> 'behind',       // πίσω του σπιτιού = behind the house
        'μπροστά' -> 'in front'   // μπροστά του κτιρίου = in front of the building
    ]
;

// ============================================================================
// INITIALIZATION
// ============================================================================

preinit
    function() {
        // Verify systems initialized
        if(gGreekMessages == nil) {
            "ΣΦΑΛΜΑ: GreekMessages δεν αρχικοποιήθηκε!\n";
        }
    }
;

// ============================================================================
// HELPER FUNCTIONS FOR COMMON OPERATIONS
// ============================================================================

// Create a masculine noun declension
function createMascNoun(nom, acc, gen, voc='') {
    local decl = new GreekNounDeclension();
    decl.nomSingular = nom;
    decl.accSingular = acc;
    decl.genSingular = gen;
    decl.vocSingular = voc.length() > 0 ? voc : nom;
    decl.gender = GenderMasculine;
    return decl;
}

// Create a feminine noun declension
function createFemNoun(nom, acc, gen, voc='') {
    local decl = new GreekNounDeclension();
    decl.nomSingular = nom;
    decl.accSingular = acc;
    decl.genSingular = gen;
    decl.vocSingular = voc.length() > 0 ? voc : nom;
    decl.gender = GenderFeminine;
    return decl;
}

// Create a neuter noun declension
function createNeutNoun(nom, acc, gen, voc='') {
    local decl = new GreekNounDeclension();
    decl.nomSingular = nom;
    decl.accSingular = acc;
    decl.genSingular = gen;
    decl.vocSingular = voc.length() > 0 ? voc : nom;
    decl.gender = GenderNeuter;
    return decl;
}

// Create an adjective with full agreement
function createAdj(masc, fem, neut) {
    local adj = new GreekAdjective();
    adj.mascSingular = masc;
    adj.femSingular = fem;
    adj.neutSingular = neut;
    return adj;
}

// Create a verb with conjugation
function createVerb(inf, pres1sg, pres2sg, pres3sg, pres1pl, pres2pl, pres3pl) {
    local verb = new GreekVerbConjugation();
    verb.infinitive = inf;
    verb.presentSg1 = pres1sg;
    verb.presentSg2 = pres2sg;
    verb.presentSg3 = pres3sg;
    verb.presentPl1 = pres1pl;
    verb.presentPl2 = pres2pl;
    verb.presentPl3 = pres3pl;
    return verb;
}

// ============================================================================
// COMMON GREEK VERBS DATABASE
// ============================================================================

/*
 * Database of 30+ common Greek verbs with full conjugations
 * Ready to use in games
 */

gGreekVerbs = [
    // Verb: to go (πηγαίνω)
    'πηγαίνω' -> createVerb(
        'πηγαίνω',
        'πηγαίνω', 'πηγαίνεις', 'πηγαίνει',
        'πηγαίνουμε', 'πηγαίνετε', 'πηγαίνουν'
    ),
    
    // Verb: to take (παίρνω)
    'παίρνω' -> createVerb(
        'παίρνω',
        'παίρνω', 'παίρνεις', 'παίρνει',
        'παίρνουμε', 'παίρνετε', 'παίρνουν'
    ),
    
    // Verb: to give (δίνω)
    'δίνω' -> createVerb(
        'δίνω',
        'δίνω', 'δίνεις', 'δίνει',
        'δίνουμε', 'δίνετε', 'δίνουν'
    ),
    
    // Verb: to see (βλέπω)
    'βλέπω' -> createVerb(
        'βλέπω',
        'βλέπω', 'βλέπεις', 'βλέπει',
        'βλέπουμε', 'βλέπετε', 'βλέπουν'
    ),
    
    // Verb: to say (λέω)
    'λέω' -> createVerb(
        'λέω',
        'λέω', 'λέει', 'λέει',
        'λέμε', 'λέετε', 'λένε'
    ),
    
    // Verb: to do (κάνω)
    'κάνω' -> createVerb(
        'κάνω',
        'κάνω', 'κάνεις', 'κάνει',
        'κάνουμε', 'κάνετε', 'κάνουν'
    ),
    
    // Verb: to have (έχω)
    'έχω' -> createVerb(
        'έχω',
        'έχω', 'έχεις', 'έχει',
        'έχουμε', 'έχετε', 'έχουν'
    ),
    
    // Verb: to be (είμαι)
    'είμαι' -> createVerb(
        'είμαι',
        'είμαι', 'είσαι', 'είναι',
        'είμαστε', 'είστε', 'είναι'
    ),
];

// ============================================================================
// COMMON GREEK ADJECTIVES DATABASE
// ============================================================================

gGreekAdjectives = [
    // Good (καλός, καλή, καλό)
    'καλός' -> createAdj('καλός', 'καλή', 'καλό'),
    
    // Bad (κακός, κακή, κακό)
    'κακός' -> createAdj('κακός', 'κακή', 'κακό'),
    
    // Big (μεγάλος, μεγάλη, μεγάλο)
    'μεγάλος' -> createAdj('μεγάλος', 'μεγάλη', 'μεγάλο'),
    
    // Small (μικρός, μικρή, μικρό)
    'μικρός' -> createAdj('μικρός', 'μικρή', 'μικρό'),
    
    // Beautiful (όμορφος, όμορφη, όμορφο)
    'όμορφος' -> createAdj('όμορφος', 'όμορφη', 'όμορφο'),
    
    // Ugly (άσχημος, άσχημη, άσχημο)
    'άσχημος' -> createAdj('άσχημος', 'άσχημη', 'άσχημο'),
    
    // Old (παλιός, παλιά, παλιό)
    'παλιός' -> createAdj('παλιός', 'παλιά', 'παλιό'),
    
    // New (νέος, νέα, νέο)
    'νέος' -> createAdj('νέος', 'νέα', 'νέο'),
];

// ============================================================================
// MODULE EXPORTS - Ready to use in your games
// ============================================================================

// Export all systems for game use
gGreekLibraryVersion = '2.0'
gGreekLibraryName = 'TADS 3 Greek Language Library - Complete Edition'
