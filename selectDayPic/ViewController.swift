//
//  ViewController.swift
//  selectDayPic
//
//  Created by HIroki Taniguti on 2016/10/17.
//  Copyright © 2016年 HIroki Taniguti. All rights reserved.
//

import UIKit
import Photos
import SwiftDate



class ViewController: UIViewController {

    var photosMonth = [Photos]()

    struct Photos {
        var exist: Bool = false
        var photos: [PHAsset] = []
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tapSecondButton(sender: AnyObject) {
        getAllPic()
    }

    @IBAction func tapFourButton(sender: AnyObject) {
        print("Calendarに遷移")
    }

    func getAllPic() {
        //全てのカメラロールの画像を取得する。

            // オプションを指定してフェッチします
            let fetchOption = PHFetchOptions()
            //        fetchOption.predicate = NSPredicate(format: "(creationDate >= %@) and (creationDate) < %@", fromDate!, toDate)
            fetchOption.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

            var assets:PHFetchResult = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: fetchOption)
            print(assets.debugDescription);
            assets.enumerateObjectsUsingBlock({ obj, idx, stop in

                if obj is PHAsset
                {
                    let asset:PHAsset = obj as! PHAsset
                    print("Asset IDX:\(idx)")
                    print("mediaType:\(asset.mediaType)")
                    print("mediaSubtypes:\(asset.mediaSubtypes)")
                    print("pixelWidth:\(asset.pixelWidth)")
                    print("pixelHeight:\(asset.pixelHeight)")
                    print("creationDate:\(asset.creationDate)")
                    print("modificationDate:\(asset.modificationDate)")
                    print("duration:\(asset.duration)")
                    print("favorite:\(asset.favorite)")
                    print("hidden:\(asset.hidden)")
                    let kyeString = (asset.creationDate!.toString(DateFormat.Custom("yyyy/MM")))!
                    let dateString = (asset.creationDate!.toString(DateFormat.Custom("yyyyMMdd")))! + "&p"
                    let keyWeekString = (asset.creationDate!.toString(DateFormat.Custom("yyyy")))! + String(asset.creationDate!.weekOfYear)

                    self.setPicArrayData(kyeString, dateString: dateString)
                    self.setPicWeekArrayData(keyWeekString, dateString: dateString)
                }
            })
    }

    func setPicWeekArrayData(keyString: String, dateString: String) {
            //                        let dayString = created_at.substringToIndex(created_at.startIndex.advancedBy(3))

            if PicDataArray.sharedSingleton.PicDayWeekDic[keyString]?.isEmpty == false { //keyがあるか？ value = [String]のはず
                //keyがあった時
                if (PicDataArray.sharedSingleton.PicDayWeekDic[keyString]! as [String]).last != dateString { //valuesの中の最後が追加するStringと同じか？
                    //Stringが違う時
                    let newValues = PicDataArray.sharedSingleton.PicDayWeekDic[keyString]! as [String] + [dateString]
                    print("oldValues : ", PicDataArray.sharedSingleton.PicDayWeekDic[keyString]! as [String])
                    print("newValues : ", newValues)
                    print("前の PicDayWeekDic", PicDataArray.sharedSingleton.PicDayWeekDic[keyString])
                    PicDataArray.sharedSingleton.PicDayWeekDic.updateValue(newValues, forKey: keyString)
                    print("後の PicDayWeekDic", PicDataArray.sharedSingleton.PicDayWeekDic[keyString])
                    print("後の PicDayWeekDic All ver", PicDataArray.sharedSingleton.PicDayWeekDic)
                }else {
                    //Stringが同じ時
                    print("もうこのValuesは追加されている")
                }
            } else {
                //keyがなかった時
                PicDataArray.sharedSingleton.PicDayWeekDic.updateValue([dateString], forKey: keyString)
                print("新しいkeyの PicDayWeekDic All ver", PicDataArray.sharedSingleton.PicDayWeekDic)
            }
    }

    func setPicArrayData(keyString: String, dateString: String) {
        //                        let dayString = created_at.substringToIndex(created_at.startIndex.advancedBy(3))

        if PicDataArray.sharedSingleton.PicDayDic[keyString]?.isEmpty == false { //keyがあるか？ value = [String]のはず
            //keyがあった時
            if (PicDataArray.sharedSingleton.PicDayDic[keyString]! as [String]).last != dateString { //valuesの中の最後が追加するStringと同じか？
                //Stringが違う時
                let newValues = PicDataArray.sharedSingleton.PicDayDic[keyString]! as [String] + [dateString]
                print("oldValues : ", PicDataArray.sharedSingleton.PicDayDic[keyString]! as [String])
                print("newValues : ", newValues)
                print("前の PicDayDic", PicDataArray.sharedSingleton.PicDayDic[keyString])
                PicDataArray.sharedSingleton.PicDayDic.updateValue(newValues, forKey: keyString)
                print("後の PicDayDic", PicDataArray.sharedSingleton.PicDayDic[keyString])
                print("後の PicDayDic All ver", PicDataArray.sharedSingleton.PicDayDic)
            }else {
                //Stringが同じ時
                print("もうこのValuesは追加されている")
            }
        } else {
            //keyがなかった時
            PicDataArray.sharedSingleton.PicDayDic.updateValue([dateString], forKey: keyString)
            print("新しいkeyの PicDayDic All ver", PicDataArray.sharedSingleton.PicDayDic)
        }
    }
}

