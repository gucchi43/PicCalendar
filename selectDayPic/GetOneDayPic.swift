//
//  GetOneDayPic.swift
//  selectDayPic
//
//  Created by HIroki Taniguti on 2016/10/19.
//  Copyright © 2016年 HIroki Taniguti. All rights reserved.
//

import UIKit
import Photos
import SwiftDate

class GetOneDayPic: NSObject {

    //選択した日にちの00:00:00のNSDateをゲット（その日のタイムライン絞るのに使用）
    //引数無しの場合currentDateが使われる（LogViewなどから使われる）
    //引数ありの場合（LookBackから使われる）
    func filterDateStart(targetDate: NSDate) -> NSDate {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        formatter.calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)!  // 24時間表示対策
        formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)

        let formatDate = formatter.dateFromString(String(targetDate.year) + "/" +
            String(targetDate.month) + "/" +
            String(targetDate.day) + " 00:00:00")!

        print("FilterDateStart", formatDate)
        return formatDate
    }

    //選択した日にちの23:59:59のNSDateをゲット（その日のタイムライン絞るのに使用）
    //引数無しの場合currentDateが使われる（LogViewなどから使われる）
    //引数ありの場合（LookBackから使われる）
    func filterDateEnd(targetDate: NSDate) -> NSDate {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        formatter.calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)!  // 24時間表示対策
        formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)

        let formatDate = formatter.dateFromString(String(targetDate.year) + "/" +
            String(targetDate.month) + "/" +
            String(targetDate.day) + " 23:59:59")!

        print("FilterDateEnd", formatDate)
        return formatDate
    }


    func getOnePicData(date: NSDate) {
        //その日のカメラロールの画像を取得する。
        PicDataArray.sharedSingleton.PicOneDayAssetArray.removeAll()
        PicDataArray.sharedSingleton.PicOneDayImageArray.removeAll()

        let fromDate = self.filterDateStart(date)
        let toDate = self.filterDateEnd(date)
        // オプションを指定してフェッチします
        let fetchOption = PHFetchOptions()
        fetchOption.predicate = NSPredicate(format: "(creationDate >= %@) and (creationDate) < %@", fromDate, toDate)
        fetchOption.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        print("fetchOption : ",fetchOption.description)
        var assets:PHFetchResult = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: fetchOption)
        print(assets.debugDescription)
        print("fromDate, assetsのカウント : ",fromDate, assets.count)
        assets.enumerateObjectsUsingBlock({ obj, idx, stop in

            if obj is PHAsset
            {
                let asset:PHAsset = obj as! PHAsset;
                print("Asset IDX:\(idx)");
                print("mediaType:\(asset.mediaType)");
                print("mediaSubtypes:\(asset.mediaSubtypes)");
                print("pixelWidth:\(asset.pixelWidth)");
                print("pixelHeight:\(asset.pixelHeight)");
                print("creationDate:\(asset.creationDate)");
                print("modificationDate:\(asset.modificationDate)");
                print("duration:\(asset.duration)");
                print("favorite:\(asset.favorite)");
                print("hidden:\(asset.hidden)");
                self.setAssetArry(asset)
                self.assetToImage(asset)
            }
        })
    }

    func setAssetArry(asset: PHAsset) {
        PicDataArray.sharedSingleton.PicOneDayAssetArray.append(asset)
    }

    func assetToImage(asset: PHAsset) {
        let manager: PHImageManager = PHImageManager()
        manager.requestImageForAsset(asset,
                                     targetSize: CGSizeMake(500, 500),
                                     contentMode: .AspectFill,
                                     options: nil) { (image, info) -> Void in
                                        // 取得したimageをUIImageViewなどで表示する
                                        PicDataArray.sharedSingleton.PicOneDayImageArray.append(image!)
        }
    }
}
