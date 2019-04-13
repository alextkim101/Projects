//
//  EventCell.swift
//  FOMO_V2
//
//  Created by Samuel Kyu-Seo Lee on 12/21/18.
//  Copyright © 2018 Samuel Kyu-Seo Lee. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class EventCell: BaseCell {
    
    var event: Event? {
        didSet {
            titleLabel.text = event?.title
            
//            setupThumbnailImage() // <--- thumbnail images from the web
//            setupProfileImage() // <--- profile images from the web
            
            thumbnailImageView.image = UIImage (named: (event?.thumbNailImageName)!) //FOR NOW USE THIS. LATER USE THE FUCNTION ABOVE
            
            if let profileImageName = event?.channel?.profileImageName { //FOR NOW USE THIS. LATER USE THE FUCNTION ABOVE
                userProfileImageView.image = UIImage(named: profileImageName)
                
            }
            if let channelName = event?.channel?.name, let date = event?.date {
     
                let subtitleText = "\(String(describing: channelName)) • Event Date: \(String(describing: date)) "
                subtitleTextView.text = subtitleText
            }
            //measure title txt
            if let title = event?.title {
                let size = CGSize(width: frame.width-16-44-8-16, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string:title).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14)], context: nil)
                if estimatedRect.size.height > 20 {
                    titleLabelHeightConstraint?.constant = 44
                } else {
                    titleLabelHeightConstraint?.constant = 20
                }
            }

        }
    }
//    func setupProfileImage() {
//        if let profileImageUrl  = event?.channel?.profileImageName {
// userProfileImageView.loadImageUsingUrlString(profileImageUrl) <-- FUNCTION IMPLEMENTED IN EXTENSIONS UNDER HELPERS. CAN DELETE EVERY THING BELOW ONCE IMPLEMENTED
//            let url = NSURL(string: profileImageUrl)
//            URLSession.shared.dataTask(with: url! as URL, completionHandler: {(data, responses, error) in
//                if error != nil {
//                    print(error!)
//                    return
//                }
//
//
//                dispatch_async(dispatch_get_main_queue(), {
//                      self.thumbnailImageView.image = UIImage(data: data!)
//                })
//                self.userProfileImageView.image = UIImage(data: data!)
//            }).resume()
//
//        }
//    }
//    func setupThumbnailImage () {
//        if let thumbnailImageUrl  = event?.thumbNailImageName {
    // thumbnailImageView.loadImageUsingUrlString(profileImageUrl) <-- FUNCTION IMPLEMENTED IN EXTENSIONS UNDER HELPERS. CAN DELETE EVERY THING BELOW ONCE IMPLEMENTED
//            let url = NSURL(string: thumbnailImageUrl)
//            URLSession.shared.dataTask(with: url! as URL, completionHandler: {(data, responses, error) in
//                if error != nil {
//                    print(error!)
//                    return
//                }
//     
//
////                dispatch_async(dispatch_get_main_queue(), {
////                      self.thumbnailImageView.image = UIImage(data: data!)
////                })
//                self.thumbnailImageView.image = UIImage(data: data!)
//            }).resume()
//           // print(thumbnailImageUrl)
//        }
//    }
    
    let thumbnailImageView: UIImageView = {
        let imageView  = UIImageView()
        imageView.image = UIImage(named: "viterbi_careerfair" )
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    let userProfileImageView: UIImageView = {
        let imageView  = UIImageView()
        imageView.image = UIImage(named: "USCViterbi")
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Viterbi - Spring 2019 Career Fair"
        label.numberOfLines = 2
        return label
    }()
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    } ()
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Viterbi • 50 Companies Attending • Updated 2 days ago"
        textView.textContainerInset = UIEdgeInsets(top: 0,left: -4,bottom: 0,right: 0)
        textView.textColor = UIColor.lightGray
        return textView
    }()
    
    var titleLabelHeightConstraint: NSLayoutConstraint?
    
    override func setupViews(){
        addSubview(thumbnailImageView)
        addSubview(seperatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]", views: userProfileImageView)
        
        //vertical constraints
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbnailImageView, userProfileImageView, seperatorView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: seperatorView)
        //top constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        //left constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        //right constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        //height constraint
        
        titleLabelHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44)
        
        addConstraint(titleLabelHeightConstraint!)
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        //left constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        //right constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        //height constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
    }
   
}


