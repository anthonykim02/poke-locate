//
//  Error.swift
//  pokemonGoAssistant
//
//  Created by Kunal Desai on 8/12/16.
//  Copyright © 2016 anthonykim. All rights reserved.
//

import UIKit

class Error: UIView {
    
    var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.backgroundColor = UIColor().HexToColor("#ff4d4d", alpha: 1.0)
        let labelWidth = frame.width
        let labelHeight = frame.height / 2
        let labelFrame = CGRect(x: 0, y: frame.height - labelHeight, width: labelWidth, height: labelHeight)
        label = UILabel(frame: labelFrame)
        label.font = UIFont(name: "Aleo-Regular", size: frame.height / 4)
        label.text = "Error"
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.whiteColor()
        
        self.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
