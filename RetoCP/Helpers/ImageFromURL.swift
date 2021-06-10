//
//  ImageFromURL.swift
//  RetoCP
//
//  Created by Kevin Guanilo on 6/9/21.
//

import Foundation
import ImageSlideshow

public class ImageFromURL: NSObject, InputSource {
    
    public var url: URL
    public var placeholder: UIImage?
    
    public init(url: URL, placeholder: UIImage? = nil) {
        self.url = url
        self.placeholder = placeholder
        super.init()
    }
    
    public init?(urlString: String, placeholder: UIImage? = nil) {
        if let validUrl = URL(string: urlString) {
            self.placeholder = placeholder
            self.url = validUrl
            super.init()
        } else {
            return nil
        }
    }
    
    public func load(to imageView: UIImageView, with callback: @escaping (UIImage?) -> Void) {
        
        let finalurl = url
        guard let data = try? Data(contentsOf: finalurl) else {
            return callback(placeholder)
        }
        let image = UIImage(data: data)
        callback(image)
    }
}
