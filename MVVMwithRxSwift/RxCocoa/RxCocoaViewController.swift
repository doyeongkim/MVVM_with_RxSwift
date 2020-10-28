//
//  RxCocoaViewController.swift
//  MVVMwithRxSwift
//
//  Created by Doyeong's MacBookPro on 2020/10/20.
//  Copyright © 2020 Doyeong's MacBookPro. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RxCocoaViewController: UIViewController {

    private let idField = UITextField()
    private let pwField = UITextField()
    private let loginButton = UIButton()
    private let idValidView = UIView()
    private let pwValidView = UIView()

    private let viewModel = LoginViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        setAutolayout()
        bindInput()
        bindOutput()
    }

    private func configure() {
        view.backgroundColor = .white

        idField.layer.borderWidth = 1
        idField.layer.cornerRadius = 5
        idField.placeholder = "E-mail"
        idField.font = UIFont.systemFont(ofSize: 12)
        view.addSubview(idField)

        pwField.layer.borderWidth = 1
        pwField.layer.cornerRadius = 5
        pwField.placeholder = "Password"
        pwField.font = UIFont.systemFont(ofSize: 12)
        view.addSubview(pwField)

        loginButton.setTitle("LOG IN", for: .normal)
        loginButton.setTitle("Fill in the Fields", for: .disabled)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = .blue
        loginButton.layer.cornerRadius = 5
        view.addSubview(loginButton)

        idValidView.backgroundColor = .red
        view.addSubview(idValidView)

        pwValidView.backgroundColor = .red
        view.addSubview(pwValidView)
    }

    private func bindInput() {
        idField.rx.text.orEmpty
            .bind(to: viewModel.emailText)
//            .subscribe(onNext: { [weak self] email in
//                self?.viewModel.setEmailText(email)
//            })
            .disposed(by: disposeBag)

        pwField.rx.text.orEmpty
            .bind(to: viewModel.pwText)
//            .subscribe(onNext: { [weak self] pw in
//                self?.viewModel.setPasswordText(pw)
//            })
            .disposed(by: disposeBag)
    }

    private func bindOutput() {
        viewModel.isEmailValid
            .bind(to: idValidView.rx.isHidden)
            .disposed(by: disposeBag)

        viewModel.isPasswordValid
            .bind(to: pwValidView.rx.isHidden)
            .disposed(by: disposeBag)

        Observable.combineLatest(viewModel.isEmailValid, viewModel.isPasswordValid) { $0 && $1 }
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }

    private func setAutolayout() {
        idField.snp.makeConstraints {
            $0.top.equalTo(100)
            $0.leading.equalTo(16)
            $0.trailing.equalTo(-16)
            $0.height.equalTo(40)
        }

        pwField.snp.makeConstraints {
            $0.top.equalTo(idField.snp.bottom).offset(20)
            $0.leading.equalTo(16)
            $0.trailing.equalTo(-16)
            $0.height.equalTo(40)
        }

        loginButton.snp.makeConstraints {
            $0.top.equalTo(pwField.snp.bottom).offset(20)
            $0.leading.equalTo(16)
            $0.trailing.equalTo(-16)
            $0.height.equalTo(50)
        }

        idValidView.snp.makeConstraints {
            $0.top.equalTo(idField).offset(5)
            $0.trailing.equalTo(idField).offset(-5)
            $0.width.height.equalTo(10)
        }

        pwValidView.snp.makeConstraints {
            $0.top.equalTo(pwField).offset(5)
            $0.trailing.equalTo(pwField).offset(-5)
            $0.width.height.equalTo(10)
        }
    }
}
