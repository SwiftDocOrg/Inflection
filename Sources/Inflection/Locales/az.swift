import struct Foundation.Locale

// Ported from https://github.com/davidcelis/inflections
//
// Credits:
// - @marmeladze (https://github.com/marmeladze)
// - David Celis (https://github.com/davidcelis)
extension Inflector {
    static var az: Inflector = {
        let locale = Locale(identifier: "az")
        let inflector = Inflector(locale: locale)

        plural: do {
            try inflector.addPluralizationRule(matching: #"([aıou][^aeəıiouöü]{0,6})$"#, replacement: #"$1lar"#)
            try inflector.addPluralizationRule(matching: #"([eəiöü][^aeəıiouöü]{0,6})$"#, replacement: #"$1lər"#)
        } catch {
            fatalError(error.localizedDescription)
        }

        singular: do {
            try inflector.addSingularizationRule(matching: #"l[aə]r$"#, replacement: "")
        } catch {
            fatalError(error.localizedDescription)
        }

        irregular: do {
            inflector.addIrregular(singular: "mən", plural: "biz")
            inflector.addIrregular(singular: "sən", plural: "siz")
            inflector.addIrregular(singular: "o", plural: "onlar")

            inflector.addUncountable("camaat")
            inflector.addUncountable("əhali")
        }

        return inflector
    }()
}
