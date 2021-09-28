//
//  Enums.swift
//  Bam
//
//  Created by ADS N URL on 17/03/21.
//


enum DisplayType: Int {
    case circular
    case roundedCorner
    case square
    case diamond
    case underlinedBottom
}

enum LeftMenuItems: String {
    case homeView = "Home"
    case myOrderView = "My Orders"
    case offerView = "Offers"
    case loyalityPointsView = "Loyality Points"
    case giftview = "Gift Card"
    case scanView = "Scan QR Code"
    case addressView = "Address Book"
    case appointmentsView = "My Appointments"
    case measurementView = "My Measurements"
    case settingView = "Settings"
    case rateApp = "Rate Our App"
}


enum TabItem: Int {
    case home = 0
    case cart
    case orders
    case profile
  
    init() {
        self = .home
    }
}


enum ViewID {
    static let leftHeaderView = "LeftHeaderView"
    static let leftFooterView = "LeftFooterView"
}

enum StoryboardID {
    static let main = "Main"
}

