//
//  tools.swift
//  Bakery
//
//  Created by رشا القرني on 27/07/1446 AH.
//


import SwiftUI
import Foundation

class BaseClass: ObservableObject , Identifiable {
    //  ليت للقيم غير متغيره ،اما اذا حيت فار فهو للقيم اللي مسموح اغير فيها
    @Published  var isActive :Bool
    //  بدل ما اكتب كل شوي رقم اوحده واخليه في متغير الكل يستخدمه ذا للانميشن
    @Published var size : Double
    //ذا لل
    @Published  var op :Double
    
    
    
    //ذا فائدته ان لمى اسوي اوبجكت وادخل على كلاس ذا احتاج معرف يعطيني بعض القيم اللي احتاجها فهنا حطيت معرف لل٣ القيم اللي راح احتاجها في سبلاش سكرين
    init(isActive: Bool, size: Double, op: Double) {
        self.isActive = isActive
        self.size = size
        self.op = op
        
        
    }
    
    
    
}
    
