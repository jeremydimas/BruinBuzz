//
//  UploadPostView.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/17/24.
//

import SwiftUI
import PhotosUI
import Firebase

struct UploadPostView: View
{
    @State private var showAlert = false
    @State private var title = ""
    @State private var description = ""
    @State private var organizer = ""
    @State private var organization = ""
    @State private var location = ""
    @State private var caption = ""
//    @State private var imagePickerPresented = false
    @StateObject var viewModel = UploadPostViewModel()
    @StateObject var refreshCall = HomeViewModel()
    @Binding var tabIndex: Int
    @Environment(\.colorScheme) var colorScheme
    @State private var link1 = ""
    @State private var link2 = ""
    //    @State private var link3 = ""
    
    let lightGrayColor = Color(red: 0.9, green: 0.9, blue: 0.9)
    
    //    Variable for Start Time
    @State var currentTime = Date()
    var closedRange = Calendar.current.date(byAdding:.year,value:-1,to: Date())!
    
    //    Varibale for End Time
    @State var pastTime = Date()
    var closedRange2 = Calendar.current.date(byAdding:.year,value:-1,to: Date())!
    
    //    Displays Ex: May 23, 2024
    func formateDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE "
        return dateFormatter.string(from: currentTime)
    }
    
    //    Displays Ex: May 23, 2024
    func formateDate2() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE "
        return dateFormatter.string(from: pastTime)
    }
    
    //    Displays Ex: May 23, 2024
    var dateFormatter:DateFormatter{
        let df = DateFormatter()
        df.dateStyle = .medium
        return df
    }
    
    //    Displays the Time Stamp
    var timeFormatter:DateFormatter{
        let df = DateFormatter()
        df.dateStyle = .none
        df.timeStyle = .medium
        return df
    }
    
    var formattedCurrentTime: String {
        let formattedDate = dateFormatter.string(from: currentTime)
        let formattedTime = timeFormatter.string(from: currentTime)
        return "\(formattedDate) at \(formattedTime)"
    }
    
    var formattedPastTime: String {
        let formattedDate = dateFormatter.string(from: pastTime)
        let formattedTime = timeFormatter.string(from: pastTime)
        return "\(formattedDate) at \(formattedTime)"
    }
        
        var body: some View
        {
            ZStack {
                Color(colorScheme == .dark ? .black : .white)
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
                                    .foregroundColor(.primary)
                            }
                            Spacer()
                            Text("New Post")
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                            Spacer()
                            Button {
                                Task {
                                    // Check if any field is empty
                                    if title.isEmpty || caption.isEmpty || organizer.isEmpty || organization.isEmpty || location.isEmpty
                                    {
                                        
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
                                                currentTime: formattedCurrentTime,
                                                pastTime: formattedPastTime,
                                                
                                                link1: link1,
                                                link2: link2
                                                //                                            link3: link3,
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
                                    .foregroundColor(.primary)
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
                        .padding(16)
                        
                        // Post image and caption
                        ZStack{
                            VStack{
                                PhotosPicker(selection: $viewModel.selectedImage) {
                                    HStack(spacing: 8) {
                                        
                                        if let image = viewModel.postImage
                                        {
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 350, height: 350)
                                                .clipShape(.rect(cornerRadius: 15))
                                                .shadow(color: Color.black, radius: 10, x: 0, y: 0)
                                                .padding(.top, 15)
                                        }
                                        else
                                        {
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 15)
                                                    .foregroundStyle(lightGrayColor)
                                                    .frame(width: 350, height: 350) // Sets the frame size
                                                    .shadow(color: Color.black, radius: 10, x: 0, y: 0)
                                                
                                                VStack {
                                                    Image(systemName: "photo.on.rectangle.angled")
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(width: 100, height: 100)
                                                        .foregroundColor(Color(.gray))
                                                    
                                                    Text("Tap to select image")
                                                        .foregroundStyle(Color.gray)
                                                        .padding(.top, 15)
                                                }

                                            }
                                            .padding(.top, 15)
                                            .padding(.bottom,15)
                                            
                                        }
                                    }
                                }
                            }
                        }
                        
                        ZStack {
                            Color(colorScheme == .dark ? .black : .white)
                                .ignoresSafeArea()
                            VStack {
                                //                            RoundedRectangle(cornerRadius: 20)
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(colorScheme == .dark ? Color(red: 0.1, green: 0.1, blue: 0.1) : Color.white)
                                            
                                    .shadow(color: colorScheme == .dark ? Color.white.opacity(0.1) : Color.black.opacity(0.25), radius: 10, x: 0, y: 0)
                                            .ignoresSafeArea()
                            }
                            .padding(.horizontal, 35) // Add padding to the outer VStack to ensure border visibility and spacing
                            .padding(.vertical)
                            .cornerRadius(20)
                            
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Event Info")
                                        .padding(.top, 35)
                                        .font(.title2)
                                        .bold()
                                        .foregroundColor(.primary)
                                }
                                Text("Add information about your event.")
                                    .padding(.bottom, 10)
                                    .foregroundColor(.primary)
                                
                                
                                HStack {
                                    Text("Event Name")
                                        .foregroundColor(.primary)
                                    Text("*")
                                        .foregroundColor(.red)
                                }
                                
                                ZStack(alignment: .leading) {
                                    Image(systemName: "party.popper.fill")
                                        .foregroundColor(.primary)
                                        .padding(.horizontal, 15)
                                    if title.isEmpty {
                                        Text("Event Name")
                                            .padding(.horizontal, 50)
                                            .foregroundColor(Color(.lightGray))
                                    }
                                    TextField("", text: $title)
                                        .foregroundColor(.primary)
                                        .accentColor(.primary)
                                        .padding(.horizontal, 50)
                                }
                                .frame(width: 325, height: 40)
                                .background(Color.gray.opacity(0.2))
                                .autocapitalization(.none)
                                .cornerRadius(10)
                                
                                HStack {
                                    Text("Description")
                                        .padding(.top, 10)
                                        .foregroundColor(.primary)
                                    Text("*")
                                        .foregroundColor(.red)
                                        .padding(.top, 15)
                                }
                                
                                ZStack(alignment: .leading) {
                                    Image(systemName: "text.bubble.fill")
                                        .foregroundColor(.primary)
                                        .offset(x:-2,y:-48)
                                    
                                    if caption.isEmpty {
                                        Text("Event description.")
                                            .offset(x:-39,y:-50)
                                            .foregroundColor(Color(.lightGray))
                                            .frame(width:280)
                                    }

                                    
                                    MultilineTextField(text: $caption)
                                        .offset(y:7)
                                        .padding(.leading, 26)
                                        .frame(width: 290, height: 150)
                                        .foregroundColor(.primary)
                                    
                                }
                                .frame(width: 325, height: 150)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)

                                
                                HStack {
                                    Text("Organization")
                                        .padding(.top, 10)
                                        .foregroundColor(.primary)
                                    Text("*")
                                        .foregroundColor(.red)
                                        .padding(.top, 15)
                                }
                                
                                ZStack(alignment: .leading) {
                                    Image(systemName: "figure.2")
                                        .foregroundColor(.primary)
                                        .padding(.horizontal, 15)
                                    if organization.isEmpty {
                                        Text("Club name or Organization")
                                            .padding(.horizontal, 50)
                                            .foregroundColor(Color(.lightGray))
                                        
                                    }
                                    
                                    TextField("", text: $organization)
                                        .foregroundColor(.primary)
                                        .accentColor(.primary)
                                        .padding(.horizontal, 50)
                                }
                                .frame(width: 325, height: 40)
                                .background(Color.gray.opacity(0.2))
                                .autocapitalization(.none)
                                .cornerRadius(10)
                                
                                HStack {
                                    Text("Organizer")
                                        .padding(.top, 10)
                                        .foregroundColor(.primary)
                                    Text("*")
                                        .foregroundColor(.red)
                                        .padding(.top, 15)
                                }
                                
                                ZStack(alignment: .leading) {
                                    Image(systemName: "person.fill")
                                        .foregroundColor(.primary)
                                        .padding(.horizontal, 20)
                                    if organizer.isEmpty {
                                        Text("Organizer's Name")
                                            .padding(.horizontal, 50)
                                            .foregroundColor(Color(.lightGray))
                                        
                                    }
                                    
                                    TextField("", text: $organizer)
                                        .foregroundColor(.primary)
                                        .accentColor(.primary)
                                        .padding(.horizontal, 50)
                                }
                                .frame(width: 325, height: 40)
                                .background(Color.gray.opacity(0.2))
                                .autocapitalization(.none)
                                .cornerRadius(10)
                                
                                HStack {
                                    Text("Location")
                                        .padding(.top, 10)
                                        .foregroundColor(.primary)
                                    Text("*")
                                        .foregroundColor(.red)
                                        .padding(.top, 15)
                                }
                                
                                HStack {
                                    ZStack(alignment: .leading) {
                                        Image(systemName: "location.fill")
                                            .foregroundColor(.primary)
                                            .padding(.horizontal, 20)
                                        if location.isEmpty {
                                            Text("Event Location")
                                                .padding(.horizontal, 50)
                                                .foregroundColor(Color(.lightGray))
                                            
                                        }
                                        
                                        TextField("", text: $location)
                                            .foregroundColor(.primary)
                                            .accentColor(.primary)
                                            .padding(.horizontal, 50)
                                    }
                                    .frame(width: 325, height: 40)
                                    .background(Color.gray.opacity(0.2))
                                    .autocapitalization(.none)
                                    .cornerRadius(10)
                                }
                                
                                HStack {
                                    Text("Date")
                                        .font(.title2)
                                        .bold()
                                        .padding(.top, 5)
                                        .foregroundColor(.primary)
                                    Text("*")
                                        .foregroundColor(.red)
                                        .padding(.top, 15)
                                }
                                
                                // Start Time
                                Section(header:Text("Start Time")) {
                                    HStack {
                                        Image(systemName: "calendar")
                                            .foregroundColor(.primary)
                                            .font(.system(size: 30))
                                            .offset(x:7)
                                        DatePicker("", selection: $currentTime, in: Date()...)
                                    }
                                    .padding()
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(8)
                                    .frame(width: 325, height: 50)
                                }
                                .padding(.top,0)
                                .padding(.bottom, 12)
                                .foregroundColor(.primary)
                                
                                // End Time
                                
                                Section(header:Text("End Time")) {
                                    HStack {
                                        Image(systemName: "calendar")
                                            .foregroundColor(.primary)
                                            .font(.system(size: 30))
                                            .offset(x:7)
                                        
                                        DatePicker("", selection: $pastTime, in: Date()...)
                                    }
                                    .padding()
                                    
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(8)
                                    .frame(width: 325, height: 50)
                                    
                                    
                                }
                                .padding(.top,10)
                                .foregroundColor(.primary)
                                
                                
                                
                                HStack {
                                    Text("Attachments")
                                        .font(.title2)
                                        .bold()
                                        .padding(.top, 15)
                                        .foregroundColor(.primary)
                                }
                                
                                HStack {
                                    Text("Link 1")
                                        .padding(.top, 0)
                                        .foregroundColor(.primary)
                                    
                                }
                                
                                HStack{
                                    ZStack(alignment: .leading) {
                                        Image(systemName: "link")
                                            .foregroundColor(.primary )
                                            .padding(.horizontal, 20)
                                        if link1.isEmpty {
                                            Text("Link 1")
                                                .padding(.horizontal, 50)
                                                .foregroundColor(Color(.lightGray))

                                        }

                                        TextField("", text: $link1)
                                            .foregroundColor(.black)
                                            .accentColor(.black)
                                            .padding(.horizontal, 50)
                                    }
                                    .frame(width: 325, height: 40)
                                    .background(Color.gray.opacity(0.2))
                                    .autocapitalization(.none)
                                    .cornerRadius(10)
                                }
                                    
                                HStack {
                                    Text("Link 2")
                                        .padding(.top, 5)
                                        .foregroundColor(.primary)
                                }

                                HStack {
                                    ZStack(alignment: .leading) {
                                        Image(systemName: "link")
                                            .foregroundColor(.primary)
                                            .padding(.horizontal, 20)
                                        if link2.isEmpty {
                                            Text("Link 2")
                                                .padding(.horizontal, 50)
                                                .foregroundColor(Color(.lightGray))

                                        }

                                        TextField("", text: $link2)
                                            .foregroundColor(.black)
                                            .accentColor(.black)
                                            .padding(.horizontal, 50)
                                    }
                                    .frame(width: 325, height: 40)
                                    .background(Color.gray.opacity(0.2))
                                    .autocapitalization(.none)
                                    .cornerRadius(10)
                                }

