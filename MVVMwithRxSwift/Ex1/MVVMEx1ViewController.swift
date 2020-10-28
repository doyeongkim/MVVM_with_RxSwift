//
//  MVVMEx1ViewController.swift
//  MVVMwithRxSwift
//
//  Created by Doyeong's MacBookPro on 2020/09/24.
//  Copyright © 2020 Doyeong's MacBookPro. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class MVVMEx1ViewController: UIViewController {
    private let plusButton = UIButton()
    private let minusButton = UIButton()
    private let numbersLabel = UILabel()

    private let viewModel: MVVMEx1ViewModel
    private let disposeBag = DisposeBag()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.viewModel = MVVMEx1ViewModel()

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        setAutolayout()

        let input = MVVMEx1ViewModel.Input(minusButtonTapped: minusButton.rx.tap.asObservable(),
                                           plusButtonTapped: plusButton.rx.tap.asObservable())
        let output = viewModel.transform(input: input)

        output.resultChanged
            .drive(onNext: { [weak self] value in
                self?.numbersLabel.text = String(value)
            })
            .disposed(by: disposeBag)
    }

    private func configure() {
        view.backgroundColor = .white

        plusButton.setTitle("+", for: .normal)
        plusButton.setTitleColor(.black, for: .normal)
        plusButton.layer.borderColor = UIColor.black.cgColor
        plusButton.layer.borderWidth = 1
        view.addSubview(plusButton)

        minusButton.setTitle("-", for: .normal)
        minusButton.setTitleColor(.black, for: .normal)
        minusButton.layer.borderColor = UIColor.black.cgColor
        minusButton.layer.borderWidth = 1
        view.addSubview(minusButton)

//        numbersLabel.text = viewModel.
        numbersLabel.textColor = .black
        numbersLabel.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(numbersLabel)
    }

    private func setAutolayout() {
        numbersLabel.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }

        plusButton.snp.makeConstraints { (make) in
            make.top.equalTo(numbersLabel.snp.bottom).offset(50)
            make.centerX.equalToSuperview().offset(-50)
            make.width.equalTo(50)
            make.height.equalTo(40)
        }

        minusButton.snp.makeConstraints { (make) in
            make.top.equalTo(plusButton)
            make.centerX.equalToSuperview().offset(50)
            make.width.equalTo(50)
            make.height.equalTo(40)
        }
    }
}
