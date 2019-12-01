//
//  FeedbackContentDetail.swift
//  Creativ
//
//  Created by William Inx on 15/11/19.
//  Copyright © 2019 William Inx. All rights reserved.
//

import Foundation

struct FeedbackContentDetailModel {
    var type:String
    var score:Int
    var overview:String
    
    init() {
        self.type = ""
        self.score = 0
        self.overview = ""
    }
}
