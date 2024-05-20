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
    @State private var showAlert = false
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
//    @State private var starttimezone = 0
//    @State private var endtimezone = 0
//    let options = ["AM PST", "PM PST"]
    
    @State private var caption = ""
    @StateObject var viewModel = UploadPostViewModel()
    @StateObject var refreshCall = HomeViewModel()
//    let twitterBlue = Color(UIColor(red: 0.016, green: 0.25, blue: 0.47, alpha: 1))
//    let twitterBlue = Color(UIColor(red: 0.494, green: 0.752, blue: 0.898, alpha: 1))
    let twitterBlue = Color(UIColor(red: 0.494, green: 0.752, blue: 0.898, alpha: 1))


    @Binding var tabIndex: Int
    
    var body: some View
    {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [ .white]), center: .center, startRadius: 500, endRadius: -900)
                .ignoresSafeArea()
            
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
                                .foregroundColor(.black)
                        }
                        Spacer()
                        Text("New Post")
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        Spacer()
                        Button {
                            Task {
                                // Check if any field is empty
                                if title.isEmpty || caption.isEmpty || organizer.isEmpty || organization.isEmpty || location.isEmpty ||
                                    startMM.isEmpty || startDD.isEmpty || startYYYY.isEmpty ||
                                    endMM.isEmpty || endDD.isEmpty || endYYYY.isEmpty ||
                                    starttime.isEmpty || endtime.isEmpty {
                                    
                                    // Handle the case where one or more fields are empty
                                    // For example, you can show an alert to the user
                                    showAlert = true
                                } else {
                                    do {
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
                                    } catch {
                                        // Handle the error
                                        print("Failed to upload post: \(error)")
                                    }
                                }
                            }
                        } label: {
                            Text("Upload")
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                        }
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("Error"),
                                message: Text("All fields must be filled in."),
                                dismissButton: .default(Text("OK"))
                            )
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
                                    .foregroundColor(.black)
                                Text("*")
                                    .foregroundColor(.red)
                                    .padding(.top, 15)
                                    .font(.title2)
                                    .bold()
                                    .padding(.top, 5)
                            }

                            ZStack(alignment: .leading) {
                                if title.isEmpty {
                                    Text("Name of Event")
                                        .padding()
                                        .foregroundColor(Color(.lightGray))
                                }
                                TextField("", text: $title)
                                    .foregroundColor(.black)
                                    .accentColor(.black)
                                    .padding()
                            }
                            .frame(width: 325, height: 50)
                            .background(Color.gray.opacity(0.2))
                            .autocapitalization(.none)
                            .cornerRadius(10)
                            
                            HStack
                            {
                                Text("Description")
                                    .padding(.top, 10)
                                    .font(.title2)
                                    .bold()
                                    .padding(.top, 5)
                                    .foregroundColor(.black)
                                Text("*")
                                    .foregroundColor(.red)
                                    .padding(.top, 15)
                                    .font(.title2)
                                    .bold()
                                    .padding(.top, 5)
                            }
                            
                            ZStack(alignment: .leading) {
                                if caption.isEmpty {
                                    Text("Write your event's description here.")
                                        .padding()
                                        .foregroundColor(Color(.lightGray))
                                }
                                TextField("", text: $caption)
                                    .foregroundColor(.black)
                                    .accentColor(.black)
                                    .padding()
                            }
                            .frame(width: 325, height: 50)
                            .background(Color.gray.opacity(0.2))
                            .autocapitalization(.none)
                            .cornerRadius(10)
                            
                            HStack
                            {
                                Text("Organization")
                                    .padding(.top, 10)
                                    .font(.title2)
                                    .bold()
                                    .padding(.top, 5)
                                    .foregroundColor(.black)
                                Text("*")
                                    .foregroundColor(.red)
                                    .padding(.top, 15)
                                    .font(.title2)
                                    .bold()
                                    .padding(.top, 5)
                            }
                            
                            ZStack(alignment: .leading) {
                                if organization.isEmpty {
                                    Text("Club name or Organization")
                                        .padding()
                                        .foregroundColor(Color(.lightGray))
                                }
                                TextField("", text: $organization)
                                    .foregroundColor(.black)
                                    .accentColor(.black)
                                    .padding()
                            }
                            .frame(width: 325, height: 50)
                            .background(Color.gray.opacity(0.2))
                            .autocapitalization(.none)
                            .cornerRadius(10)

                            HStack
                            {
                                Text("Organizer")
                                    .padding(.top, 10)
                                    .font(.title2)
                                    .bold()
                                    .padding(.top, 5)
                                    .foregroundColor(.black)
                                Text("*")
                                    .foregroundColor(.red)
                                    .padding(.top, 15)
                                    .font(.title2)
                                    .bold()
                                    .padding(.top, 5)
                            }
                            
                            ZStack(alignment: .leading) {
                                if organizer.isEmpty {
                                    Text("Organizer's Name")
                                        .padding()
                                        .foregroundColor(Color(.lightGray))
                                }
                                TextField("", text: $organizer)
                                    .foregroundColor(.black)
                                    .accentColor(.black)
                                    .padding()
                            }
                            .frame(width: 325, height: 50)
                            .background(Color.gray.opacity(0.2))
                            .autocapitalization(.none)
                            .cornerRadius(10)
                            
                            
                            HStack
                            {
                                Text("Location")
                                    .padding(.top, 10)
                                    .font(.title2)
                                    .bold()
                                    .padding(.top, 5)
                                    .foregroundColor(.black)
                                Text("*")
                                    .foregroundColor(.red)
                                    .padding(.top, 15)
                                    .font(.title2)
                                    .bold()
                                    .padding(.top, 5)
                            }
                            
                            ZStack(alignment: .leading) {
                                if location.isEmpty {
                                    Text("Event's Location")
                                        .padding()
                                        .foregroundColor(Color(.lightGray))
                                }
                                TextField("", text: $location)
                                    .foregroundColor(.black)
                                    .accentColor(.black)
                                    .padding()
                            }
                            .frame(width: 325, height: 50)
                            .background(Color.gray.opacity(0.2))
                            .autocapitalization(.none)
                            .cornerRadius(10)
                            
                            HStack
                            {
                                Text("Start Date")
                                    .padding(.top, 10)
                                    .font(.title2)
                                    .bold()
                                    .padding(.top, 5)
                                    .foregroundColor(.black)
                                Text("*")
                                    .foregroundColor(.red)
                                    .padding(.top, 15)
                                    .font(.title2)
                                    .bold()
                                    .padding(.top, 5)
                            }
                            
                            HStack
                            {
                                ZStack(alignment: .leading) {
                                    if startMM.isEmpty {
                                        Text("MM")
                                            .padding()
                                            .foregroundColor(Color(.lightGray))
                                    }
                                    TextField("", text: $startMM)
                                        .foregroundColor(.black)
                                        .accentColor(.black)
                                        .padding()
                                }
                                .frame(width: 100)
                                .background(Color.gray.opacity(0.2))
                                .autocapitalization(.none)
                                .cornerRadius(10)
                                
                                ZStack(alignment: .leading) {
                                    if startDD.isEmpty {
                                        Text("DD")
                                            .padding()
                                            .foregroundColor(Color(.lightGray))
                                    }
                                    TextField("", text: $startDD)
                                        .foregroundColor(.black)
                                        .accentColor(.black)
                                        .padding()
                                }
                                .frame(width: 100)
                                .background(Color.gray.opacity(0.2))
                                .autocapitalization(.none)
                                .cornerRadius(10)
                                
                                ZStack(alignment: .leading) {
                                    if startYYYY.isEmpty {
                                        Text("YYYY")
                                            .padding()
                                            .foregroundColor(Color(.lightGray))
                                    }
                                    TextField("", text: $startYYYY)
                                        .foregroundColor(.black)
                                        .accentColor(.black)
                                        .padding()
                                }
                                .frame(width: 100)
                                .background(Color.gray.opacity(0.2))
                                .autocapitalization(.none)
                                .cornerRadius(10)
                            }
                            
                            HStack
                            {
                                Text("End Date")
                                    .padding(.top, 10)
                                    .font(.title2)
                                    .bold()
                                    .padding(.top, 5)
                                    .foregroundColor(.black)
                                Text("*")
                                    .foregroundColor(.red)
                                    .padding(.top, 15)
                                    .font(.title2)
                                    .bold()
                                    .padding(.top, 5)
                            }
                            
                            HStack
                            {
                                ZStack(alignment: .leading) {
                                    if endMM.isEmpty {
                                        Text("MM")
                                            .padding()
                                            .foregroundColor(Color(.lightGray))
                                    }
                                    TextField("", text: $endMM)
                                        .foregroundColor(.black)
                                        .accentColor(.black)
                                        .padding()
                                }
                                .frame(width: 100)
                                .background(Color.gray.opacity(0.2))
                                .autocapitalization(.none)
                                .cornerRadius(10)
                                
                                ZStack(alignment: .leading) {
                                    if endDD.isEmpty {
                                        Text("DD")
                                            .padding()
                                            .foregroundColor(Color(.lightGray))
                                    }
                                    TextField("", text: $endDD)
                                        .foregroundColor(.black)
                                        .accentColor(.black)
                                        .padding()
                                }
                                .frame(width: 100)
                                .background(Color.gray.opacity(0.2))
                                .autocapitalization(.none)
                                .cornerRadius(10)
                                
                                ZStack(alignment: .leading) {
                                    if endYYYY.isEmpty {
                                        Text("YYYY")
                                            .padding()
                                            .foregroundColor(Color(.lightGray))
                                    }
                                    TextField("", text: $endYYYY)
                                        .foregroundColor(.black)
                                        .accentColor(.black)
                                        .padding()
                                }
                                .frame(width: 100)
                                .background(Color.gray.opacity(0.2))
                                .autocapitalization(.none)
                                .cornerRadius(10)
                            }
                            
                            HStack
                            {
                                Text("Start Time")
                                    .padding(.top, 10)
                                    .font(.title2)
                                    .bold()
                                    .padding(.top, 5)
                                    .foregroundColor(.black)
                                Text("*")
                                    .foregroundColor(.red)
                                    .padding(.top, 15)
                                    .font(.title2)
                                    .bold()
                                    .padding(.top, 5)
                            }
                            
                            HStack
                            {
                                ZStack(alignment: .leading) {
                                    if starttime.isEmpty {
                                        Text("12:00 AM")
                                            .padding()
                                            .foregroundColor(Color(.lightGray))
                                    }
                                    TextField("", text: $starttime)
                                        .foregroundColor(.black)
                                        .accentColor(.black)
                                        .padding()
                                }
                                .frame(width: 325, height: 50)
                                .background(Color.gray.opacity(0.2))
                                .autocapitalization(.none)
                                .cornerRadius(10)
                                
                                
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
                                Text("End Time")
                                    .padding(.top, 10)
                                    .font(.title2)
                                    .bold()
                                    .padding(.top, 5)
                                    .foregroundColor(.black)
                                Text("*")
                                    .foregroundColor(.red)
                                    .padding(.top, 15)
                                    .font(.title2)
                                    .bold()
                                    .padding(.top, 5)
                            }
                            
                            HStack
                            {
                                ZStack(alignment: .leading) {
                                    if endtime.isEmpty {
                                        Text("12:00 PM")
                                            .padding()
                                            .foregroundColor(Color(.lightGray))
                                    }
                                    TextField("", text: $endtime)
                                        .foregroundColor(.black)
                                        .accentColor(.black)
                                        .padding()
                                }
                                .frame(width: 325, height: 50)
                                .background(Color.gray.opacity(0.2))
                                .autocapitalization(.none)
                                .cornerRadius(10)
                                
                                
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
                                    
    //                                .foregroundColor(.gray)
                                     
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
        
    }
    
    func clearPostDataAndReturnToFeed() {
        caption = ""
        title = ""
        location = ""
        organizer = ""
        organization = ""
        startMM = ""
        startDD = ""
        startYYYY = ""

        endMM = ""
        endDD = ""
        endYYYY = ""

        starttime = ""
        endtime = ""
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

