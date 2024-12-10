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
                    Image(systemName: "arrow.right")
                        .foregroundColor(.white)
                        .font(.system(size: titleSize+2, weight: .bold))
                }
                    
            }
            .frame(width: width, height: height)
            .background(LinearGradient(gradient: isEnabled ? Gradient(colors: [Color.lightBlue, Color.darkBlue]) : Gradient(colors: [Color.gray, Color.gray]), startPoint: .top, endPoint: .bottom))
            .cornerRadius(5)
            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
            
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
