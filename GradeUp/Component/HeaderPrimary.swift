//
//  HeaderPrimary.swift
//  GradeUp
//
//  Created by prk on 10/12/24.
//

import SwiftUI

// NOTE : Parent yang manggil view HeaderPrimary ini pake padding .horizontal 37
// Make sure title tengah nya center, mainin offset nya aja

struct HeaderPrimary: View {
    
    var title : String
    var onBackBtnClick : (() -> Void)
    var offSet : CGFloat
    
    var body: some View {
        HStack(){
            Button {
                onBackBtnClick()
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
                    .font(.system(size: 23))
            }
            
            Spacer()
            
            Text(title)
                .foregroundColor(.black)
                .font(.system(size: 18, weight: .bold))
                .offset(x: offSet)
            
            Spacer()
            
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.top, 15)
    }
}

#Preview {
    HeaderPrimary(title: "Title", onBackBtnClick: {}, offSet: -10)
}
