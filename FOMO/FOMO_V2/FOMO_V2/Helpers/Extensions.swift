//
//  Extensions.swift
//  FOMO_V2
//
//  Created by Samuel Kyu-Seo Lee on 12/21/18.
//  Copyright © 2018 Samuel Kyu-Seo Lee. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...){
        var viewsDictionary = [String: UIView] ()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

extension UIImage {
    func resizeImage(newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    } }

//extension UIImageView {
//    func loadImageUsingUrlString (urlString: String) {
//
//        let url = NSURL(string: urlString)
//        URLSession.shared.dataTask(with: url! as URL, completionHandler: {(data, responses, error) in
//            if error != nil {
//                print(error!)
//                return
//            }
//            dispatch_async(dispatch_get_main_queue()), {
//                  self.image = UIImage(data: data!)
//            })
//
//        }).resume()
//       // print(thumbnailImageUrl)
//    }
//}
