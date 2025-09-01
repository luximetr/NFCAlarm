import Foundation

extension Bundle {
    
    class func forLocale(_ locale: Locale) -> Bundle? {
        let language = locale.language
        let languageCode: String
        switch language {
        case .english: languageCode = "en"
        case .ukrainian: languageCode = "uk"
        }
        let bundle = localizedFor(language: languageCode, region: nil)
        return bundle
    }
    
    private class func localizedFor(language: String, region: String?) -> Bundle? {
        var resource = language
        if let region = region {
            resource += "_\(region)"
        }
        if let bundle = BundlesStore.localizedBundles[resource] {
            return bundle
        } else {
            let resource = language
            let type = "lproj"
            
            if let path = Bundle.module.path(forResource: resource, ofType: type) {
                let bundle = Bundle(path: path)
                BundlesStore.localizedBundles[resource] = bundle
                return bundle
            } else {
                return nil
            }
        }
    }
    
}

private actor BundlesStore {
    static var localizedBundles: [String: Bundle] = [:]
}
