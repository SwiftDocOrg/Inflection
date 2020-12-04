import struct Foundation.Locale

// Ported from https://github.com/davidcelis/inflections
//
// Credits:
// - Duccio Armenise (https://github.com/darmenise)
// - Ferdinando Traversa (https://github.com/ferdi2005)
// - David Celis (https://github.com/davidcelis)
extension Inflector {
    static var it: Inflector = {
        let locale = Locale(identifier: "it")
        let inflector = Inflector(locale: locale)

        plural: do {
            try inflector.addPluralizationRule(matching: #"[oei]$"#, replacement: "i")
            try inflector.addPluralizationRule(matching: #"a$"#, replacement: "e")
            try inflector.addPluralizationRule(matching: #"[àèìòù]$"#, replacement: "$0")
            try inflector.addPluralizationRule(matching: #"^.{2,3}$"#, replacement: "$0")
            try inflector.addPluralizationRule(matching: #"go$"#, replacement: "ghi")
        } catch {
            fatalError(error.localizedDescription)
        }

        singular: do {
            try inflector.addSingularizationRule(matching: #"i$"#, replacement: "o")
            try inflector.addSingularizationRule(matching: #"e$"#, replacement: "a")
            try inflector.addSingularizationRule(matching: #"^.{2,3}$"#, replacement: "$0")
            try inflector.addSingularizationRule(matching: #"ghi$"#, replacement: "go")
        } catch {
            fatalError(error.localizedDescription)
        }

        irregular: do {
            inflector.addIrregular(singular: "uomo", plural: "uomini")
            inflector.addIrregular(singular: "bue", plural: "buoi")
            inflector.addIrregular(singular: "dio", plural: "dèi")
            inflector.addIrregular(singular: "ampio", plural: "ampi")
            inflector.addIrregular(singular: "tempio", plural: "templi")
            inflector.addIrregular(singular: "mio", plural: "miei")
            inflector.addIrregular(singular: "tuo", plural: "tuoi")
            inflector.addIrregular(singular: "suo", plural: "suoi")
            inflector.addIrregular(singular: "belga", plural: "belgi")
            inflector.addIrregular(singular: "euripiga", plural: "euripigi")
            inflector.addIrregular(singular: "bello", plural: "belli")
            inflector.addIrregular(singular: "mano", plural: "mani")
            inflector.addIrregular(singular: "ala", plural: "ali")
            inflector.addIrregular(singular: "arma", plural: "armi")
            inflector.addIrregular(singular: "eco", plural: "echi")
            inflector.addIrregular(singular: "sinodo", plural: "sinodi")
            inflector.addIrregular(singular: "centinaio", plural: "centinaia")
            inflector.addIrregular(singular: "migliaio", plural: "migliaia")
            inflector.addIrregular(singular: "paio", plural: "paia")
            inflector.addIrregular(singular: "prelio", plural: "prelia")
            inflector.addIrregular(singular: "riso", plural: "risa")
            inflector.addIrregular(singular: "uovo", plural: "uova")
            inflector.addIrregular(singular: "dito", plural: "dita")
            inflector.addIrregular(singular: "carcere", plural: "carceri")
            inflector.addIrregular(singular: "oasi", plural: "oasi")
            inflector.addIrregular(singular: "mare", plural: "mari")
        }

        return inflector
    }()
}
