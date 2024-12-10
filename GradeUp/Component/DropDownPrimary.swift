//
//  DropDownPrimary.swift
//  GradeUp
//
//  Created by prk on 09/12/24.
//

import SwiftUI

struct DropDownPrimary: View {
        
    var hint: String
    var options : [String]
    var anchor : Anchor = .bottom
    var maxWidth : CGFloat = CGFloat.infinity
    var cornerRadius : CGFloat = 10
    @Binding var isEditable : Bool
    @Binding var selection : String?
    
    @State private var showOptions: Bool = false
    @Environment(\.colorScheme) private var scheme
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            VStack(spacing: 0){
                HStack(spacing: 0){
                    Text(selection ?? hint)
                        .foregroundStyle(selection == nil ? Color(uiColor: UIColor(named: "Grey")!) : .primary)
                        .opacity(0.7)
                        .font(.system(size: 15))
                        .lineLimit(1)
                        .padding(.leading,-5)
                        
                    Spacer(minLength: 0)
                    
                    Image(systemName: "chevron.down")
                        .font(.title3)
                        .foregroundStyle(.grey)
                        // Rotating icon
                        .rotationEffect(.init(degrees: showOptions ? -180 :0))
                    
                }
                .padding(.horizontal, 15)
                .frame(width: size.width, height: size.height)
                .background(scheme == .dark ? .black : .white)
                .contentShape(.rect)
                .onTapGesture {
                    withAnimation(.snappy){
                        showOptions.toggle()
                    }
                }
                .disabled(!isEditable)
                .zIndex(10)
                
                if showOptions {
                    OptionsView()
                }
            }
            .clipped()
            .contentShape(.rect)
            .background((scheme ==  .dark ? Color.black : Color.white), in: .rect(cornerRadius: cornerRadius))
            .frame(height: size.height, alignment: .top)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
            
        }
        .frame(width: maxWidth, height: 40)
        .zIndex(1000)
    }
    
    @ViewBuilder
    func OptionsView() -> some View {
        VStack(spacing : 10){
            ForEach(options, id: \.self) { option in
                HStack(spacing : 0){
                    Text(option)
                        .font(.system(size: 15))
                        .lineLimit(1)
                    
                    Spacer(minLength: 0)
                    
                    Image(systemName: "checkmark")
                        .font(.caption)
                        .opacity(selection == option ? 1 : 0)
                }
                .foregroundStyle(selection == option ? Color.primary : Color.gray)
                .animation(.none, value: selection)
                .frame(height: 40)
                .contentShape(.rect)
                .onTapGesture {
                    withAnimation(.snappy){
                        selection = option
                        
                        showOptions = false
                    }
                }
            }
        }
        .padding(.leading,10)
        .padding(.trailing,15)
        .padding(.vertical, 5)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
        .transition(.move(edge: .top))
    }
    
    enum Anchor {
        case top
        case bottom
    }
}

#Preview {
    Main()
}
