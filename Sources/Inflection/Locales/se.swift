import struct Foundation.Locale

// Ported from https://github.com/davidcelis/inflections
// Original rules by olabini (https://olabini.com/blog/2006/08/announcing-swedish-rails)
// Adapted by richardjohansson (https://github.com/mynewsdesk/swedish_pluralize)
//
// Credits:
// - Jo Potts (https://github.com/jopotts)
// - David Celis (https://github.com/davidcelis)
extension Inflector {
    static var se: Inflector = {
        let locale = Locale(identifier: "se")
        let inflector = Inflector(locale: locale)

        plural: do {
            // -er
            try inflector.addPluralizationRule(matching: #"([tmnslpr])$"#, replacement:  "$1er") //  produkt, produkter

            // -or
            try inflector.addPluralizationRule(matching: #"a$"#, replacement:  "or") //  flicka, flickor

            // -ar
            try inflector.addPluralizationRule(matching: #"e$"#, replacement:  "ar") //  pojke, pojkar
            try inflector.addPluralizationRule(matching: #"g$"#, replacement:  "gar")
            try inflector.addPluralizationRule(matching: #"l$"#, replacement:  "lar") //  bil, bilar
            try inflector.addPluralizationRule(matching: #"el$"#, replacement:  "lar") //  fågel, fåglar

            // -er
            try inflector.addPluralizationRule(matching: #"kel$"#, replacement:  "kler") //  muskel, muskler
            try inflector.addPluralizationRule(matching: #"tel$"#, replacement:  "tlar") //  titel, titlar

            // -r
            try inflector.addPluralizationRule(matching: #"de$"#, replacement:  "der") //  fiende, fiender

            // -n
            try inflector.addPluralizationRule(matching: #"le$"#, replacement:  "len") //  äpple, äpplen

             try inflector.addPluralizationRule(matching: #"ö$"#, replacement:  "ön") //  frö, frön
            try inflector.addPluralizationRule(matching: #"ok$"#, replacement:  "öcker") //  bok, böcker
            try inflector.addPluralizationRule(matching: #"um$"#, replacement:  "a") //  faktum, fakta
            try inflector.addPluralizationRule(matching: #"o$"#, replacement:  "or") //  sko, skor
            try inflector.addPluralizationRule(matching: #"s$"#, replacement:  "sor") //  ros, rosor
            try inflector.addPluralizationRule(matching: #"man$"#, replacement:  "män") //  man, män
            try inflector.addPluralizationRule(matching: #"mus$"#, replacement:  "möss") //  mus, möss
            try inflector.addPluralizationRule(matching: #"d$"#, replacement:  "den") //  huvud, huvuden
            try inflector.addPluralizationRule(matching: #"ad$"#, replacement:  "ader")
            try inflector.addPluralizationRule(matching: #"ne$"#, replacement:  "nen") //  vittne, vittnen
            try inflector.addPluralizationRule(matching: #"and$"#, replacement:  "änder") //  hand, händer
            try inflector.addPluralizationRule(matching: #"i$"#, replacement:  "ier") //  kategori, kategorier
            try inflector.addPluralizationRule(matching: #"mi$"#, replacement:  "min")
        } catch {
            fatalError(error.localizedDescription)
        }

        singular: do {
            // -er
            try inflector.addSingularizationRule(matching: #"([tmnslpr])er$"#, replacement:  "$1") //  produkt, produkter

            // -or
            try inflector.addSingularizationRule(matching: #"or$"#, replacement:  "a") //  flicka, flickor

            // -ar
            try inflector.addSingularizationRule(matching: #"mar$"#, replacement:  "me")
            try inflector.addSingularizationRule(matching: #"kar$"#, replacement:  "ke") //  pojke, pojkar
            try inflector.addSingularizationRule(matching: #"gar$"#, replacement:  "g")
            try inflector.addSingularizationRule(matching: #"lar$"#, replacement:  "l") //  bil, bilar
            try inflector.addSingularizationRule(matching: #"glar$"#, replacement:  "gel") //  fågel, fåglar

            // -er
            try inflector.addSingularizationRule(matching: #"ler$"#, replacement:  "el") //  muskel, muskler

            // -r
            try inflector.addSingularizationRule(matching: #"der$"#, replacement:  "de") //  fiende, fiender
            try inflector.addSingularizationRule(matching: #"ader$"#, replacement:  "ad")

            // -n
            try inflector.addSingularizationRule(matching: #"en$"#, replacement:  "e") //  vittne, vittnen

            try inflector.addSingularizationRule(matching: #"tlar$"#, replacement:  "tel") //  titel, titlar
            try inflector.addSingularizationRule(matching: #"ön$"#, replacement:  "ö") //  frö, frön
            try inflector.addSingularizationRule(matching: #"öcker$"#, replacement:  "ok") //  bok, böcker
            try inflector.addSingularizationRule(matching: #"a$"#, replacement:  "um") //  faktum, fakta
            try inflector.addSingularizationRule(matching: #"män$"#, replacement:  "man") //  man, män
            try inflector.addSingularizationRule(matching: #"möss$"#, replacement:  "mus") //  mus, möss
            try inflector.addSingularizationRule(matching: #"den$"#, replacement:  "d") //  huvud, huvuden
            try inflector.addSingularizationRule(matching: #"skor$"#, replacement:  "sko") //  sko, skor
            try inflector.addSingularizationRule(matching: #"änder$"#, replacement:  "and") //  hand, händer
            try inflector.addSingularizationRule(matching: #"sor$"#, replacement:  "s") //  ros, rosor
            try inflector.addSingularizationRule(matching: #"rier$"#, replacement:  "ri")
            try inflector.addSingularizationRule(matching: #"min$"#, replacement:  "mi")

        } catch {
            fatalError(error.localizedDescription)
        }

        irregular: do {
            inflector.addUncountable("hus")
            inflector.addUncountable("kar")
            inflector.addUncountable("träd")
            inflector.addUncountable("får")
            inflector.addUncountable("brev")
            inflector.addUncountable("namn")
            inflector.addUncountable("nummer")
            inflector.addUncountable("kön")
        }

        return inflector
    }()
}
