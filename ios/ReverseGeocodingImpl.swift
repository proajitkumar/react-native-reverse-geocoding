import Contacts
import CoreLocation
import Foundation

@objc(ReverseGeocodingImpl)
public class ReverseGeocodingImpl: NSObject {

  @objc public func reverseGeocode(
    withLatitude latitude: Double,
    longitude: Double,
    resolve: @escaping (Any?) -> Void,
    reject: @escaping (String, String, Error?) -> Void
  ) {
    let location = CLLocation(latitude: latitude, longitude: longitude)
    let geocoder = CLGeocoder()

    geocoder.reverseGeocodeLocation(location) { placemarks, error in
      if let error = error {
        reject("GEOCODE_FAILED", error.localizedDescription, error)
        return
      }

      guard let placemark = placemarks?.first else {
        resolve([])
        return
      }

      var formattedAddress: String?
      if let postalAddress = placemark.postalAddress {
        formattedAddress = CNPostalAddressFormatter.string(from: postalAddress, style: .mailingAddress)
          .replacingOccurrences(of: "\n", with: ", ")
      }

      let address: [String: Any?] = [
        "city": placemark.locality,
        "region": placemark.administrativeArea,
        "country": placemark.country,
        "isoCountryCode": placemark.isoCountryCode,
        "postalCode": placemark.postalCode,
        "street": placemark.thoroughfare,
        "streetNumber": placemark.subThoroughfare,
        "subregion": placemark.subAdministrativeArea,
        "name": placemark.name,
        "formattedAddress": formattedAddress,
      ]

      resolve([address])
    }
  }
}
