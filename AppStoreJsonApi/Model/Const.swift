//
//  Const.swift
//  AppStoreJsonApi
//
//  Created by Masoud Heydari on 4/18/19.
//  Copyright © 2019 Masoud Heydari. All rights reserved.
//

import Foundation

struct Const {
    static let empty = ""
    
    struct NavTitle {
        static let search = "Search"
        static let apps = "Apps"
        static let today = "Today"
    }
    
    struct TabBarTitle {
        static let search = "Search"
        static let apps = "Apps"
        static let today = "Today"
    }
    
    struct Image {
        static let apps = "apps"
        static let search = "search"
        static let today = "today_icon"
    }
    
    struct ID {
        struct Cell {
            static let appsSearch = "apps_search"
            static let apps = "apps_cell_id"
            static let appsGroupHorizontal = "apps_group_horizontal_cell"
            static let appsPageHeader = "apps_page_header_cell"
            static let appsPageHeaderHorizontal = "apps_page_heaer_horizontal_cell"
        }
    }
}
