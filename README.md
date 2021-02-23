# Inflection

![CI][ci badge]
[![Documentation][documentation badge]][documentation]

A Swift port of the string inflection functionality from
[Rails ActiveSupport](https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/inflections.rb),
with localizations for the following locales adapted from [Inflections by @davidcelis](https://github.com/davidcelis/inflections):

- Azerbaijani (`az`)
- English (`en`)
- Spanish (`es`)
- French (`fr`)
- Italian (`it`)
- Kazakh (`kk`)
- Latin (`la`)
- Norwegian Bokmål (`nb`)
- Brazilian Portuguese (`pt-BR`)
- Swedish (`se`)
- Turkish (`tr`)

## Requirements

- Swift 5.3+

## Usage

```swift
import Inflection

// Rails-style inflectors

"employee_salary".camelized() // "employeeSalary"
"employee_salary".camelized(uppercasingFirstLetter: true) // "EmployeeSalary"

"employee_salary".dasherized() // "employee-salary"

"customer_support".humanized() // "Customer Support"
"parent_id".humanized() // "Parent"

"Donald E. Knuth".parameterized() // "donald-e-knuth"
"^très|Jolie-- ".parameterized() // "tres-jolie"

"guardians_of_the_galaxy".titleized() // "Guardians Of The Galaxy"

"HTTPRequest".underscored() // "http_request"

// Pluralization and singularization

for singular in ["person", "tomato", "matrix", "octopus", "fish"] {
    let plural = singular.pluralized()
    print("\(singular) → \(plural) → \(plural.singularized())")
}
/*
Prints:
person → people → person
tomato → tomatoes → tomato
matrix → matrices → matrix
octopus → octopi → octopus
fish → fish → fish
*/

// Pass a `locale` argument to pluralize in other languages:

let 🇮🇹 = Locale(identifier: "it-IT")
let singular = "ragno" // 🕷
let plural = singular.pluralized(with: 🇮🇹) // 🕷🕷🕷
print("\(singular) → \(plural) → \(plural.singularized())")
/*
Prints:
ragno → ragni → ragno
*/

// You can also add pluralization rules,
// including irregular and uncountable words:

let inflector = Inflector.default
inflector.addPluralRule(#"^i(Pod|Pad)( Mini)?$"#, replacement: #"i$1s$2"#)
inflector.addIrregular(singular: "lol", plural: "lolz")
inflector.addUncountable("Herokai")

for singular in ["iPad Mini", "lol", "Herokai"] {
    print("\(singular) → \(singular.pluralized)")
}
/*
Prints:
iPad Mini → iPads Mini
lol → lolz
Herokai → Herokai
*/
```

## Installation

### Swift Package Manager

Add the Inflection package to your target dependencies in `Package.swift`:

```swift
// swift-tools-version:5.3
import PackageDescription

let package = Package(
  name: "YourProject",
  dependencies: [
    .package(
        url: "https://github.com/SwiftDoc/Inflection",
        from: "0.0.1"
    ),
  ]
)
```

Then run the `swift build` command to build your project.

## License

MIT

## Contact

Mattt ([@mattt](https://twitter.com/mattt))

[ci badge]: https://github.com/SwiftDocOrg/Inflection/workflows/CI/badge.svg
[documentation badge]: https://github.com/SwiftDocOrg/Inflection/workflows/Documentation/badge.svg
[documentation]: https://github.com/SwiftDocOrg/Inflection/wiki
