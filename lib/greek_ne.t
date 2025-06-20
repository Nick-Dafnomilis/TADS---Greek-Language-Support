#charset "utf-8"

/*
 * Greek Noun Endings, Articles and Gender Rules
 */

modify Thing
    getDefiniteArticle() {
        if (gender == &masculine) return "ο ";
        if (gender == &feminine)  return "η ";
        if (gender == &neuter)    return "το ";
        return "";
    }

    getIndefiniteArticle() {
        if (gender == &masculine) return "ένας ";
        if (gender == &feminine)  return "μία ";
        if (gender == &neuter)    return "ένα ";
        return "";
    }

    getObjName() {
        return getDefiniteArticle() + name;
    }
;