import struct Foundation.Locale

extension StringProtocol {

    /// Returns the string removing underscores and
    /// indicating word boundaries with a single capitalized letter.
    ///
    /// ```swift
    /// "employee_salary".camelized() // => "employeeSalary"
    /// "employee_salary".camelized(uppercasingFirstLetter: true) // => "EmployeeSalary"
    /// ```
    ///
    /// - Parameters:
    ///   - locale: The locale used to determine character case mapping.
    ///             `.current` by default.
    ///   - uppercasingFirstLetter: Whether to uppercase the first letter of the resulting string.
    ///                             `false` by default.
    public func camelized(
        with locale: Locale = .current,
        uppercasingFirstLetter: Bool = false
    ) -> String {
        let inflector = Inflector.default(for: locale) ?? Inflector(locale: locale)
        let string = "\(self)"

        return inflector.camelize(string, uppercasingFirstLetter: uppercasingFirstLetter)
    }

    /// Returns the string replacing each underscore (`_`) with a hypen / minus sign (`-`).
    ///
    /// ```swift
    /// "puni_puni".dasherized() // => "puni-puni"
    /// ```
    ///
    /// - Parameter locale: The locale used to determine character case mapping.
    ///                     `.current` by default.
    ///
    /// - SeeAlso: `underscored(with:)`
    public func dasherized(
        with locale: Locale = .current
    ) -> String {
        let inflector = Inflector.default(for: locale) ?? Inflector(locale: locale)
        let string = "\(self)"

        return inflector.dasherize(string)
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
    ///   - locale: The locale used to determine character case mapping.
    ///             `.current` by default.
    ///   - capitalizing: Whether to capitalize the resulting string.
    ///                   `true` by default.
    ///   - preservingIDSuffix: Whether to preserve an "_id" suffix, if present.
    ///                         `false` by default.
    ///
    /// - SeeAlso: `Inflector.addHumanizationRule(_:)`
    /// - SeeAlso: `Inflector.addAcronym(_:)`
    public func humanized(
        with locale: Locale = .current,
        capitalizing: Bool = true,
        preservingIDSuffix: Bool = false
    ) -> String {
        let inflector = Inflector.default(for: locale) ?? Inflector(locale: locale)
        let string = "\(self)"

        return inflector.humanize(string, capitalizing: capitalizing, preservingIDSuffix: preservingIDSuffix)
    }


    /// Returns a form of the string suitable to be used in a URL path component.
    ///
    /// ```swift
    /// "Donald E. Knuth".parameterized() // => "donald-e-knuth"
    /// ```
    ///
    /// - Parameters:
    ///   - locale: The locale used to determine character case mapping.
    ///             `.current` by default.
    ///   - separator: The character used to replace whitespace.
    ///   - preservingCase: Whether to preserve the case instead of lowercasing.
    ///                     `false` by default.
    public func parameterized(
        with locale: Locale = .current,
        separator: Character = "-",
        preservingCase: Bool = false
    ) -> String {
        let inflector = Inflector.default(for: locale) ?? Inflector(locale: locale)
        let string = "\(self)"

        return inflector.parameterize(string, separator: separator, preservingCase: preservingCase)
    }


    /// Returns the pluralized form of the string,
    /// or the original string if no pluralization rules match.
    ///
    /// ```swift
    /// "cow".pluralized() // => "cows"
    /// "octopus".pluralized() // => "octopi"
    /// "sheep".pluralized() // => "sheep"
    /// "dogs".pluralized() // => "dogs"
    /// "ragno".pluralized(with: Local(identifier: "it")) // => "ragni"
    /// ```
    ///
    /// - Parameter locale: The locale used to determine character case mapping.
    ///                     `.current` by default.
    ///
    /// - SeeAlso: `Inflector.addPluralizationRule(_:)`
    /// - SeeAlso: `Inflector.addIrregular(singular:plural:)`
    /// - SeeAlso: `Inflector.addUncountable(_:)`
    public func pluralized(with locale: Locale = .current) -> String {
        let word = "\(self)"
        return Inflector.default(for: locale)?.pluralize(word) ?? word
    }

    /// Returns the pluralized form of the string,
    /// or the original string if no pluralization rules match.
    ///
    /// ```swift
    /// "cows".singularized() // => "cow"
    /// "octopi".singularized() // => "octopus"
    /// "sheep".singularized() // => "sheep"
    /// "dog".singularized() // => "dog"
    /// "ragni".singularized(with: Local(identifier: "it")) // => "ragno"
    /// ```
    ///
    /// - Parameter locale: The locale used to determine character case mapping.
    ///                     `.current` by default.
    ///
    /// - SeeAlso: `Inflector.addSingularizationRule(_:)`
    /// - SeeAlso: `Inflector.addIrregular(singular:plural:)`
    /// - SeeAlso: `Inflector.addUncountable(_:)`
    public func singularized(with locale: Locale = .current) -> String {
        let word = "\(self)"
        return Inflector.default(for: locale)?.singularize(word) ?? word
    }


    /// Returns a titlecase form of the string
    /// by capitalizing and replacing certain characters.
    ///
    /// ```swift
    /// "raiders_of_the_lost_ark".titleize() // => "Raiders Of The Lost Ark"
    /// "x-men: the last stand".titleize() // => "X-Men: The Last Stand"
    /// "TheManWithoutAPast".titleize() // => "The Man Without A Past"
    /// ```
    ///
    /// - Parameters:
    ///   - locale: The locale used to determine character case mapping.
    ///             `.current` by default.
    ///   - preservingIDSuffix: Whether to preserve an "_id" suffix, if present.
    ///                         `false` by default.
    public func titleized(
        with locale: Locale = .current,
        preservingIDSuffix: Bool = false
    ) -> String {
        let inflector = Inflector.default(for: locale) ?? Inflector(locale: locale)
        let string = "\(self)"

        return inflector.titleize(string, preservingIDSuffix: preservingIDSuffix)
    }


    /// Returns the string replacing each hypen / minus signs (`-`) with an underscore (`_`).
    ///
    /// ```swift
    /// "puni-puni".underscored() // => "puni_puni"
    /// ```
    ///
    /// - Parameter locale: The locale used to determine character case mapping.
    ///                     `.current` by default.
    ///
    /// - SeeAlso: `dasherized(with:)`
    public func underscored(
        with locale: Locale = .current
    ) -> String {
        let inflector = Inflector.default(for: locale) ?? Inflector(locale: locale)
        let string = "\(self)"

        return inflector.underscore(string)
    }
}
