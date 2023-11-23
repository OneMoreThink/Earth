//
//  FileManagers.swift
//  Earth
//
//  Created by 이종선 on 11/21/23.
//

import UIKit

class UserImageManagers {
    
    static let shared = UserImageManagers() // Singleton
    private init(){}
    
    // MARK: Directory URL for UserImage
    private var documentsDirectory: URL {
           FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    
    // MARK: Save User Image
    func saveImage(_ image: UIImage, withName name: String) -> Bool {
        
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            return false
        }
        let fileURL = documentsDirectory.appendingPathComponent(name)
        
        do {
            try data.write(to: fileURL)
            return true
        } catch let error {
            print(error.localizedDescription)
            return false
        }
    }
    
    // MARK: Load User Image
    func loadImage(withName name: String) -> UIImage? {
        
        let fileURL = documentsDirectory.appendingPathComponent(name)
        
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}
