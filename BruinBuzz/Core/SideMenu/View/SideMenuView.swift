//
//  SideMenuView.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 5/19/24.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var showSideMenu: Bool
    let twitterBlue = Color(UIColor(red: 0.016, green: 0.25, blue: 0.47, alpha: 1))
    let navy = Color(UIColor(red: 0.494, green: 0.752, blue: 0.898, alpha: 1))

    
    var body: some View {
        ZStack {
            
            RadialGradient(gradient: Gradient(colors: [twitterBlue, .white]), center: .center, startRadius: 500, endRadius: -900)
                .ignoresSafeArea()
            VStack {
                VStack {
                    HStack(spacing: 125) {
                        
                        Button {
                            withAnimation(.spring()) {
                                showSideMenu.toggle()
                            }
                        } label: {
                            Image(systemName: "chevron.left")
                                .imageScale(.large)
                                .padding(.bottom, 16)
                                .foregroundColor(.white)
                                .padding(.top, 16)
                            
                            
                        }
                        
                        Text("Settings")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                        
                        
                        Image(systemName: "chevron.left")
                            .imageScale(.large)
                            .padding(.trailing, 16)
                            .padding(.bottom, 16)
                            .foregroundColor(.clear)
                            .padding(.top, 16)
                    }
                    
                    Button {
                        AuthService.shared.signout()
                    } label: {
                        HStack(spacing: 16) {
                            Image(systemName: "door.left.hand.open")
                                .font(.title2)
                                .imageScale(.medium)
                                .foregroundColor(navy)
                            
                            Text(" Logout")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(navy)
                            
                            Spacer()
                        }
                        .padding(.leading, 20)
                    }
                    .padding(.top, 16)
                    
                    
                    Menu {
                        
                        Text("Are you sure? Your data will be erased.")

                        Button {
                            Task {
                                 AuthService.shared.deleteUserData()
                                 try await AuthService.shared.deleteAccount()
                            }
                        } label: {
                            Text("Delete Account")
                            
                        }
                        Button("Cancel", role: .destructive) {
                            
                        }
                            
                    } label: {
                        HStack(spacing: 16) {
                            Image(systemName: "person.crop.circle.fill.badge.xmark")
                                .font(.title2)
                                .imageScale(.medium)
                                .foregroundColor(navy)
                            Text("Delete Account")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(navy)
                            
                            Spacer()
                        }
                        .padding(.leading, 20)
                        
                    }
                

                    .padding(.top, 24)
                }
                .padding(.leading, 16)
                
                Rectangle()
                    .frame(width: (UIScreen.main.bounds.width - 60), height: 0.77)
                    .opacity(0.7)
                    .foregroundColor(Color(.white))
                    .padding(.top, 16)
                
                Spacer()
            }
        }
    }
}

struct SideMenuView_Previews: PreviewProvider {
    @State static var showSideMenu = true
    
    static var previews: some View {
        SideMenuView(showSideMenu: $showSideMenu)
    }
}