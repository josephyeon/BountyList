//
//  DetailViewController.swift
//  ch9_OnePiece
//
//  Created by 정현준 on 2021/03/24.
//  Copyright © 2021 hyeon. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: Chapter10 기존 MVC에서 MVVM으로 리팩터링
    // Model
    // - BountyInfo
    // > BountyInfo 만들자

    // View
    // - imgView, nameLabel, bountylabel
    // > view들은 viewModel를 통해서 구성되기 ?


    // ViewModel
    // - DetailViewModel
    // > 뷰레이어에서 필요한 메서드 만들기
    // > 모델 가지고 있기 ,, BountyInfo 들

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!


    // MARK: MVVM(1): Model - BountyInfo
    let viewModel = DetailViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    func updateUI() {

        if let bountyInfo = viewModel.bountyInfo {
                   imgView.image = bountyInfo.image
                   nameLabel.text = bountyInfo.name
                   bountyLabel.text = "\(bountyInfo.bounty)"
               }
    }

    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: MVVM(2): ViewModel - DetailViewModel
class DetailViewModel {
    var bountyInfo: BountyInfo?

    func update(model: BountyInfo) {
        bountyInfo = model

    }

}
