import struct Foundation.Locale

// Ported from https://github.com/davidcelis/inflections
//
// Credits:
// - Steven G. Harms (https://github.com/sgharms)
// - David Celis (https://github.com/davidcelis)
extension Inflector {
    static var la: Inflector = {
        let locale = Locale(identifier: "la")
        let inflector = Inflector(locale: locale)

        plural: do {
            // First declension
            try inflector.addPluralizationRule(matching: #"a$"#, replacement: "ae")

            // Second declension
            try inflector.addPluralizationRule(matching: #"us$"#, replacement: "i")
            try inflector.addPluralizationRule(matching: #"(.*)([^aeiou])e(r)$"#, replacement: "$1$2$3es")
            try inflector.addPluralizationRule(matching: #"(.*)([aeiou])er$"#, replacement: "$1$2eri")
            try inflector.addPluralizationRule(matching: #"um$"#, replacement: "a")

            // Third declension is a catch-all given irregularity in nominative case

            // Fourth declension
            try inflector.addPluralizationRule(matching: #"u$"#, replacement: "ua")
            try inflector.addPluralizationRule(matching: #"(curs)(us)"#, replacement: "$1ūs")

            // Fifth declension
            try inflector.addPluralizationRule(matching: #"es$"#, replacement: "es")
        } catch {
            fatalError(error.localizedDescription)
        }

        singular: do {
            // First declension
            try inflector.addSingularizationRule(matching: #"ae$"#, replacement: "a")

            // Second declension
            try inflector.addSingularizationRule(matching: #"i$"#, replacement: "us")
            try inflector.addSingularizationRule(matching: #"(.*)([^aeiou])e(r)es$"#, replacement: "$1$2$3")
            try inflector.addSingularizationRule(matching: #"(.*)([aeiou])eri$"#, replacement: "$1$2er")
            try inflector.addSingularizationRule(matching: #"a$"#, replacement: "um")

            // Third declension is a catch-all given irregularity in nominative case

            // Fourth declension
            try inflector.addSingularizationRule(matching: #"ua$"#, replacement: "u")
            try inflector.addSingularizationRule(matching: #"(curs)ūs"#, replacement: "$1us")

            // Fifth declension
            try inflector.addSingularizationRule(matching: #"es$"#, replacement: "es")
        } catch {
            fatalError(error.localizedDescription)
        }

        irregular: do {
            // Third declension
            inflector.addIrregular(singular: "pater", plural: "patres")
            inflector.addIrregular(singular: "puer", plural: "pueri")
            inflector.addIrregular(singular: "nomen", plural: "nomina")
        }

        return inflector
    }()
}
