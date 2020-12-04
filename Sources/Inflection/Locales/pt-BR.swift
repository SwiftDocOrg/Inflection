import struct Foundation.Locale

// Ported from https://github.com/davidcelis/inflections
//
// Credits:
// - Nilton Vasques (https://github.com/niltonvasques)
// - David Celis (https://github.com/davidcelis)
extension Inflector {
    static var pt_BR: Inflector = {
        let locale = Locale(identifier: "en")
        let inflector = Inflector(locale: locale)

        plural: do {
            try inflector.addPluralizationRule(matching: #"$"#, replacement: "s")
            try inflector.addPluralizationRule(matching: #"(s)$"#, replacement: "$1")
            try inflector.addPluralizationRule(matching: #"(z|r)$"#, replacement: "$1es")
            try inflector.addPluralizationRule(matching: #"al$"#, replacement: "ais")
            try inflector.addPluralizationRule(matching: #"el$"#, replacement: "eis")
            try inflector.addPluralizationRule(matching: #"ol$"#, replacement: "ois")
            try inflector.addPluralizationRule(matching: #"ul$"#, replacement: "uis")
            try inflector.addPluralizationRule(matching: #"([^aeou])il$"#, replacement: "$1is")
            try inflector.addPluralizationRule(matching: #"m$"#, replacement: "ns")
            try inflector.addPluralizationRule(matching: #"^(japon|escoc|ingl|dinamarqu|fregu|portugu)ês$"#, replacement: "$1eses")
            try inflector.addPluralizationRule(matching: #"^(|g)ás$"#, replacement: "$1ases")
            try inflector.addPluralizationRule(matching: #"ão$"#, replacement: "ões")
            try inflector.addPluralizationRule(matching: #"^(irm|m)ão$"#, replacement: "$1ãos")
            try inflector.addPluralizationRule(matching: #"^(alem|c|p)ão$"#, replacement: "$1ães")
            try inflector.addPluralizationRule(matching: #"ao$"#, replacement: "oes")
            try inflector.addPluralizationRule(matching: #"^(irm|m)ao$"#, replacement: "$1aos")
            try inflector.addPluralizationRule(matching: #"^(alem|c|p)ao$"#, replacement: "$1aes")
        } catch {
            fatalError(error.localizedDescription)
        }

        singular: do {
            try inflector.addSingularizationRule(matching: #"([^ê])s$"#, replacement: "$1")
            try inflector.addSingularizationRule(matching: #"^(á|gá)s$"#, replacement: "$1s")
            try inflector.addSingularizationRule(matching: #"(r|z)es$"#, replacement: "$1")
            try inflector.addSingularizationRule(matching: #"([^p])ais$"#, replacement: "$1al")
            try inflector.addSingularizationRule(matching: #"éis$"#, replacement: "el")
            try inflector.addSingularizationRule(matching: #"eis$"#, replacement: "ei")
            try inflector.addSingularizationRule(matching: #"ois$"#, replacement: "ol")
            try inflector.addSingularizationRule(matching: #"uis$"#, replacement: "ul")
            try inflector.addSingularizationRule(matching: #"(r|t|f|v)is$"#, replacement: "$1il")
            try inflector.addSingularizationRule(matching: #"ns$"#, replacement: "m")
            try inflector.addSingularizationRule(matching: #"sses$"#, replacement: "sse")
            try inflector.addSingularizationRule(matching: #"^(.*[^s]s)es$"#, replacement: "$1")
            try inflector.addSingularizationRule(matching: #"(ãe|ão|õe)s$"#, replacement: "ão")
            try inflector.addSingularizationRule(matching: #"(ae|ao|oe)s$"#, replacement: "ao")
            try inflector.addSingularizationRule(matching: #"(japon|escoc|ingl|dinamarqu|fregu|portugu)eses$"#, replacement: "$1ês")
            try inflector.addSingularizationRule(matching: #"^(g|)ases$"#, replacement: "$1ás")
        } catch {
            fatalError(error.localizedDescription)
        }

        irregular: do {
            inflector.addIrregular(singular: "país", plural: "paises")
            inflector.addIrregular(singular: "árvore", plural: "árvores")
            inflector.addIrregular(singular: "cadáver", plural: "cadáveres")

            inflector.addUncountable("tórax")
            inflector.addUncountable("tênis")
            inflector.addUncountable("ônibus")
            inflector.addUncountable("lápis")
            inflector.addUncountable("fênix")
        }

        return inflector
    }()
}
