// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit.NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIFont
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "FontConvertible.Font", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias Font = FontConvertible.Font

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Fonts

// swiftlint:disable identifier_name line_length type_body_length
internal enum FontFamily {
  internal enum Gilroy {
    internal static let black = FontConvertible(name: "Gilroy-Black", family: "Gilroy", path: "Gilroy-Black.ttf")
    internal static let blackItalic = FontConvertible(name: "Gilroy-BlackItalic", family: "Gilroy", path: "Gilroy-BlackItalic.ttf")
    internal static let bold = FontConvertible(name: "Gilroy-Bold", family: "Gilroy", path: "Gilroy-Bold.ttf")
    internal static let boldItalic = FontConvertible(name: "Gilroy-BoldItalic", family: "Gilroy", path: "Gilroy-BoldItalic.ttf")
    internal static let extrabold = FontConvertible(name: "Gilroy-Extrabold", family: "Gilroy", path: "Gilroy-Extrabold.ttf")
    internal static let extraboldItalic = FontConvertible(name: "Gilroy-ExtraboldItalic", family: "Gilroy", path: "Gilroy-ExtraboldItalic.ttf")
    internal static let heavy = FontConvertible(name: "Gilroy-Heavy", family: "Gilroy", path: "Gilroy-Heavy.ttf")
    internal static let heavyItalic = FontConvertible(name: "Gilroy-HeavyItalic", family: "Gilroy", path: "Gilroy-HeavyItalic.ttf")
    internal static let light = FontConvertible(name: "Gilroy-Light", family: "Gilroy", path: "Gilroy-Light.ttf")
    internal static let lightItalic = FontConvertible(name: "Gilroy-LightItalic", family: "Gilroy", path: "Gilroy-LightItalic.ttf")
    internal static let medium = FontConvertible(name: "Gilroy-Medium", family: "Gilroy", path: "Gilroy-Medium.ttf")
    internal static let mediumItalic = FontConvertible(name: "Gilroy-MediumItalic", family: "Gilroy", path: "Gilroy-MediumItalic.ttf")
    internal static let regular = FontConvertible(name: "Gilroy-Regular", family: "Gilroy", path: "Gilroy-Regular.ttf")
    internal static let regularItalic = FontConvertible(name: "Gilroy-RegularItalic", family: "Gilroy", path: "Gilroy-RegularItalic.ttf")
    internal static let semibold = FontConvertible(name: "Gilroy-Semibold", family: "Gilroy", path: "Gilroy-Semibold.ttf")
    internal static let semiboldItalic = FontConvertible(name: "Gilroy-SemiboldItalic", family: "Gilroy", path: "Gilroy-SemiboldItalic.ttf")
    internal static let thin = FontConvertible(name: "Gilroy-Thin", family: "Gilroy", path: "Gilroy-Thin.ttf")
    internal static let thinItalic = FontConvertible(name: "Gilroy-ThinItalic", family: "Gilroy", path: "Gilroy-ThinItalic.ttf")
    internal static let ultraLight = FontConvertible(name: "Gilroy-UltraLight", family: "Gilroy", path: "Gilroy-UltraLight.ttf")
    internal static let ultraLightItalic = FontConvertible(name: "Gilroy-UltraLightItalic", family: "Gilroy", path: "Gilroy-UltraLightItalic.ttf")
    internal static let all: [FontConvertible] = [black, blackItalic, bold, boldItalic, extrabold, extraboldItalic, heavy, heavyItalic, light, lightItalic, medium, mediumItalic, regular, regularItalic, semibold, semiboldItalic, thin, thinItalic, ultraLight, ultraLightItalic]
  }
  internal static let allCustomFonts: [FontConvertible] = [Gilroy.all].flatMap { $0 }
  internal static func registerAllCustomFonts() {
    allCustomFonts.forEach { $0.register() }
  }
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

internal struct FontConvertible {
  internal let name: String
  internal let family: String
  internal let path: String

  #if os(macOS)
  internal typealias Font = NSFont
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Font = UIFont
  #endif

  internal func font(size: CGFloat) -> Font {
    guard let font = Font(font: self, size: size) else {
      fatalError("Unable to initialize font '\(name)' (\(family))")
    }
    return font
  }

  internal func register() {
    // swiftlint:disable:next conditional_returns_on_newline
    guard let url = url else { return }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }

  fileprivate var url: URL? {
    // swiftlint:disable:next implicit_return
    return BundleToken.bundle.url(forResource: path, withExtension: nil)
  }
}

internal extension FontConvertible.Font {
  convenience init?(font: FontConvertible, size: CGFloat) {
    #if os(iOS) || os(tvOS) || os(watchOS)
    if !UIFont.fontNames(forFamilyName: font.family).contains(font.name) {
      font.register()
    }
    #elseif os(macOS)
    if let url = font.url, CTFontManagerGetScopeForURL(url as CFURL) == .none {
      font.register()
    }
    #endif

    self.init(name: font.name, size: size)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
