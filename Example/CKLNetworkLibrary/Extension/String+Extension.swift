//
//  UIImage+Extension.swift
//  Exemple
//
//  Created by Ricardo Cherobin on 10/07/20.
//  Copyright © 2020 Ricardo Cherobin. All rights reserved.
//

import UIKit

extension String {
    
    func base64ToImage() -> UIImage? {
        if let url = URL(string: self),let data = try? Data(contentsOf: url),let image = UIImage(data: data) {
            return image
        }
        return nil
    }
}
