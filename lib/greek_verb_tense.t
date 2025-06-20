#charset "utf-8"

modify Thing
    currentTense = 'ενεστώτας'
    verbTable = static [
        'λέω' -> [
            'ενεστώτας' -> 'λέω',
            'αόριστος' -> 'είπα',
            'μέλλοντας' -> 'θα πω'
        ]
    ]
;
