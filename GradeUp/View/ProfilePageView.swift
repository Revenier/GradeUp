//
//  ProfilePageView.swift
//  GradeUp
//
//  Created by prk on 10/12/24.
//

import SwiftUI
import PhotosUI

struct ProfilePageView: View {
    
    @Binding var navigationPath : NavigationPath
    @State var isUpdateProfile : Bool = false
    @State var TFName : String = ""
    @State var TFEmail : String = ""
    @State var TFGrade : String?
    @State var TFDate : String = ""
    
    @State private var photosPickerItem : PhotosPickerItem?
    @State private var avatar : UIImage?
    
    @State private var birthDate = Date()
    @State private var isShowDatePicker = false
    @State private var birthDateStr : String = ""
    
    var body: some View {
        
        ZStack {
            Color(UIColor(named: "BackgroundColor")!).ignoresSafeArea()
            VStack(spacing : 0 ) {
                
                HeaderPrimary(title: "Profile", onBackBtnClick: {
                    navigationPath.removeLast(1)
                }, offSet: -10)
                
                PhotosPicker(selection: $photosPickerItem, matching: .images){
                    if let img = avatar {
                        Image(uiImage: img)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 190, height: 190)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray, lineWidth: 7))
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.gray)
                            .padding(.top, 30)
                    }else {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 190, height: 190)
                            .foregroundColor(.gray)
                            .padding(.top, 30)
                    }
                }
                .disabled(!isUpdateProfile)
                
                
                
                Button {
                    if (isUpdateProfile) {
                        // Update operation
                        
                    }
                    
                    isUpdateProfile.toggle()
                } label: {
                    Text(isUpdateProfile ? "Done" : "Edit Profile")
                        .font(.system(size: 18))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundColor(isUpdateProfile ? Color(uiColor: UIColor(named: "DarkBlue")!) : .black)
                }.padding(.top, 28)
                
                TextFieldPrimary(textInput: $TFName, placeholderText: "Name", isEditable: $isUpdateProfile)
                    .padding(.top,12)
                
                TextFieldPrimary(textInput: $TFEmail, placeholderText: "Email", isEditable: .constant(false))
                    .padding(.top,27)
                
                DropDownPrimary(hint: "Grade", options: ["Primary 1", "Primary 2", "Primary 3", "Primary 4", "Primary 5", "Primary 6"], isEditable: $isUpdateProfile, selection: $TFGrade)
                    .padding(.top,27)
                
                TextField("Date", text: $birthDateStr)
                    .disabled(true)
                    .font(.system(size: 15))
                    .padding(10)
                    .background(.white)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    .padding(.top,27)
                    .onTapGesture {
                        if (isUpdateProfile){
                            withAnimation {
                                isShowDatePicker = true
                            }
                        }
                    }
                
                Spacer()
                
                ButtonPrimary(title: "LogOut", onClick: logOut)
            }
            .padding(.horizontal, 37)
            .onChange(of: photosPickerItem) { _,_ in
                Task {
                    if let photosPickerItem,
                       let data = try? await photosPickerItem.loadTransferable(type: Data.self){
                        if let image = UIImage(data: data){
                            avatar = image
                        }
                    }
                }
            }
            
          
            if (isShowDatePicker){
                Rectangle().frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .blur(radius: 0)
                    .background(.black)
                    .opacity(0.35)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation{
                            isShowDatePicker.toggle()
                        }
                    }
                
                VStack {
                    DatePicker("", selection: $birthDate, in: ...Date(), displayedComponents: .date).datePickerStyle(.graphical)
                        .padding(10).onChange(of: birthDate) { newDate in
                            birthDateStr = newDate.formatted(.dateTime.day().month().year())
                        }
                      
                }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
                    .background(
                        Color.white
                            .cornerRadius(20)
                    )
                    .padding(.horizontal,30)
                    .zIndex(2)
            }
            
            
            
                
        }
        
    }
    
    func logOut() {
        
        // pop navigation ke login screen
        navigationPath.removeLast(navigationPath.count)
    }
    
    
}



#Preview {
    ProfilePageView(navigationPath: .constant(NavigationPath()))
}
