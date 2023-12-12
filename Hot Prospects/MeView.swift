//
//  MeView.swift
//  Hot Prospects
//
//  Created by Vito Borghi on 29/11/2023.
//

import SwiftData
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct MeView: View {
    @Environment(\.modelContext) var modelContext
    @Query var prospects: [Prospect]
    
    @State private var name = "Anonymous"
    @State private var email = "you@yoursite.com"
    @State private var qrCode = UIImage()
    
    let imageContext = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationStack {
            VStack{
                Form {
                    TextField("Name", text: $name)
                        .textContentType(.name)
                        .font(.title)
                    
                    TextField("Email Address", text: $email)
                        .textContentType(.emailAddress)
                        .font(.title)
                    
                    Button("Save"){
                        saveCode()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                }
                
                Image(uiImage: qrCode)
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    //.frame(width: 200, height: 200)
                    .contextMenu {
                        Button {
                            let saver = ImageSaver()
                            saver.writeToPhotoAlbum(image: qrCode)
                        } label: {
                             Label("Save to Photos", systemImage: "square.and.arrow.down")
                        }
                    }
            }
            .navigationTitle("Your code")
            .onAppear(perform: loadCode)
            //.onChange(of: name) { _,_ in updateCode() }
            //.onChange(of: email) { _,_ in updateCode() }
        }
    }
    func loadCode() {
        qrCode = generateQRCode(from: "\(name)\n\(email)")
        //get prospect where .isSelf == true
        let predicate = #Predicate<Prospect> { prospect in
            prospect.isSelf == true
        }
        let  descriptor = FetchDescriptor(predicate: predicate)
        let selfProspect = try? modelContext.fetch(descriptor)
        //if it exists
        if let selfProspect = selfProspect {
            if !selfProspect.isEmpty {
                //update name with self.name
                name = selfProspect[0].name
                //update email with email
                email = selfProspect[0].emailAddress
            }
            else {
                //create new prospect
                let newSelf = Prospect(name: name, emailAddress: email, isSelf: true)
                modelContext.insert(newSelf)
            }
        }
    }
    
    func saveCode() {
        let predicate = #Predicate<Prospect> { prospect in prospect.isSelf == true }
        let  descriptor = FetchDescriptor(predicate: predicate)
        let selfProspect = try? modelContext.fetch(descriptor)
        if let selfProspect = selfProspect {
            if !selfProspect.isEmpty {
                selfProspect[0].name = name
                selfProspect[0].emailAddress = email
            }
        }
        
    }
    
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            if let cgImage = imageContext.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)

            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

#Preview {
    MeView()
}
