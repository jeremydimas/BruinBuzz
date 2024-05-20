//
//  BruinBuzzFireBase.swift
//  BruinBuzz
//
//  Created by Yahir Dimas on 4/19/24.
//

import SwiftUI
import FirebaseCore
import Stripe
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct BruinBuzzFirebase: App {

    init()
    {
        StripeAPI.defaultPublishableKey = "pk_live_51PBlWCA3TDPnptjG14dVqL0WJAbC33aKNiGg51SmzYTOhXZitWP4KRhkDufOqWLun7V0bPr8gHa5qYiMoiCKGh6M003PrDHGxx"
    }
    
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            SplashScreen()
        }
    }
}
