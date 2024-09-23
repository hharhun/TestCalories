import Foundation
import RswiftResources

private class BundleFinder {}
public let R = _R(bundle: Bundle(for: BundleFinder.self))

public struct _R {
    public let bundle: Foundation.Bundle
    public init(bundle: Foundation.Bundle) {
        self.bundle = bundle
    }

    public var string: string { .init(bundle: bundle, preferredLanguages: nil, locale: nil) }
    public var color: color { .init(bundle: bundle) }
    public var image: image { .init(bundle: bundle) }

    public func string(bundle: Foundation.Bundle) -> string {
        .init(bundle: bundle, preferredLanguages: nil, locale: nil)
    }

    public func string(locale: Foundation.Locale) -> string {
        .init(bundle: bundle, preferredLanguages: nil, locale: locale)
    }

    public func string(preferredLanguages: [String], locale: Locale? = nil) -> string {
        .init(bundle: bundle, preferredLanguages: preferredLanguages, locale: locale)
    }

    public func color(bundle: Foundation.Bundle) -> color {
        .init(bundle: bundle)
    }

    public func image(bundle: Foundation.Bundle) -> image {
        .init(bundle: bundle)
    }

    public func validate() throws {}

    public struct project {
        public let developmentRegion = "en"
    }

    /// This `_R.string` struct is generated, and contains static references to 1 localization tables.
    public struct string {
        public let bundle: Foundation.Bundle
        public let preferredLanguages: [String]?
        public let locale: Locale?
        public init(bundle: Foundation.Bundle, preferredLanguages: [String]? = nil, locale: Locale? = nil) {
            self.bundle = bundle
            self.preferredLanguages = preferredLanguages
            self.locale = locale
        }

        public var localizable: localizable { .init(source: .init(bundle: bundle, tableName: "Localizable", preferredLanguages: preferredLanguages, locale: locale)) }

        public func localizable(preferredLanguages: [String]) -> localizable {
            .init(source: .init(bundle: bundle, tableName: "Localizable", preferredLanguages: preferredLanguages, locale: locale))
        }

        /// This `_R.string.localizable` struct is generated, and contains static references to 12 localization keys.
        public struct localizable {
            public let source: RswiftResources.StringResource.Source
            public init(source: RswiftResources.StringResource.Source) {
                self.source = source
            }

            /// en translation: Cancel
            ///
            /// Key: Common.cancel
            ///
            /// Locales: en
            public var commonCancel: RswiftResources.StringResource { .init(key: "Common.cancel", tableName: "Localizable", source: source, developmentValue: "Cancel", comment: nil) }

            /// en translation: Error
            ///
            /// Key: Common.error
            ///
            /// Locales: en
            public var commonError: RswiftResources.StringResource { .init(key: "Common.error", tableName: "Localizable", source: source, developmentValue: "Error", comment: nil) }

            /// en translation: No
            ///
            /// Key: Common.no
            ///
            /// Locales: en
            public var commonNo: RswiftResources.StringResource { .init(key: "Common.no", tableName: "Localizable", source: source, developmentValue: "No", comment: nil) }

            /// en translation: Ok
            ///
            /// Key: Common.ok
            ///
            /// Locales: en
            public var commonOk: RswiftResources.StringResource { .init(key: "Common.ok", tableName: "Localizable", source: source, developmentValue: "Ok", comment: nil) }

            /// en translation: Yes
            ///
            /// Key: Common.yes
            ///
            /// Locales: en
            public var commonYes: RswiftResources.StringResource { .init(key: "Common.yes", tableName: "Localizable", source: source, developmentValue: "Yes", comment: nil) }

            /// en translation: Unknown error
            ///
            /// Key: Errors.unknown
            ///
            /// Locales: en
            public var errorsUnknown: RswiftResources.StringResource { .init(key: "Errors.unknown", tableName: "Localizable", source: source, developmentValue: "Unknown error", comment: nil) }

            /// en translation: Brand name
            ///
            /// Key: ProductsList.brandName
            ///
            /// Locales: en
            public var productsListBrandName: RswiftResources.StringResource { .init(key: "ProductsList.brandName", tableName: "Localizable", source: source, developmentValue: "Brand name", comment: nil) }

