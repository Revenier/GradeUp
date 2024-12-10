//
//  ButtonSecondary.swift
//  GradeUp
//
//  Created by prk on 10/12/24.
//

import SwiftUI

struct ButtonSecondary: View {
    var iconPos : iconPosition
    var title : String
    var onClick : (() -> Void)
    @Binding var isEnabled : Bool
    var titleSize : CGFloat
    var width : CGFloat
    var height : CGFloat
    
    var body: some View {
        Button {
            if (isEnabled) {
                onClick()
            }
        } label : {
            HStack (spacing: 14) {
                if (iconPos == .left){
                    Image(systemName: "arrow.left")
                        .foregroundColor(.white)
                        .font(.system(size: titleSize+2, weight: .bold))
                }
                
                Text(title)
                    .font(.system(size: titleSize,weight: .bold))
                    .foregroundStyle(.white)
                
                if (iconPos == .right){
                    Image(systemName: "chevron.right")
                        .foregroundColor(.white)
                        .font(.system(size: titleSize+2, weight: .bold))
                }
                    
            }
            .frame(width: width, height: height)
            .background(Color(uiColor: UIColor(named: isEnabled ? "LightBlue" : "SecondaryTextColor")!))
            .cornerRadius(5)
            .shadow(color: .lightGrey, radius: 4, x: 1, y: 4)
            
        }
    }
    
    
    enum iconPosition {
        case left
        case right
    }
}

#Preview {
    ButtonSecondary(iconPos: .right, title: "Continue", onClick: {}, isEnabled: .constant(true), titleSize: 10, width: 102, height: 27)
}
