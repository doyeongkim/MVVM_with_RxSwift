//
//  LoginViewModel.swift
//  MVVMwithRxSwift
//
//  Created by Doyeong's MacBookPro on 2020/10/28.
//  Copyright © 2020 Doyeong's MacBookPro. All rights reserved.
//

import Foundation
import RxSwift

class LoginViewModel {

    // PublishSubject<Bool>() => 기본값을 가지고 있어야하기 때문에, publish가 아닌 behavior를 써야함
    let isEmailValid = BehaviorSubject(value: false)
    let isPasswordValid = BehaviorSubject(value: false)
    let emailText = BehaviorSubject(value: "")
    let pwText = BehaviorSubject(value: "")

    init() {
        _ = emailText.distinctUntilChanged()
            .map(checkEmailValid)
            .bind(to: isEmailValid)

        _ = pwText.distinctUntilChanged()
            .map(checkPasswordValid)
            .bind(to: isPasswordValid)
    }

    private func checkEmailValid(_ email: String) -> Bool {
        return email.contains("@") && email.contains(".")
    }

    private func checkPasswordValid(_ password: String) -> Bool {
        return password.count > 5
    }
}
