//
//  UploadPostView.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/17/24.
//

import SwiftUI
import PhotosUI

struct UploadPostView: View
{
    @State private var title = ""
    @State private var description = ""
    @State private var organizer = ""
    @State private var organization = ""
    @State private var location = ""
    @State private var imagePickerPresented = false
    
    // Start Date
    @State private var startMM = ""
    @State private var startDD = ""
    @State private var startYYYY = ""
    // End Date
    @State private var endMM = ""
    @State private var endDD = ""
    @State private var endYYYY = ""
    // Start Time
    @State private var starttime = ""
    @State private var endtime = ""
    @State private var starttimezone = 0
    @State private var endtimezone = 0
    let options = ["AM PST", "PM PST"]
    
    @State private var caption = ""
    @StateObject var viewModel = UploadPostViewModel()
    @Binding var tabIndex: Int
    
    var body: some View
    {
        ScrollView
        {
            VStack
            {
                HStack
                {
                    Button
                    {
                        clearPostDataAndReturnToFeed()
                    } label:
                    {
                        Text("Cancel")
                    }
                    Spacer()
                    Text("New Post")
                        .fontWeight(.semibold)
                    Spacer()
                    Button {
                        Task {
                            try await viewModel.uploadPost(
                                title: title,
                                caption: caption,
                                organizer: organizer,
                                organization: organization,
                                location: location,
                                
                                startMM: startMM,
                                startDD: startDD,
                                startYYYY: startYYYY,

                                endMM: endMM,
                                endDD: endDD,
                                endYYYY: endYYYY,

                                starttime: starttime,
                                endtime: endtime
                            )
                            clearPostDataAndReturnToFeed()
                        }
                    } label:
                    {
                        Text("Upload")
                            .fontWeight(.semibold)
                    }
                    
                }
                .padding(.horizontal)
                
                // Post image and caption
                PhotosPicker(selection: $viewModel.selectedImage){
                    HStack(spacing: 8)
                    {
                        
                        if let image = viewModel.postImage
                        {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 350, height: 350)
                                .clipShape(.rect(cornerRadius: 15))
                                .shadow(color: Color.black.opacity(0.25), radius: 8, x: 5, y: 10)
                                .padding(.top, 15)
                        }
                        else
                        {
                            ZStack
                            {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 2)
                                    .background(Color.gray.opacity(0.2))
                                    .frame(width: 350, height: 350)
                                
                                
                                Image(systemName: "photo.on.rectangle.angled")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(Color(.gray))
                            }
                            .padding(.top, 15)
                        }
                    }
                }
                
                VStack
                {
                    VStack(alignment: .leading) { // Align elements to the leading edge
                        
                        
                        HStack
                        {
                            Text("Event Name")
                                .padding(.top, 10)
                                .font(.title2)
                                .bold()
                                .padding(.top, 5)
                            Text("*")
                                .foregroundColor(.red)
                                .padding(.top, 15)
                                .font(.title2)
                                .bold()
                                .padding(.top, 5)
                        }
                        TextField("Name of Event", text: $title)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .frame(width: 325, height: 50)
                        
                        HStack
                        {
                            Text("Description")
                                .padding(.top, 10)
                                .font(.title2)
                                .bold()
                                .padding(.top, 5)
                            Text("*")
                                .foregroundColor(.red)
                                .padding(.top, 15)
                                .font(.title2)
                                .bold()
                                .padding(.top, 5)
                        }
                        TextField("Write your event's description here.", text: $caption)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .frame(width: 325)
//                          .multilineTextAlignment(.center)
                        
                        HStack
                        {
                            Text("Organization")
                                .padding(.top, 10)
                                .font(.title2)
                                .bold()
                                .padding(.top, 5)
                            Text("*")
                                .foregroundColor(.red)
                                .padding(.top, 15)
                                .font(.title2)
                                .bold()
                                .padding(.top, 5)
                        }
                        TextField("Club name or Organization", text: $organization)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .frame(width: 325)
                        
                        Text("Organizer")
                            .padding(.top, 10)
                            .font(.title2)
                            .bold()
                        TextField("Organizer's Name", text: $organizer)
                            .autocapitalization(.none)
                            .padding()
                            
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .frame(width: 325)
                        
                        HStack
                        {
                            Text("Location")
                                .padding(.top, 10)
                                .font(.title2)
                                .bold()
                                .padding(.top, 5)
                            Text("*")
                                .foregroundColor(.red)
                                .padding(.top, 15)
                                .font(.title2)
                                .bold()
                                .padding(.top, 5)
                        }

                        TextField("Event's Location", text: $location)
                            .autocapitalization(.none)
                            .padding()
                            
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .frame(width: 325)
                        
                        
                        HStack
                        {
                            Text("Start Date")
                                .padding(.top, 10)
                                .font(.title2)
                                .bold()
                                .padding(.top, 5)
                            Text("*")
                                .foregroundColor(.red)
                                .padding(.top, 15)
                                .font(.title2)
                                .bold()
                                .padding(.top, 5)
                        }
                        
                        HStack
                        {
                            TextField("MM", text: $startMM)
                                .autocapitalization(.none)
                                .padding()
                                
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                                .frame(width: 100)
                            TextField("DD", text: $startDD)
                                .autocapitalization(.none)
                                .padding()
                                
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                                .frame(width: 100)
                            TextField("YYYY", text: $startYYYY)
                                .autocapitalization(.none)
                                .padding()
                                
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                                .frame(width: 110)
                        }
                        
                        HStack
                        {
                            Text("End Date")
                                .padding(.top, 10)
                                .font(.title2)
                                .bold()
                                .padding(.top, 5)
                            Text("*")
                                .foregroundColor(.red)
                                .padding(.top, 15)
                                .font(.title2)
                                .bold()
                                .padding(.top, 5)
                        }
                        
                        HStack
                        {
                            TextField("MM", text: $endMM)
                                .autocapitalization(.none)
                                .padding()
                                
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                                .frame(width: 100)
                            TextField("DD", text: $endDD)
                                .autocapitalization(.none)
                                .padding()
                                
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                                .frame(width: 100)
                            TextField("YYYY", text: $endYYYY)
                                .autocapitalization(.none)
                                .padding()
                                
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                                .frame(width: 110)
                                
                        }
                        
                        HStack
                        {
                            Text("Start Time")
                                .padding(.top, 10)
                                .font(.title2)
                                .bold()
                                .padding(.top, 5)
                            Text("*")
                                .foregroundColor(.red)
                                .padding(.top, 15)
                                .font(.title2)
                                .bold()
                                .padding(.top, 5)
                        }
                        
                        HStack
                        {
                            TextField("12:00 AM", text: $starttime)
                                .autocapitalization(.none)
                                .padding()
                                
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                                .frame(width: 350)
                            
                            
//                                Picker(selection: $starttimezone, label: Text("Select an option"))
//                                {
//                                    ForEach(0..<options.count)
//                                    { index in
//                                        Text(options[index]).tag(index)
//                                    }
//                                }
//                                .pickerStyle(MenuPickerStyle())
//                                .frame(height:22)
//                                .padding()
//                                .background(Color.gray.opacity(0.2))
//                                .cornerRadius(10)
//                                
//                                .foregroundColor(.gray)
                        }
                        
                        HStack
                        {
                            Text("12:00 PM")
                                .padding(.top, 10)
                                .font(.title2)
                                .bold()
                                .padding(.top, 5)
                            Text("*")
                                .foregroundColor(.red)
                                .padding(.top, 15)
                                .font(.title2)
                                .bold()
                                .padding(.top, 5)
                        }
                        
                        HStack
                        {
                            TextField("Time", text: $endtime)
                                .autocapitalization(.none)
                                .padding()
                                
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                                .frame(width: 350)
                            
                            
//                                Picker(selection: $endtimezone, label: Text("Select an option"))
//                                {
//                                    ForEach(0..<options.count)
//                                    { index in
//                                        Text(options[index]).tag(index)
//                                    }
//                                }
//                                .pickerStyle(MenuPickerStyle())
//                                .frame(height:22)
//                                .padding()
//                                .background(Color.gray.opacity(0.2))
//                                .cornerRadius(10)
                                
                                .foregroundColor(.gray)
                                 
                        }
                        
                        Spacer()
                    }
                    .padding(.bottom,15)
                    .padding(.horizontal, 20) // Add horizontal padding to keep elements away from the border line
                    
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 1) // Add border line
                    )
                    .padding() // Add padding to the outer VStack to ensure border visibility and spacing
                    .cornerRadius(20)
                }
            }
            .onAppear
            {
                imagePickerPresented.toggle()
            }
            .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedImage)
        }
        
    }
    
    func clearPostDataAndReturnToFeed() {
        caption = ""
        title = ""
        location = ""
        organizer = ""
        organization = ""
        viewModel.selectedImage = nil
        viewModel.postImage = nil
        tabIndex = 0
    }
    
}

struct UploadPostView_Previews: PreviewProvider {
    static var previews: some View {
        UploadPostView(tabIndex: .constant(0))
    }
}

