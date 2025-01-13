//
//  Extension.swift
//  offlineFileApp
//
//  Created by Elavazhagan on 10/01/25.
//

import Foundation
import UIKit
import SwiftUI

extension UIColor {
    func toHexString() -> String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        let rgb: Int = (Int)(red * 255) << 16 | (Int)(green * 255) << 8 | (Int)(blue * 255) << 0

        return String(format: "#%06x", rgb)
    }
}

extension DateFormatter {
    static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy hh:mm:ss a"
        return formatter
    }()
}

extension UIColor {
    convenience init?(hex: String) {
        var hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        hex = hex.hasPrefix("#") ? String(hex.dropFirst()) : hex
        var rgb: UInt64 = 0
        guard Scanner(string: hex).scanHexInt64(&rgb) else { return nil }
        
        let red = CGFloat((rgb >> 16) & 0xFF) / 255.0
        let green = CGFloat((rgb >> 8) & 0xFF) / 255.0
        let blue = CGFloat(rgb & 0xFF) / 255.0
        
        self.init(
            red: red,
            green: green,
            blue: blue,
            alpha: 1.0
        )
    }
}

enum SortOption {
    case name
    case date
}

enum PickerType: Identifiable {
    case cameraRoll, files
    
    var id: Int {
        hashValue
    }
}
enum ImageSaveError: Error {
    case conversionFailed
}
