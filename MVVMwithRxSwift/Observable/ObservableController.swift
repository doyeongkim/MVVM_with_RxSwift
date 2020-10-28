//
//  ObservableController.swift
//  MVVMwithRxSwift
//
//  Created by Doyeong's MacBookPro on 2020/10/15.
//  Copyright © 2020 Doyeong's MacBookPro. All rights reserved.
//

import UIKit
import RxSwift

class ObservableController: UIViewController {
    private let tableView = UITableView()
    private let button = UIButton()
    private let imageView = UIImageView()

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        setAutolayout()
    }

    private func configure() {
        view.backgroundColor = .white

        tableView.rowHeight = 40
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)

        button.setTitle("Button", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        view.addSubview(button)

        view.addSubview(imageView)
    }

    @objc private func buttonClicked() {
        // Just1
//        Observable.just("Hello, world")
//            .subscribe(onNext: { str in
//                print(str)
//            })
//            .disposed(by: disposeBag)

        // Just2
//        Observable.just(["Hello", "World"])
//            .subscribe(onNext: { arr in
//                print(arr)
//            })
//            .disposed(by: disposeBag)

        // From1
//        Observable.from(["RxSwift", "In", 4, "Hours"])
//            .subscribe(onNext: { str in
//                print(str)
//            })
//            .disposed(by: disposeBag)

        // Map1
//        Observable.just("Hello")
//            .map { str in "\(str) RxSwift" }
//            .subscribe(onNext: { str in
//                print(str)
//            })
//            .disposed(by: disposeBag)

        // Map2
//        Observable.from(["with", "doyeong"]) // stream
//            .map { $0.count }
//            .subscribe(onNext: { str in
//                print(str)
//            })
//            .disposed(by: disposeBag)

        // Filter
//        Observable.from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
//            .filter { $0 % 2 == 0 }
//            .subscribe(onNext: { n in
//                print(n)
//            })
//            .disposed(by: disposeBag)

        // Map3
        Observable.just("800x600")
            .map { $0.replacingOccurrences(of: "x", with: "/") }
            .map { "https://picsum.photos/\($0)/?random" }
            .map { URL(string: $0) }
            .filter { $0 != nil }
            .map { $0! }

            // (concurrency thread에서 실행되도록)
            // observeOn은 그 다음줄부터 영향을 미침
//            .observeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .map { try Data(contentsOf: $0) }
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default)) // observeOn과 달리 아무곳에다 놓고 써도 상관 무 (subscribe될때부터 적용한다는 뜻이기 때문에)

            .map { UIImage (data: $0) }

            // side-effect는 .do 나 .subscribe에서 (밖에서 영향을 미치는 작업들)
            .do(onNext: { image in
                print(image?.size ?? 0)
            })

            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] image in
                self?.imageView.image = image
            })
            .disposed(by: disposeBag)

        // Subscribe
//        Observable.from(["RxSwift", "In", 4, "Hours"])
////            .single()  // error
//
////            .subscribe { event in
////                print("suscribe started")
////                switch event {
////                case .next(let str):
////                    print("next: ", str)
////                case .error(let error):
////                    print("error: ", error.localizedDescription)
////                case .completed:
////                    print("completed")
////                }
////            }
////            .disposed(by: disposeBag)
//
//            .subscribe(onNext: { s in
//                print(s)
//            }, onError: { error in
//                print(error.localizedDescription)
//            }, onCompleted: {
//                print("completed")
//            }, onDisposed: {
//                print("disposed")  // complete된 경우 or error난 경우
//            })
//            .disposed(by: disposeBag)
    }

    private func setAutolayout() {
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }

        button.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }

        imageView.snp.makeConstraints {
            $0.top.equalTo(button.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(300)
        }
    }
}

extension ObservableController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
