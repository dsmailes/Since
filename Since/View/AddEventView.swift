//
//  AddEventView.swift
//  Since
//
//  Created by David Smailes on 22/10/2020.
//

import SwiftUI

struct AddEventView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showingImagePicker = false
    
    @State private var date = Date()
    @State private var details: String = ""
    @State private var id = UUID.init()
    @State private var image: String = ""
    @State private var timestamp = Date()
    @State private var title: String = ""
    
    @State private var inputImage: UIImage?
    @State private var eventImage: Image?
    
    @State private var errorShowing: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    
    private var imageHandler = ImageHandler()
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        eventImage = Image(uiImage: inputImage)
    }
    
    func saveEvent() {
        if self.details != "" && self.title != "" {
            let event = SinceEvent(context: managedObjectContext)
            event.details = self.details
            event.title = self.title
            event.date = self.date
            
            if inputImage != nil {
                event.image = imageHandler.randomString(length: 20)
                imageHandler.store(image: inputImage!, forKey: event.image!, withStorageType: .fileSystem)
            }
            
            do {
                try self.managedObjectContext.save()
                print(event)
                self.presentationMode.wrappedValue.dismiss()
            } catch {
                print(error)
            }
            
        }
        
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Form {
                        TextField("Since", text: $title)
                            .padding()
                            .background(Color(UIColor.lightGray))
                            .cornerRadius(12.0)
                            .font(.system(size: 24, weight: .bold, design: .default))
                        TextField("Details", text: $details)
                            .padding()
                            .background(Color(UIColor.lightGray))
                            .cornerRadius(12.0)
                            .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                            .font(.system(size: 20, weight: .medium, design: .default))
                        DatePicker("Date", selection: $date)
                                .padding()
                        Button("Add photo") {
                            self.showingImagePicker = true
                        }
                        .font(.system(size: 24, weight: .bold, design: .default))
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color(UIColor.systemBlue))
                        .foregroundColor(Color.white)
                        .cornerRadius(12.0)
                        Button("Save") {
                            saveEvent()
                        }
                        .font(.system(size: 24, weight: .bold, design: .default))
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color(UIColor.systemTeal))
                        .foregroundColor(Color.white)
                        .cornerRadius(12.0)
                    }
                } // vstack
            } // ZStack
        } // nav
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
    }
}

struct AddEventView_Previews: PreviewProvider {
    static var previews: some View {
        AddEventView()
    }
}
