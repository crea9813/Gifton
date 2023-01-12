//
//  CNContactPickerViewController+Rx.swift
//  Gifton
//
//  Created by SuperMove on 2023/01/12.
//

import Foundation
import ContactsUI
import RxSwift
import RxCocoa

extension Reactive where Base: CNContactPickerViewController {
    var delegate: DelegateProxy<CNContactPickerViewController, CNContactPickerDelegate> {
        return RxCNContactPickerDelegateProxy.proxy(for: self.base)
    }
    
    var didSelect: Observable<CNContact> {
        RxCNContactPickerDelegateProxy
            .proxy(for: base)
            .didSelectSubject
            .asObservable()
    }
    
//    delegate.methodInvoked(#selector(NMFMapViewDelegate.mapViewRegionIsChanging(_:byReason:))).map { params in
//        return MapViewRegionChanging(params[0] as! NMFMapView, params[1] as! Int)
    public func setDelegate(_ delegate: CNContactPickerDelegate) -> Disposable {
        return RxCNContactPickerDelegateProxy.installForwardDelegate(delegate, retainDelegate: false, onProxyForObject: self.base)
    }
}

public class RxCNContactPickerDelegateProxy: DelegateProxy<CNContactPickerViewController, CNContactPickerDelegate>, DelegateProxyType, CNContactPickerDelegate {
    public static func registerKnownImplementations() {
        self.register { (contact) -> RxCNContactPickerDelegateProxy in
            RxCNContactPickerDelegateProxy(parentObject: contact, delegateProxy: self)
        }
    }
    
    public static func currentDelegate(for object: CNContactPickerViewController) -> CNContactPickerDelegate? {
        return object.delegate
    }
    
    public static func setCurrentDelegate(_ delegate: CNContactPickerDelegate?, to object: CNContactPickerViewController) {
        object.delegate = delegate
    }
    
    internal lazy var didSelectSubject = PublishSubject<CNContact>()
    
    public func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        _forwardToDelegate?.contactPicker?(picker, didSelect: contact)
        didSelectSubject.onNext(contact)
    }
}
