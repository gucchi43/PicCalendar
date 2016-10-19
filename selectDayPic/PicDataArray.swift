//
//  PicDataArray.swift
//  selectDayPic
//
//  Created by HIroki Taniguti on 2016/10/18.
//  Copyright © 2016年 HIroki Taniguti. All rights reserved.
//

import UIKit
import Photos


final class PicDataArray {
    private init() {
    }
    static let sharedSingleton = PicDataArray()

    var PicDayDic = [String: [String]]()
    var PicOneDayAssetArray = [PHAsset]()
    var PicOneDayImageArray = [UIImage]()
}
