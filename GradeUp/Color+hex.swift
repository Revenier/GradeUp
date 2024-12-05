 //
//  Color+hex.swift
//  GradeUp
//
//  Created by prk on 16/11/24.
//

import Foundation
import SwiftUI

extension Color{
    init(hex: String){
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgb: UInt64 = 0
        Scanner(string: hex.hasPrefix("#") ?
                String(hex.dropFirst()): hex).scanHexInt64(&rgb)
        self.init(
            red: Double((rgb >> 16) & 0xFF)/255,
            green: Double((rgb >> 8) & 0xFF)/255,
            blue: Double(rgb & 0xFF)/255
        )
    }
}
