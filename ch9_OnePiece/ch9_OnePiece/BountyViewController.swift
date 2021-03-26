//
//  BountyViewController.swift
//  ch9_OnePiece
//
//  Created by 정현준 on 2021/03/24.
//  Copyright © 2021 hyeon. All rights reserved.
//

// MARK: Ch9. 코드리뷰
/* 1. 현상금 순위대로 정렬되어야 하는데 안되어 있음
   2. 코드 깔끔하게 정리되어있지 않음*/

// MARK: MVVM ... 디자인 패턴으로 코드 정리하기
// Model
// - BountyInfo
// > BountyInfo 만들자

// View
// - ListCell
// > ListCell 필요한 정보를 ViewModel한테서 받아야겠다
// > ListCell은 ViewModel로 부터 받은 정보로 뷰 업데이트 하기

// ViewModel
// - BountyViewModel
// > BountyViewModel을 만들고, 뷰레이어에서 필요한 메서드 만들기
// > 모델 가지고 있기 ,, BountyInfo 들

import UIKit

class BountyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let viewModel = BountyViewModel()

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            let vc = segue.destination as? DetailViewController
            if let index = sender as? Int {
                let bountyInfo = viewModel.bountyInfo(at:index)
                vc?.viewModel.update(model:bountyInfo)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numOfBountyInfoList
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell else {
            return UITableViewCell()
        }
        let bountyInfo = viewModel.bountyInfo(at:indexPath.row)
        cell.update(info: bountyInfo)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("===> \(indexPath.row)")
        performSegue(withIdentifier: "showDetail", sender: indexPath.row)
    }

}

class ListCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!

    func update(info: BountyInfo) {
             imgView.image = info.image
             nameLabel.text = info.name
             bountyLabel.text = "\(info.bounty)"
    }
}

// MARK: MVVM(1): Model - BountyInfo
// 코드가 길어져서 BountyInfo.swift 파일로 빼냄 거기가서 참고 (NSObject)

// MARK: MVVM(2): ViewModel - BountyViewModel
class BountyViewModel {
    // 뷰 모델은 모델(데이터를) 가지고 있어야 한다
    let bountyInfoList: [BountyInfo] = [
        BountyInfo(name: "brook", bounty: 33000000),
        BountyInfo(name: "chopper", bounty: 50),
        BountyInfo(name: "franky", bounty: 44000000),
        BountyInfo(name: "luffy", bounty: 300000000),
        BountyInfo(name: "nami", bounty: 16000000),
        BountyInfo(name: "robin", bounty: 80000000),
        BountyInfo(name: "sanji", bounty: 77000000),
        BountyInfo(name: "zoro", bounty: 120000000)
    ]


    var sortedList: [BountyInfo] {     //MARK: 현상금 랭킹 설정하기
        let sortedList = bountyInfoList.sorted { prev, next in
            return prev.bounty > next.bounty
        }
        return sortedList
    }

    // 모델에 직접 엑세스가 아닌 뷰 모델을 통해 우회하여 엑세스 하도록 메서드 생성
    var numOfBountyInfoList: Int{
        return bountyInfoList.count
    }

    func bountyInfo(at index: Int) -> BountyInfo {
        return sortedList[index]
    }
}
