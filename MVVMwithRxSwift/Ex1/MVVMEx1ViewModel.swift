//
//  MVVMEx1ViewModel.swift
//  MVVMwithRxSwift
//
//  Created by Doyeong's MacBookPro on 2020/09/24.
//  Copyright © 2020 Doyeong's MacBookPro. All rights reserved.
//

import RxSwift
import RxCocoa
import Foundation

class MVVMEx1ViewModel {
    struct Input {
        let minusButtonTapped: Observable<Void>
        let plusButtonTapped: Observable<Void>
    }

    struct Output {
        // Driver: 메인쓰레드에서만 실행됨 / Observalbe: 다양한 쓰레드에서 실행될 수 있음
        let resultChanged: Driver<Int>

//        let resultAfterMinusTapped: Observable<Int>
//        let resultAfterPlusTapped: Observable<Int>
    }

    private var value: Int = 0

    func transform(input: Input) -> Output {
        let minusTapped = input.minusButtonTapped
            .do(onNext: { [weak self] _ in
                guard (self?.value ?? 0) > 0 else { return }
                self?.value -= 1
            })

        let plusTapped = input.plusButtonTapped
            .do(onNext: { [weak self] _ in
                self?.value += 1
            })

        let resultChanged = Observable.merge(minusTapped, plusTapped)
            .map { [weak self] _ in
                return self?.value ?? 0
            }
            .asDriver(onErrorJustReturn: 0) // Dirver로 변환
            .startWith(value)

        return Output(resultChanged: resultChanged)
//        return Output(resultAfterMinusTapped: <#T##Observable<Int>#>,
//                      resultAfterPlusTapped: <#T##Observable<Int>#>)
    }
}
