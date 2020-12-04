import struct Foundation.Locale

// Ported from https://github.com/davidcelis/inflections
//
// Credits:
// - David Rodríguez (https://github.com/deivid-rodriguez)
// - David Celis (https://github.com/davidcelis)
extension Inflector {
    static var es: Inflector = {
        let locale = Locale(identifier: "es")
        let inflector = Inflector(locale: locale)

        plural: do {
            try inflector.addPluralizationRule(matching: #"$"#, replacement: "s")
            try inflector.addPluralizationRule(matching: #"([^aeéiou])$"#, replacement: "$1es")
            try inflector.addPluralizationRule(matching: #"([aeiou]s)$"#, replacement: "$1")
            try inflector.addPluralizationRule(matching: #"z$"#, replacement: "ces")
            try inflector.addPluralizationRule(matching: #"á([sn])$"#, replacement: "a$1es")
            try inflector.addPluralizationRule(matching: #"é([sn])$"#, replacement: "e$1es")
            try inflector.addPluralizationRule(matching: #"í([sn])$"#, replacement: "i$1es")
            try inflector.addPluralizationRule(matching: #"ó([sn])$"#, replacement: "o$1es")
            try inflector.addPluralizationRule(matching: #"ú([sn])$"#, replacement: "u$1es")
        } catch {
            fatalError(error.localizedDescription)
        }

        singular: do {
            try inflector.addSingularizationRule(matching: "s$", replacement: "")
            try inflector.addSingularizationRule(matching: "es$", replacement: "")
            try inflector.addSingularizationRule(matching: "([sfj]e)s$", replacement: "$1")
            try inflector.addSingularizationRule(matching: "eses$", replacement: "és")
            try inflector.addSingularizationRule(matching: "ces$", replacement: "z")
            try inflector.addSingularizationRule(matching: "ones$", replacement: "ón")
        } catch {
            fatalError(error.localizedDescription)
        }

        irregular: do {
            inflector.addIrregular(singular: "el", plural: "los")
        }

        return inflector
    }()
}
