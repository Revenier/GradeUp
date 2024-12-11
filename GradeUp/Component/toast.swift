//
//  toast.swift
//  GradeUp
//
//  Created by Kalyana Mitta on 11/12/24.
//

import SwiftUI

struct ToastView: View {
    var message: String
    @Binding var isShowing: Bool
    
    var body: some View {
        VStack {
            Spacer()
            if isShowing {
                Text(message)
                    .font(.system(size: 14))
                    .foregroundColor(.black)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 10)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 40)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isShowing = false
            }
        }
    }
}