//                                HStack {
//                                    Text("Link 3")
//                                        .padding(.top, 0)
//                                        .foregroundColor(.primary)
//
//                                }
//
//                            HStack{
//                                ZStack(alignment: .leading) {
//                                    Image(systemName: "link")
//                                        .foregroundColor(.black)
//                                        .padding(.horizontal, 20)
//                                    if link3.isEmpty {
//                                        Text("Link")
//                                            .padding(.horizontal, 50)
//                                            .foregroundColor(Color(.lightGray))
//
//                                    }
//
//                                    TextField("", text: $link3)
//                                        .foregroundColor(.black)
//                                        .accentColor(.black)
//                                        .padding(.horizontal, 50)
//                                }
//                                .frame(width: 325, height: 40)
//                                .background(Color.gray.opacity(0.2))
//                                .autocapitalization(.none)
//                                .cornerRadius(10)
//                            }
                            }
                            .padding(.bottom,35)
                            .padding(.horizontal, 20)
                        }
                    }
                }
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
            link1 = ""
            link2 = ""
//        link3 = ""
        }
        
    }
    struct MultilineTextField: UIViewRepresentable {
        @Binding var text: String
        
        class Coordinator: NSObject, UITextViewDelegate {
            var parent: MultilineTextField
            
            init(parent: MultilineTextField) {
                self.parent = parent
            }
            
            func textViewDidChange(_ textView: UITextView) {
                parent.text = textView.text
            }
        }
        
        func makeCoordinator() -> Coordinator {
            Coordinator(parent: self)
        }
        
        func makeUIView(context: Context) -> UITextView {
            let textView = UITextView()
            textView.delegate = context.coordinator
            textView.isScrollEnabled = true
            textView.isEditable = true
            textView.isUserInteractionEnabled = true
            textView.font = UIFont.systemFont(ofSize: 17)
            textView.backgroundColor = UIColor.clear
//            textView.textColor = UIColor.black
            return textView
        }
        
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}
    
struct UploadPostView_Previews: PreviewProvider {
    static var previews: some View {
        UploadPostView(tabIndex: .constant(0))
    }
}
