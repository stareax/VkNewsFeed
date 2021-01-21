//
//  AuthService.swift
//  VkNewsFeed
//
//  Created by Дарья Выскворкина on 18.01.2021.
//

import Foundation
import VK_ios_sdk

protocol AuthServiceDelegate: class {
    func authServicehouldShow(viewController: UIViewController)
    func authServiceSignIn()
    func authServiceSignInDidFaild()
}
class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {

    private let appId = "7732301"
    private let vkSdk: VKSdk
    override init(){
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        print("VKSdk initialized")
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    weak var delegate: AuthServiceDelegate?
    var token: String? {
        return VKSdk.accessToken()?.accessToken 
    }
    
    func wakeUpSession(){
        let scope = ["offline"]
        VKSdk.wakeUpSession(scope) {[delegate] (state, error) in
            switch state {
            case .initialized:
                print("initialized")
                VKSdk.authorize(scope)
            case .authorized:
                print("authorized")
                delegate?.authServiceSignIn()
            @unknown default:
                fatalError(error!.localizedDescription)
                delegate?.authServiceSignInDidFaild()
            }
        }
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        if result.token != nil {
            delegate?.authServiceSignIn()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
        delegate?.authServiceSignInDidFaild()

    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        delegate?.authServicehouldShow(viewController: controller)

    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)

    }
}
