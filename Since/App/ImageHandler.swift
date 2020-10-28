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
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0...length-1).map{ _ in letters.randomElement()! })
    }
    
    func store(image: UIImage, forKey key: String, withStorageType storageType: StorageType) {
        if let pngRepresentation = image.jpegData(compressionQuality: 0.5) {
            switch storageType {
            case .fileSystem:
                if let filePath = filePath(forKey: key) {
                    do  {
                        try pngRepresentation.write(to: filePath, options: .atomic)
                    } catch let err {
                        print("Saving file resulted in error: ", err)
                    }
                }
            case .userDefaults:
                UserDefaults.standard.set(pngRepresentation, forKey: key)
            }
        }
    }
    
    func retrieveImage(forKey key: String, inStorageType storageType: StorageType) -> UIImage? {
        switch storageType {
        case .fileSystem:
            if let filePath = self.filePath(forKey: key),
                let fileData = FileManager.default.contents(atPath: filePath.path),
                let image = UIImage(data: fileData) {
                return image
            }
        case .userDefaults:
            if let imageData = UserDefaults.standard.object(forKey: key) as? Data,
                let image = UIImage(data: imageData) {
                return image
            }
        }
        
        return nil
    }
    
    func filePath(forKey key: String) -> URL? {
        //let fileManager = FileManager.default
        //guard let documentURL = fileManager.urls(for: .documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first else { return nil }
        
        let documentURL = AppGroup.since.containerURL
        
        return documentURL.appendingPathComponent(key + ".jpg")
    }
    
    func getEventImage(imageName: String) -> UIImage {
        
        if let img = retrieveImage(forKey: imageName, inStorageType: .fileSystem) {
            return img
        } else {
            return UIImage(named: "sincelogo")!
        }
        
    }
    
}