            /// en translation: Category
            ///
            /// Key: ProductsList.category
            ///
            /// Locales: en
            public var productsListCategory: RswiftResources.StringResource { .init(key: "ProductsList.category", tableName: "Localizable", source: source, developmentValue: "Category", comment: nil) }

            /// en translation: Sorry, list is empty
            ///
            /// Key: ProductsList.listIsEmpty
            ///
            /// Locales: en
            public var productsListListIsEmpty: RswiftResources.StringResource { .init(key: "ProductsList.listIsEmpty", tableName: "Localizable", source: source, developmentValue: "Sorry, list is empty", comment: nil) }

            /// en translation: No name
            ///
            /// Key: ProductsList.noName
            ///
            /// Locales: en
            public var productsListNoName: RswiftResources.StringResource { .init(key: "ProductsList.noName", tableName: "Localizable", source: source, developmentValue: "No name", comment: nil) }

            /// en translation: Search
            ///
            /// Key: ProductsList.search
            ///
            /// Locales: en
            public var productsListSearch: RswiftResources.StringResource { .init(key: "ProductsList.search", tableName: "Localizable", source: source, developmentValue: "Search", comment: nil) }

            /// en translation: Breakfast
            ///
            /// Key: ProductsList.title
            ///
            /// Locales: en
            public var productsListTitle: RswiftResources.StringResource { .init(key: "ProductsList.title", tableName: "Localizable", source: source, developmentValue: "Breakfast", comment: nil) }
        }
    }

    /// This `_R.color` struct is generated, and contains static references to 9 colors.
    public struct color {
        public let bundle: Foundation.Bundle
        public init(bundle: Foundation.Bundle) {
            self.bundle = bundle
        }

        /// Color `c2A2A2A`.
        public var c2A2A2A: RswiftResources.ColorResource { .init(name: "c2A2A2A", path: [], bundle: bundle) }

        /// Color `c351F0E`.
        public var c351F0E: RswiftResources.ColorResource { .init(name: "c351F0E", path: [], bundle: bundle) }

        /// Color `c645F5A`.
        public var c645F5A: RswiftResources.ColorResource { .init(name: "c645F5A", path: [], bundle: bundle) }

        /// Color `cA8A8A8`.
        public var cA8A8A8: RswiftResources.ColorResource { .init(name: "cA8A8A8", path: [], bundle: bundle) }

        /// Color `cAF927C`.
        public var cAF927C: RswiftResources.ColorResource { .init(name: "cAF927C", path: [], bundle: bundle) }

        /// Color `cF8EAE0`.
        public var cF8EAE0: RswiftResources.ColorResource { .init(name: "cF8EAE0", path: [], bundle: bundle) }

        /// Color `cFFF9F5`.
        public var cFFF9F5: RswiftResources.ColorResource { .init(name: "cFFF9F5", path: [], bundle: bundle) }

        /// Color `cFFFAF7`.
        public var cFFFAF7: RswiftResources.ColorResource { .init(name: "cFFFAF7", path: [], bundle: bundle) }

        /// Color `cFFFFFF`.
        public var cFFFFFF: RswiftResources.ColorResource { .init(name: "cFFFFFF", path: [], bundle: bundle) }
    }

    /// This `_R.image` struct is generated, and contains static references to 5 images.
    public struct image {
        public let bundle: Foundation.Bundle
        public init(bundle: Foundation.Bundle) {
            self.bundle = bundle
        }

        /// Image `arrow`.
        public var arrow: RswiftResources.ImageResource { .init(name: "arrow", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

        /// Image `check`.
        public var check: RswiftResources.ImageResource { .init(name: "check", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

        /// Image `clearSearch`.
        public var clearSearch: RswiftResources.ImageResource { .init(name: "clearSearch", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

        /// Image `clearSelectable`.
        public var clearSelectable: RswiftResources.ImageResource { .init(name: "clearSelectable", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

        /// Image `close-button`.
        public var closeButton: RswiftResources.ImageResource { .init(name: "close-button", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }
    }
}
