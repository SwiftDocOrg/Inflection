import Foundation

/// A string inflector.
public final class Inflector {

    /// An inflection rule.
    public typealias Rule = (String) -> String?

    /// The locale used to determine character case mapping.
    public let locale: Locale

    /// Whether inflection rules based on regular expressions are case-sensitive.
    public let caseSensitive: Bool

    /// Whether inflection rules based on regular expressions are normalization-sensitive.
    public let normalizationSensitive: Bool

    private var singularizationRules: [Rule] = []
    private var pluralizationRules: [Rule] = []

    private var irregularPluralsBySingular: [String: String] = [:]
    private var irregularSingularsByPlural: [String: String] = [:]

    private var uncountables: Set<String> = []

    private var humanizationRules: [Rule] = []

    private var acronyms: Set<String> = []

    /// The default string inflector.
    public static let `default`: Inflector = en

    /// The default string inflector for the specified locale, if any.
    ///
    /// - Warning: The pluralization rules for default inflectors other than English (`en`)
    ///            haven't been thoroughly tested and may produce incorrect results.
    public class func `default`(for locale: Locale) -> Inflector? {
        switch (locale.languageCode?.lowercased(), locale.regionCode?.uppercased()) {
        case ("az", _): return az
        case ("en", _): return en
        case ("es", _): return es
        case ("fr", _): return fr
        case ("it", _): return it
        case ("kk", _): return kk
        case ("la", _): return la
        case ("nb", _): return nb
        case ("pt", "BR"): return pt_BR
        case ("se", _): return se
        case ("tr", _): return tr
        default:
            return nil
        }
    }


    /// Creates a new inflector.
    ///
    /// - Parameters:
    ///   - locale: The locale used to determine character case mapping.
    ///   - caseSensitive: Whether inflection rules based on regular expressions are case-sensitive.
    ///                    `false` by default.
    ///   - normalizationSensitive: Whether inflection rules based on regular expressions
    ///                             are normalization-sensitive.
    ///                             `false` by default.b
    public init(
        locale: Locale = .current,
        caseSensitive: Bool = false,
        normalizationSensitive: Bool = false
    ) {
        self.locale = locale
        self.caseSensitive = caseSensitive
        self.normalizationSensitive = normalizationSensitive
    }


    /// Adds a singularization rule using a regular expression
    /// with the provided pattern, replacement template, and options.
    ///
    /// - Parameters:
    ///   - pattern: The regular expression pattern.
    ///   - template: The replacement template for matches.
    ///   - options: Regular expression options.
    /// - Throws: An error if a regular expression couldn't be constructed.
    public func addSingularizationRule(
        matching pattern: String,
        replacement template: String,
        options: NSRegularExpression.Options? = nil
    ) throws {
        let options = options ?? (caseSensitive ? [] : [.caseInsensitive])
        let regularExpression = try NSRegularExpression(pattern: pattern, options: options)
        return addSingularizationRule({ regularExpression.replacingMatch(in: $0, with: template) })
    }

    /// Adds a pluralization rule.
    /// - Parameter rule: The pluralization rule.
    public func addPluralizationRule(_ rule: @escaping Rule) {
        pluralizationRules.append(rule)
    }

    /// Adds a pluralization rule using a regular expression
    /// with the provided pattern, replacement template, and options.
    ///
    /// - Parameters:
    ///   - pattern: The regular expression pattern.
    ///   - template: The replacement template for matches.
    ///   - options: Regular expression options.
    /// - Throws: An error if a regular expression couldn't be constructed.
    public func addPluralizationRule(
        matching pattern: String,
        replacement template: String,
        options: NSRegularExpression.Options? = nil
    ) throws {
        let options = options ?? (caseSensitive ? [] : [.caseInsensitive])
        let regularExpression = try NSRegularExpression(pattern: pattern, options: options)
        addPluralizationRule({ regularExpression.replacingMatch(in: $0, with: template) })
    }


    /// Adds a humanization rule.
    /// - Parameter rule: The humanization rule.
    public func addHumanizationRule(_ rule: @escaping Rule) {
        humanizationRules.append(rule)
    }

    /// Adds a humanization rule with a given string and replacement.
    ///
    /// - Parameters:
    ///   - original: The string to be replaced.
    ///   - replacement: The replacement string.
    public func addHumanizationRule(
        replacing original: String,
        with replacement: String
    ) {
        humanizationRules.append({ $0 == original ? replacement : nil })
    }


