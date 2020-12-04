import struct Foundation.Locale

// Ported from https://github.com/davidcelis/inflections
//
// Credits:
// - ferhat elmas (https://github.com/sgharms)
// - David Celis (https://github.com/davidcelis)
extension Inflector {
    static var tr: Inflector = {
        let locale = Locale(identifier: "tr")
        let inflector = Inflector(locale: locale)

        pluralization: do {
            try inflector.addPluralizationRule(matching: #"([aoıu][^aoıueöiü]{0,6})$"#, replacement: "$1lar")
            try inflector.addPluralizationRule(matching: #"([eöiü][^aoıueöiü]{0,6})$"#, replacement: "$1ler")
        } catch {
            fatalError(error.localizedDescription)
        }

        singularization: do {
            try inflector.addSingularizationRule(matching: #"l[ae]r$"#, replacement: "")
        } catch {
            fatalError(error.localizedDescription)
        }

        irregular: do {
            inflector.addIrregular(singular: "ben", plural: "biz")
            inflector.addIrregular(singular: "sen", plural: "siz")
            inflector.addIrregular(singular: "o", plural: "onlar")
        }

        return inflector
    }()
}
