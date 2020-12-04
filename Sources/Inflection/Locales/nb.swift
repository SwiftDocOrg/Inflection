import struct Foundation.Locale

// Ported from https://github.com/davidcelis/inflections
//
// Credits:
// - Sarah Hodne (https://github.com/sarahhodne)
// - David Celis (https://github.com/davidcelis)
extension Inflector {
    static var nb: Inflector = {
        let locale = Locale(identifier: "nb")
        let inflector = Inflector(locale: locale)

        plural: do {
            try inflector.addPluralizationRule(matching: #"$"#, replacement: "er")
            try inflector.addPluralizationRule(matching: #"r$"#, replacement: "re")
            try inflector.addPluralizationRule(matching: #"e$"#, replacement: "er")
        } catch {
            fatalError(error.localizedDescription)
        }

        singular: do {
            try inflector.addSingularizationRule(matching: #"er$"#, replacement: "")
            try inflector.addSingularizationRule(matching: #"re$"#, replacement: "r")
            try inflector.addSingularizationRule(matching: #"pler$"#, replacement: "ple")
            try inflector.addSingularizationRule(matching: #"kker$"#, replacement: "kke")
        } catch {
            fatalError(error.localizedDescription)
        }

        irregular: do {
            inflector.addIrregular(singular: "konto", plural: "konti")
        }

        return inflector
    }()
}