    /// Adds an irregular pluralization / singularization rule.
    /// 
    /// - Parameters:
    ///   - singular: The singular form.
    ///   - plural: The plural form.
    ///
    /// - Returns: A tuple with two members.
    ///            The first is a `Bool` indicating whether the rule was inserted.
    ///            The second is a tuple containing the inserted singular and plural forms.
    @discardableResult
    public func addIrregular(singular: String, plural: String) -> (inserted: Bool, memberAfterInsert: (singular: String, plural: String)) {
        let (singular, plural) = (normalize(singular), normalize(plural))

        let inserted = irregularPluralsBySingular[singular] != nil || irregularSingularsByPlural[plural] != nil

        irregularPluralsBySingular[singular] = plural
        irregularSingularsByPlural[plural] = singular

        return (inserted, (singular, plural))
    }

    /// Adds an irregular pluralization / singularization rule
    /// for words that don't have a distinct plural or singular form.
    ///
    /// - Parameter word: The uncountable word.
    ///
    /// - Returns: A tuple with two members.
    ///            The first is a `Bool` indicating whether the rule was inserted.
    ///            The second is a tuple containing the inserted word.
    @discardableResult
    public func addUncountable(_ word: String) -> (inserted: Bool, memberAfterInsert: (String)) {
        let word = normalize(word)
        let (inserted, _) = uncountables.insert(normalize(word))

        return (inserted, word)
    }

    /// Adds an acronym.
    ///
    /// - Parameter word: The acronym.
    ///
    /// - Returns: A tuple with two members.
    ///            The first is a `Bool` indicating whether the rule was inserted.
    ///            The second is a tuple containing the inserted word.
    @discardableResult
    public func addAcronym(_ word: String) -> (inserted: Bool, memberAfterInsert: (String)) {
        let word = word.precomposedStringWithCanonicalMapping
        let (inserted, _) = acronyms.insert(normalize(word))

        return (inserted, word)
    }

    // MARK: -

