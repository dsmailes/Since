//
//  EditItemView.swift
//  Since
//
//  Created by David Smailes on 29/10/2020.
//

import SwiftUI

struct EditItemView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var event: SinceEvent
    
    @State private var showingImagePicker = false
    
    @State private var date = Date()
    @State private var id = UUID.init()
    @State private var image: String = ""
    @State private var title: String = ""
    
    @State private var inputImage: UIImage?
    @State private var eventImage: Image?
    
    @State private var errorShowing: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        eventImage = Image(uiImage: inputImage)
    }
    
    func saveEvent() {
        if self.title != "" {
            if inputImage != nil && event.image != nil {
                ImageHandler.sharedInstance.store(image: inputImage!, forKey: event.image!, withStorageType: .fileSystem)
            }
            
            event.title = self.title
            event.date = self.date
            event.image = self.image
            
            do {
                try self.managedObjectContext.save()
                print(event)
                self.presentationMode.wrappedValue.dismiss()
                
            } catch {
                print(error)
            }
            
        } else {
            self.errorShowing = true
            self.errorTitle = "Missing event title"
            self.errorMessage = "Please enter a title for the event"
            return
        }
    }
    
    
    var body: some View {
        NavigationView {
            
                VStack {
                    Form {
                        Section(header: Text("What happened?")) {
                            TextField("Title", text: $title)
                                .padding()
                                .background(Color(UIColor.systemBackground))
                                .cornerRadius(12.0)
                                .font(.system(size: 24, weight: .bold, design: .default))
                            
                        }
                        
                        Section(header: Text("When did it happen?")) {
                            DatePicker("Date", selection: $date)
                                    .padding()
                            
                            Button("Reset") {
                                self.date = Date()
                            }
                            .font(.system(size: 24, weight: .bold, design: .default))
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color(UIColor.systemPurple))
                            .foregroundColor(Color.white)
                            .cornerRadius(12.0)
                                
                        }
                        
                        Section(header: Text("Do you have a picture?")) {
                            VStack(alignment: .center) {
                                Button("Add photo") {
                                    self.showingImagePicker = true
                                }
                                .font(.system(size: 24, weight: .bold, design: .default))
                                .padding()
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .background(Color(UIColor.systemBlue))
                                .foregroundColor(Color.white)
                                .cornerRadius(12.0)
                                
                                if inputImage != nil {
                                    Image(uiImage: inputImage!)
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(12.0)
                                        .frame(maxHeight: 150)
                                }
                            }
                            
                        }
                            Section(header: Text("Save")) {
                                Button("Save") {
                                    saveEvent()
                                }
                                .font(.system(size: 24, weight: .bold, design: .default))
                                .padding()
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .background(Color(UIColor.systemGreen))
                                .foregroundColor(Color.white)
                                .cornerRadius(12.0)
                            }
                    
                    } // form
                    
                } // vstack
                .onAppear() {
                    self.date = event.date ?? Date()
                    self.id = event.id ?? UUID.init()
                    self.title = event.title ?? ""
                    self.image = event.image ?? ""
                    if self.image != "" {
                        self.inputImage = ImageHandler.sharedInstance.retrieveImage(forKey: self.image, inStorageType: .fileSystem)
                    }
                    
                }
                .alert(isPresented: $errorShowing) {
                    Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                }
            .navigationBarTitle("", displayMode: .inline)
            .edgesIgnoringSafeArea([.top, .bottom])
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        } // nav
        
        
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
    }
}

struct EditItemView_Previews: PreviewProvider {
    static var previews: some View {
        EditItemView(event: SinceEvent.init())
    }
}
