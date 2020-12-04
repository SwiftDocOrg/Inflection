import struct Foundation.Locale

// Ported from https://github.com/rails/rails
extension Inflector {
    static var en: Inflector = {
        let locale = Locale(identifier: "en")
        let inflector = Inflector(locale: locale)

        plural: do {
            try inflector.addPluralizationRule(matching: #"$"#, replacement: "s")
            try inflector.addPluralizationRule(matching: #"s$"#, replacement: "s")
            try inflector.addPluralizationRule(matching: #"^(ax|test)is$"#, replacement: "$1es")
            try inflector.addPluralizationRule(matching: #"(octop|vir)us$"#, replacement: "$1i")
            try inflector.addPluralizationRule(matching: #"(octop|vir)i$"#, replacement: "$1i")
            try inflector.addPluralizationRule(matching: #"(alias|status)$"#, replacement: "$1es")
            try inflector.addPluralizationRule(matching: #"(bu)s$"#, replacement: "$1ses")
            try inflector.addPluralizationRule(matching: #"(buffal|tomat)o$"#, replacement: "$1oes")
            try inflector.addPluralizationRule(matching: #"([ti])um$"#, replacement: "$1a")
            try inflector.addPluralizationRule(matching: #"([ti])a$"#, replacement: "$1a")
            try inflector.addPluralizationRule(matching: #"sis$"#, replacement: "ses")
            try inflector.addPluralizationRule(matching: #"(?:([^f])fe|([lr])f)$"#, replacement: "$1$2ves")
            try inflector.addPluralizationRule(matching: #"(hive)$"#, replacement: "$1s")
            try inflector.addPluralizationRule(matching: #"([^aeiouy]|qu)y$"#, replacement: "$1ies")
            try inflector.addPluralizationRule(matching: #"(x|ch|ss|sh)$"#, replacement: "$1es")
            try inflector.addPluralizationRule(matching: #"(matr|vert|ind)(?:ix|ex)$"#, replacement: "$1ices")
            try inflector.addPluralizationRule(matching: #"^(m|l)ouse$"#, replacement: "$1ice")
            try inflector.addPluralizationRule(matching: #"^(m|l)ice$"#, replacement: "$1ice")
            try inflector.addPluralizationRule(matching: #"^(ox)$"#, replacement: "$1en")
            try inflector.addPluralizationRule(matching: #"^(oxen)$"#, replacement: "$1")
            try inflector.addPluralizationRule(matching: #"(quiz)$"#, replacement: "$1zes")
        } catch {
            fatalError(error.localizedDescription)
        }

        singular: do {
            try inflector.addSingularizationRule(matching: #"s$"#, replacement: "")
            try inflector.addSingularizationRule(matching: #"(ss)$"#, replacement: "$1")
            try inflector.addSingularizationRule(matching: #"(n)ews$"#, replacement: "$1ews")
            try inflector.addSingularizationRule(matching: #"([ti])a$"#, replacement: "$1um")
            try inflector.addSingularizationRule(matching: #"((a)naly|(b)a|(d)iagno|(p)arenthe|(p)rogno|(s)ynop|(t)he)(sis|ses)$"#, replacement: "$1sis")
            try inflector.addSingularizationRule(matching: #"(^analy)(sis|ses)$"#, replacement: "$1sis")
            try inflector.addSingularizationRule(matching: #"([^f])ves$"#, replacement: "$1fe")
            try inflector.addSingularizationRule(matching: #"(hive)s$"#, replacement: "$1")
            try inflector.addSingularizationRule(matching: #"(tive)s$"#, replacement: "$1")
            try inflector.addSingularizationRule(matching: #"([lr])ves$"#, replacement: "$1f")
            try inflector.addSingularizationRule(matching: #"([^aeiouy]|qu)ies$"#, replacement: "$1y")
            try inflector.addSingularizationRule(matching: #"(s)eries$"#, replacement: "$1eries")
            try inflector.addSingularizationRule(matching: #"(m)ovies$"#, replacement: "$1ovie")
            try inflector.addSingularizationRule(matching: #"(x|ch|ss|sh)es$"#, replacement: "$1")
            try inflector.addSingularizationRule(matching: #"^(m|l)ice$"#, replacement: "$1ouse")
            try inflector.addSingularizationRule(matching: #"(bus)(es)?$"#, replacement: "$1")
            try inflector.addSingularizationRule(matching: #"(o)es$"#, replacement: "$1")
            try inflector.addSingularizationRule(matching: #"(shoe)s$"#, replacement: "$1")
            try inflector.addSingularizationRule(matching: #"(cris|test)(is|es)$"#, replacement: "$1is")
            try inflector.addSingularizationRule(matching: #"^(a)x[ie]s$"#, replacement: "$1xis")
            try inflector.addSingularizationRule(matching: #"(octop|vir)(us|i)$"#, replacement: "$1us")
            try inflector.addSingularizationRule(matching: #"(alias|status)(es)?$"#, replacement: "$1")
            try inflector.addSingularizationRule(matching: #"^(ox)en"#, replacement: "$1")
            try inflector.addSingularizationRule(matching: #"(vert|ind)ices$"#, replacement: "$1ex")
            try inflector.addSingularizationRule(matching: #"(matr)ices$"#, replacement: "$1ix")
            try inflector.addSingularizationRule(matching: #"(quiz)zes$"#, replacement: "$1")
            try inflector.addSingularizationRule(matching: #"(database)s$"#, replacement: "$1")
        } catch {
            fatalError(error.localizedDescription)
        }

        irregular: do {
            inflector.addIrregular(singular: "person", plural: "people")
            inflector.addIrregular(singular: "man", plural: "men")
            inflector.addIrregular(singular: "child", plural: "children")
            inflector.addIrregular(singular: "sex", plural: "sexes")
            inflector.addIrregular(singular: "move", plural: "moves")
            inflector.addIrregular(singular: "zombie", plural: "zombies")

            inflector.addUncountable("equipment")
            inflector.addUncountable("information")
            inflector.addUncountable("rice")
            inflector.addUncountable("money")
            inflector.addUncountable("species")
            inflector.addUncountable("series")
            inflector.addUncountable("fish")
            inflector.addUncountable("sheep")
            inflector.addUncountable("jeans")
            inflector.addUncountable("police")
        }

        return inflector
    }()
}