    /// Returns the string removing underscores and
    /// indicating word boundaries with a single capitalized letter.
    ///
    /// ```swift
    /// Inflector.default.camlize("employee_salary") // => "employeeSalary"
    /// Inflector.default.camlize("employee_salary, uppercasingFirstLetter: true) // => "EmployeeSalary"
    /// ```
    ///
    /// - Parameters:
    ///   - term: The string to be camel-cased.
    ///   - uppercasingFirstLetter: Whether to uppercase the first letter of the resulting string.
    ///                             `false` by default.
    public func camelize(_ term: String, uppercasingFirstLetter: Bool = true) -> String {
        var term = term

        var startIndex = term.startIndex
        if uppercasingFirstLetter {
            for acronym in acronyms {
                if term.hasPrefix(acronym) {
                    startIndex = term.index(startIndex, offsetBy: acronym.count)
                }
            }
        }

        do {
            let pattern = #"""
            ^(?:
                \#(acronyms.isEmpty ? "(?=a)b" : acronyms.joined(separator: "|"))
                (?=\b|[A-Z_])
                |
                \w
            )/
            """#

            let regularExpression = try NSRegularExpression(pattern: pattern, options: [.allowCommentsAndWhitespace])
            regularExpression.enumerateMatches(in: term, options: [], range: NSRange(startIndex..<term.endIndex, in: term)) { (result, _, _) in
                guard let result = result,
                      let resultRange = Range(result.range, in: term)
                else { return }

                term.replaceSubrange(resultRange, with: term[resultRange].lowercased(with: self.locale))
            }
        } catch {
            fatalError(error.localizedDescription)
        }

        do {
            let pattern = #"(?:_|(\/))([a-z\d]*)"#

            let regularExpression = try NSRegularExpression(pattern: pattern, options: [.allowCommentsAndWhitespace, .caseInsensitive])

            var offset = 0
            regularExpression.enumerateMatches(in: term, options: [], range: NSRange(term.startIndex..<term.endIndex, in: term)) { (result, _, _) in
                guard let result = result,
                      let resultRange = Range(result.range, in: term),
                      let candidateRange = Range(result.range(at: 2), in: term)
                else { return }

                let candidate = String(term[candidateRange])

                let replacement = self.acronyms.contains(candidate) ? candidate : candidate.capitalized(with: self.locale)
                if result.range(at: 1).location != NSNotFound {
                    defer { offset += 1 }
                    term.replaceSubrange(resultRange.offset(by: offset, in: term), with: "/" + replacement)
                } else {
                    term.replaceSubrange(resultRange.offset(by: offset, in: term), with: replacement)
                }
            }
        } catch {
            fatalError(error.localizedDescription)
        }

        term = term.replacingOccurrences(of: "/", with: "::")

        if uppercasingFirstLetter, let firstLetter = term.first {
            term.replaceSubrange(...term.startIndex, with: "\(firstLetter)".uppercased(with: locale))
        }

        return term
    }

    /// Returns the string replacing each underscore (`_`) with a hypen / minus sign (`-`).
    ///
    /// ```swift
    /// Inflector.dasherize("puni_puni") // => "puni-puni"
    /// ```
    ///
    /// - Parameter term: The string to be dasherized.
    ///
    /// - SeeAlso: `underscore(_:)`
    public func dasherize(_ term: String) -> String {
        term.replacingOccurrences(of: "_", with: "-")
    }

    /// Returns a form of the string suitable for display to users.
    ///
    /// This function performs the following transformations:
    ///
    /// - Applies human inflection rules to the argument.
    /// - Deletes leading underscores, if any.
    /// - Removes an "_id" suffix, if present.
    /// - Replaces underscores with spaces, if any.
    /// - Downcases all words except acronyms.
    /// - Capitalizes the first word.
    ///
    /// - Parameters:
    ///   - term: The string to be humanized.
    ///   - capitalizing: Whether to capitalize the resulting string.
    ///                   `true` by default.
    ///   - preservingIDSuffix: Whether to preserve an "_id" suffix, if present.
    ///                         `false` by default.
    ///
    /// - SeeAlso: `Inflector.addHumanizationRule(_:)`
    /// - SeeAlso: `Inflector.addAcronym(_:)`
    public func humanize(
        _ term: String,
        capitalizing: Bool = true,
        preservingIDSuffix: Bool = false
    ) -> String {
        if let humanized = humanizationRules.lazy.reversed().compactMap({ rule in rule(term) }).first {
            return humanized
        }

        var term = term

        guard let index = term.firstIndex(where: { $0 != "_" }) else { return "" }
        term.removeSubrange(..<index)

        if !preservingIDSuffix, term.hasSuffix("_id") {
            term.removeLast(3)
        }

        return term.split(omittingEmptySubsequences: true,
                          whereSeparator: { !$0.isLetter && !$0.isNumber && $0 != ":" })
                   .map { component in
                       let candidate = component.uppercased()
                       if self.acronyms.contains(candidate) {
                           return candidate
                       } else if capitalizing {
                           return component.capitalized(with: self.locale)
                       } else {
                           return component.lowercased()
                       }
                   }
                   .joined(separator: " ")

    }

    /// Returns a form of the string suitable to be used in a URL path component.
    ///
    /// ```swift
    /// Inflector.default.parameterize("Donald E. Knuth") // => "donald-e-knuth"
    /// ```
    ///
    /// - Parameters:
    ///   - string: The string to be parameterized.
    ///   - separator: The character used to replace whitespace.
    ///                A hyphen-minus sign (`"-"`) by default.
    ///   - preservingCase: Whether to preserve the case instead of lowercasing.
    ///                     `false` by default.
    public func parameterize(
        _ string: String,
        separator: Character = "-",
        preservingCase: Bool = false
    ) -> String {
        var string = transliterate(string)
                        .split(omittingEmptySubsequences: true,
                            whereSeparator: {
                                !$0.isLetter && !$0.isNumber && ($0 == separator || ($0 != "-" && $0 != "_"))
                            })
                        .joined(separator: "\(separator)")

        if !preservingCase {
            string = string.lowercased()
        }

        return string
    }

    /// Returns the pluralized form of the string,
    /// or the original string if no pluralization rules match.
    ///
    /// ```swift
    /// Inflector.default.pluralize("cow") // => "cows"
    /// Inflector.default.pluralize("octopus") // => "octopi"
    /// Inflector.default.pluralize("sheep") // => "sheep"
    /// Inflector.default.pluralize("dogs") // => "dogs"
    /// ```
    ///
    /// - Parameter word: The word to pluralize.
    ///
    /// - SeeAlso: `Inflector.addPluralizationRule(_:)`
    /// - SeeAlso: `Inflector.addIrregular(singular:plural:)`
    /// - SeeAlso: `Inflector.addUncountable(_:)`
    public func pluralize(_ word: String) -> String {
        if uncountables.contains(normalize(word)) {
            return word
        } else if let plural = irregularPluralsBySingular[word] {
            return plural
        } else {
            return pluralizationRules.lazy.reversed().compactMap { rule in rule(word) }.first ?? word
        }
    }

    /// Returns the pluralized form of the string,
    /// or the original string if no pluralization rules match.
    ///
    /// ```swift
    /// Inflector.default.singularize("cows") // => "cow"
    /// Inflector.default.singularize("octopi") // => "octopus"
    /// Inflector.default.singularize("sheep") // => "sheep"
    /// Inflector.default.singularize("dog") // => "dog"
    /// ```
    ///
    /// - Parameter word: The word to singularize.
    ///
    /// - SeeAlso: `Inflector.addSingularizationRule(_:)`
    /// - SeeAlso: `Inflector.addIrregular(singular:plural:)`
    /// - SeeAlso: `Inflector.addUncountable(_:)`
    public func singularize(_ word: String) -> String {
        if uncountables.contains(normalize(word)) {
            return word
        } else if let singular = irregularSingularsByPlural[word] {
            return singular
        } else {
            return singularizationRules.lazy.reversed().compactMap { rule in rule(word) }.first ?? word
        }
    }

    // MARK: -

    /// Adds a singularization rule.
    /// - Parameter rule: The singularization rule.
    public func addSingularizationRule(_ rule: @escaping Rule) {
        singularizationRules.append(rule)
    }

    /// Returns a titlecase form of the string
    /// by capitalizing and replacing certain characters.
    ///
    /// ```swift
    /// Inflector.default.titleize("raiders_of_the_lost_ark") // => "Raiders Of The Lost Ark"
    /// Inflector.default.titleize("x-men: the last stand") // => "X-Men: The Last Stand"
    /// Inflector.default.titleize("TheManWithoutAPast") // => "The Man Without A Past"
    /// ```
    ///
    /// - Parameters:
    ///   - term: The string to be titleized.
    ///   - preservingIDSuffix: Whether to preserve an "_id" suffix, if present.
    ///                         `false` by default.
    public func titleize(
        _ term: String,
        preservingIDSuffix: Bool = false
    ) -> String {
        humanize(underscore(term), preservingIDSuffix: preservingIDSuffix)
    }

    public func underscore(_ term: String) -> String {
        var term = term.replacingOccurrences(of: "::", with: "/")
        guard !term.allSatisfy({ !$0.isUppercase && $0 != "-" }) else { return term }

        do {
            let pattern = #"""
            (?:
                (?<=([A-Za-z\d]))
                |
                \b
            )
            (\#(acronyms.isEmpty ? "(?=a)b" : acronyms.joined(separator: "|")))
            (?=\b|[^a-z])
            """#

            let regularExpression = try NSRegularExpression(pattern: pattern, options: [.allowCommentsAndWhitespace])

            var offset = 0
            regularExpression.enumerateMatches(in: term, options: [], range: NSRange(term.startIndex..<term.endIndex, in: term)) { (result, _, _) in
                guard let result = result,
                      let resultRange = Range(result.range, in: term),
                      let acronymRange = Range(result.range(at: 2), in: term)
                else { return }

                let replacement = term[acronymRange.offset(by: offset, in: term)]
                if result.range(at: 1).location != NSNotFound {
                    defer { offset += 1 }
                    term.replaceSubrange(resultRange.offset(by: offset, in: term), with: "_" + replacement)
                } else {
                    term.replaceSubrange(resultRange.offset(by: offset, in: term), with: replacement)
                }
            }
        } catch {
            fatalError(error.localizedDescription)
        }

        do {
            let pattern = #"([A-Z\d]+)([A-Z][a-z])"#
            let regularExpression = try NSRegularExpression(pattern: pattern, options: [])
            term = regularExpression.replacingMatches(in: term, with: "$1_$2")
        } catch {
            fatalError(error.localizedDescription)
        }

        do {
            let pattern = #"([a-z\d])([A-Z])"#
            let regularExpression = try NSRegularExpression(pattern: pattern, options: [])
            term = regularExpression.replacingMatches(in: term, with: "$1_$2")
        } catch {
            fatalError(error.localizedDescription)
        }

        term = term.replacingOccurrences(of: "-", with: "_")

        return term.lowercased()
    }

    private func normalize(_ string: String) -> String {
        var string = string
        if caseSensitive {
            string = string.lowercased(with: locale)
        }

        if normalizationSensitive {
            string = string.precomposedStringWithCanonicalMapping
        }

        return string
    }

    private func transliterate(_ string: String) -> String {
        string.applyingTransform(.toLatin, reverse: false)?.folding(options: .diacriticInsensitive, locale: locale) ?? ""
    }
}

fileprivate extension Range where Bound == String.Index {
    func offset(by distance: Int, in string: String) -> Range {
        let lower = string.index(lowerBound, offsetBy: distance, limitedBy: string.endIndex)
        let upper = string.index(upperBound, offsetBy: distance, limitedBy: string.endIndex)

        return Range(uncheckedBounds: (lower ?? string.endIndex, upper ?? string.endIndex))
    }
}

fileprivate extension NSRegularExpression {
    func replacingMatch(in string: String, range: Range<String.Index>? = nil, with template: String) -> String? {
        let mutableString = NSMutableString(string: string)
        let range = NSRange(range ?? string.startIndex..<string.endIndex, in: string)
        guard replaceMatches(in: mutableString, options: [], range: range, withTemplate: template) == 1 else { return nil }
        
        return mutableString as String
    }

    func replacingMatches(in string: String, range: Range<String.Index>? = nil, with template: String) -> String {
        let mutableString = NSMutableString(string: string)
        let range = NSRange(range ?? string.startIndex..<string.endIndex, in: string)
        _ = replaceMatches(in: mutableString, options: [], range: range, withTemplate: template)

        return mutableString as String
    }
}
