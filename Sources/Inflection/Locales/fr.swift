import struct Foundation.Locale

// Ported from https://github.com/davidcelis/inflections
//
// Credits:
// - Olivier Laviale (https://github.com/olvlvl)
// - David Celis (https://github.com/davidcelis)
extension Inflector {
    static var fr: Inflector = {
        let locale = Locale(identifier: "fr")
        let inflector = Inflector(locale: locale)

        plural: do {
            try inflector.addPluralizationRule(matching: #"$"#, replacement: "s")
            try inflector.addPluralizationRule(matching: #"(bijou|caillou|chou|genou|hibou|joujou|pou|au|eu|eau)$"#, replacement: "$1x")
            try inflector.addPluralizationRule(matching: #"(bleu|émeu|landau|lieu|pneu|sarrau)$"#, replacement: "$1s")
            try inflector.addPluralizationRule(matching: #"al$"#, replacement: "aux")
            try inflector.addPluralizationRule(matching: #"ail$"#, replacement: "ails")
            try inflector.addPluralizationRule(matching: #"(b|cor|ém|gemm|soupir|trav|vant|vitr)ail$"#, replacement: "$1aux")
            try inflector.addPluralizationRule(matching: #"(s|x|z)$"#, replacement: "$1")
        } catch {
            fatalError(error.localizedDescription)
        }

        singular: do {
            try inflector.addSingularizationRule(matching: #"s$"#, replacement: "")
            try inflector.addSingularizationRule(matching: #"(bijou|caillou|chou|genou|hibou|joujou|pou|au|eu|eau)x$"#, replacement: "$1")
            try inflector.addSingularizationRule(matching: #"(journ|chev)aux$"#, replacement: "$1al")
            try inflector.addSingularizationRule(matching: #"ails$"#, replacement: "ail")
            try inflector.addSingularizationRule(matching: #"(b|cor|ém|gemm|soupir|trav|vant|vitr)aux$"#, replacement: "$1ail")
        } catch {
            fatalError(error.localizedDescription)
        }

        irregular: do {
            inflector.addIrregular(singular: "monsieur", plural: "messieurs")
            inflector.addIrregular(singular: "madame", plural: "mesdames")
            inflector.addIrregular(singular: "mademoiselle", plural: "mesdemoiselles")
        }

        return inflector
    }()
}
