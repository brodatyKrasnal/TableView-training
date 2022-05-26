//
//  by: Tymek (iTmi) on: 26/05/2022 | Memo.swift : TableView training 
// Copyright (c) 2022, all rights reserved. UIID: 1D649405-B571-4964-8377-F96422FDB76C 

import Foundation


struct Memo : Codable {
    var itemName : String = ""
    var itemContent : String?
    var itemCompleted : Bool
    var itemDueDate : Date
}
