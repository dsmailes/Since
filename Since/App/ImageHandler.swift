//
//  ImageHandler.swift
//  Since
//
//  Created by David Smailes on 26/10/2020.
//

import Foundation
import UIKit

class ImageHandler {
    
    enum StorageType {
        case userDefaults
        case fileSystem
    }
    
    static let sharedInstance = ImageHandler()
    
    //generate a random string for the filename
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0...length-1).map{ _ in letters.randomElement()! })
    }
    
    //convert to jpg and compress to reduce storage usage
    func store(image: UIImage, forKey key: String, withStorageType storageType: StorageType) {
        if let jpgRepresentation = image.jpegData(compressionQuality: 0.5) {
            switch storageType {
            case .fileSystem:
                //save to local storage
                if let filePath = filePath(forKey: key) {
                    do  {
                        try jpgRepresentation.write(to: filePath, options: .atomic)
                    } catch let err {
                        print("Saving file resulted in error: ", err)
                    }
                }
                //this is never executed at the moment
            case .userDefaults:
                UserDefaults.standard.set(jpgRepresentation, forKey: key)
            }
        }
    }
    
    func retrieveImage(forKey key: String, inStorageType storageType: StorageType) -> UIImage? {
        switch storageType {
        case .fileSystem:
            //retrieve the image from local storage
            if let filePath = self.filePath(forKey: key),
                let fileData = FileManager.default.contents(atPath: filePath.path),
                let image = UIImage(data: fileData) {
                return image
            }
            //this is never executed at the moment
        case .userDefaults:
            if let imageData = UserDefaults.standard.object(forKey: key) as? Data,
                let image = UIImage(data: imageData) {
                return image
            }
        }
        
        return nil
    }
    //get the path of the local image
    func filePath(forKey key: String) -> URL? {
        
        let documentURL = AppGroup.since.containerURL
        
        return documentURL.appendingPathComponent(key + ".jpg")
    }
    
    //get the image or return the Since logo if the image doesn't exist
    func getEventImage(imageName: String) -> UIImage {
        
        if let img = retrieveImage(forKey: imageName, inStorageType: .fileSystem) {
            return img
        } else {
            return UIImage(named: "sincelogo")!
        }
        
    }
    
}
