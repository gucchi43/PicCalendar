//
//  PIcCollectionViewController.swift
//  selectDayPic
//
//  Created by HIroki Taniguti on 2016/10/19.
//  Copyright © 2016年 HIroki Taniguti. All rights reserved.
//

import UIKit
import Photos

class PIcCollectionViewController: UIView, UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {

    var collectionView:UICollectionView!

    override init(frame: CGRect) {
        super.init(frame: frame)

        // レイアウト作成
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .Horizontal
        flowLayout.minimumInteritemSpacing = 2.0
        flowLayout.minimumLineSpacing = 2.0
        flowLayout.itemSize = CGSizeMake(frame.height, frame.width / 2)

        // コレクションビュー作成
        collectionView = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.greenColor()
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self

        addSubview(collectionView)

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = PicDataArray.sharedSingleton.PicOneDayAssetArray.count
        return count
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //選択した時の処理

    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as UICollectionViewCell
        let imageView = UIImageView()
        imageView.sizeThatFits(cell.bounds.size)

        let asset = PicDataArray.sharedSingleton.PicOneDayAssetArray[indexPath.row]
        assetToImage(asset, imageView: imageView)

        return cell
    }

    func assetToImage(asset: PHAsset, imageView: UIImageView)
    {
        let manager: PHImageManager = PHImageManager()
        manager.requestImageForAsset(asset,
                                     targetSize: imageView.bounds.size,
                                     contentMode: .AspectFill,
                                     options: nil) { (image, info) -> Void in
                                        // 取得したimageをUIImageViewなどで表示する
                                        imageView.image = image
        }
    }
}
