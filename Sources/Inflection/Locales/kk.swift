import struct Foundation.Locale

// Ported from https://github.com/davidcelis/inflections
//
// Credits:
// - Galymzhan (https://github.com/redcapital)
// - David Celis (https://github.com/davidcelis)
extension Inflector {
    static var kk: Inflector = {
        let locale = Locale(identifier: "kk")
        let inflector = Inflector(locale: locale)

        plural: do {
            try inflector.addPluralizationRule(matching: #"[кқпстфхчцшщбвгд]$"#, replacement: "$0тар")
            try inflector.addPluralizationRule(matching: #"[өүәіе][^оұаыөүәіе]*[кқпстфхчцшщбвгд]$"#, replacement: "$0тер")

            try inflector.addPluralizationRule(matching: #"[лмнңжз]$"#, replacement: "$0дар")
            try inflector.addPluralizationRule(matching: #"[өүәіе][^оұаыөүәіе]*[лмнңжз]$"#, replacement: "$0дер")
            
            try inflector.addPluralizationRule(matching: #"[оұаыөүәіеруй]$"#, replacement: "$0лар")
            try inflector.addPluralizationRule(matching: #"[өүәіе][^оұаыөүәіе]*[оұаыөүәіеруй]$"#, replacement: "$0лер")
        } catch {
            fatalError(error.localizedDescription)
        }

        singular: do {
            try inflector.addSingularizationRule(matching: #"[тдл][ае]р$"#, replacement: "")
        } catch {
            fatalError(error.localizedDescription)
        }
        
        return inflector
    }()
}
