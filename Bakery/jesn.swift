//
//  jesn.swift
//  Bakery
//
//  Created by رشا القرني on 27/07/1446 AH.
//
//
//import Foundation
//
//
//class ViewModel: ObservableObject {
//    @Published var chefName: String = ""
//    @Published var courses: [Course] = []
//    
//    
//    
//    
//    
//    
//    
//    // نموذج الهيكل للـ API
//    struct ChefApiResponse: Codable {
//        let records: [ChefRecord]
//    }
//    
//    struct ChefRecord: Codable {
//        let id: String
//        let fields: ChefFields
//    }
//    
//    struct ChefFields: Codable {
//        let name: String
//        let email: String
//    }
//    
//    // نموذج الهيكل للدورات
//    struct ApiResponse: Codable {
//        let records: [CourseRecord]
//    }
//    
//    struct CourseRecord: Codable {
//        let id: String
//        let fields: CourseFields
//    }
//    
//    struct CourseFields: Codable {
//        let title: String
//        let description: String?
//    }
//    
//    // الفئة الرئيسية
//    class DataLoader: ObservableObject {
//        @Published var chefName: String = ""
//        @Published var courseTitle: String = ""
//        
//        // تحميل الدورات
//        func loadCourses() async {
//            guard let url = URL(string: "https://api.airtable.com/v0/appXMW3ZsAddTpClm/course") else {
//                print("Invalid URL")
//                return
//            }
//            
//            var request = URLRequest(url: url)
//            request.setValue("Bearer YOUR_API_KEY", forHTTPHeaderField: "Authorization")
//            
//            do {
//                let (data, _) = try await URLSession.shared.data(for: request)
//                let decodedResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
//                
//                if let course = decodedResponse.records.first?.fields {
//                    DispatchQueue.main.async {
//                        self.courseTitle = course.title
//                    }
//                }
//            } catch {
//                print("Error loading courses: \(error)")
//            }
//        }
//        
//        // تحميل الشيف
//        func loadChef() async {
//            guard let url = URL(string: "https://api.airtable.com/v0/appXMW3ZsAddTpClm/chef") else {
//                print("Invalid URL")
//                return
//            }
//            
//            var request = URLRequest(url: url)
//            request.setValue("Bearer YOUR_API_KEY", forHTTPHeaderField: "Authorization")
//            
//            do {
//                let (data, _) = try await URLSession.shared.data(for: request)
//                let decodedResponse = try JSONDecoder().decode(ChefApiResponse.self, from: data)
//                
//                if let chef = decodedResponse.records.first?.fields {
//                    DispatchQueue.main.async {
//                        self.chefName = chef.name
//                    }
//                }
//            } catch {
//                print("Error loading chef: \(error)")
//            }
//        }
//        
//        // تحميل شيف معين
//        func loadSpecificChef() async {
//            guard let url = URL(string: "https://api.airtable.com/v0/appXMW3ZsAddTpClm/chef?filterByFormula=id=\"548D6542-CD4E-4133-9F1D-F44A3C14F578\"") else {
//                print("Invalid URL")
//                return
//            }
//            
//            var request = URLRequest(url: url)
//            request.setValue("Bearer YOUR_API_KEY", forHTTPHeaderField: "Authorization")
//            
//            do {
//                let (data, _) = try await URLSession.shared.data(for: request)
//                let decodedResponse = try JSONDecoder().decode(ChefApiResponse.self, from: data)
//                
//                if let chef = decodedResponse.records.first?.fields {
//                    DispatchQueue.main.async {
//                        self.chefName = chef.name
//                    }
//                }
//            } catch {
//                print("Error loading specific chef: \(error)")
//            }
//        }
//        
//         
//            //getuser
//            func loadGetUser() async  {
//                     guard let url = URL(string: "https://api.airtable.com/v0/appXMW3ZsAddTpClm/user" )
//                             // لو صار غلط اطلع
//                     else {
//                         return
//                     }
//                     //هنا حولنا يو ار ال من سترينغ الي يو ار ال حقيقي وعطيناه للمتغير
//                     var request = URLRequest(url: url)
//                     //بعد ما اخذ متغير رابط اللحين يحتاج توكين ثم كي تاخذينهم من بوستمان
//                     request.setValue("Bearer pat7E88yW3dgzlY61.2b7d03863aca9f1262dcb772f7728bd157e695799b43c7392d5faf4f52fcb001", forHTTPHeaderField:"Authorization" )
//                     //اللحين وقت التنفيذ لازم احطه في دو وكاتش علشان لو صار غلط
//                     do{
//                         // كل كلام هنا ثابت الا اسم متغير
//                         let (data, _) = try await URLSession.shared.data(for: request)
//           
//                         print(String(data: data, encoding: .utf8),"💕" ?? "")
//                         let decoder = JSONDecoder()
//                     }
//                     // لو ما تنفذ اطبع لي ايرور  ونوعه
//                     catch{
//                         print("error \(error)")
//                         //بعد ما جبت بيانات جاسن اللحين خطوه ثانيه كيف اربط بيانات جاسن مع سوفت وهنا يجي دور مودل
//                     }
//                 }
//            //put user
//            func loadPutUser() async  {
//                     guard let url = URL(string: "https://api.airtable.com/v0/appXMW3ZsAddTpClm/user/rec0zyLMcxfhT3cDh" )
//                             // لو صار غلط اطلع
//                     else {
//                         return
//                     }
//                     //هنا حولنا يو ار ال من سترينغ الي يو ار ال حقيقي وعطيناه للمتغير
//                     var request = URLRequest(url: url)
//                     //بعد ما اخذ متغير رابط اللحين يحتاج توكين ثم كي تاخذينهم من بوستمان
//                     request.setValue("Bearer pat7E88yW3dgzlY61.2b7d03863aca9f1262dcb772f7728bd157e695799b43c7392d5faf4f52fcb001", forHTTPHeaderField:"Authorization" )
//                     //اللحين وقت التنفيذ لازم احطه في دو وكاتش علشان لو صار غلط
//                     do{
//                         // كل كلام هنا ثابت الا اسم متغير
//                         let (data, _) = try await URLSession.shared.data(for: request)
//           
//                         print(String(data: data, encoding: .utf8),"💕" ?? "")
//                         let decoder = JSONDecoder()
//                     }
//                     // لو ما تنفذ اطبع لي ايرور  ونوعه
//                     catch{
//                         print("error \(error)")
//                         //بعد ما جبت بيانات جاسن اللحين خطوه ثانيه كيف اربط بيانات جاسن مع سوفت وهنا يجي دور مودل
//                     }
//                 }
//            
//           
//            //post user
//            func loadPostUser() async  {
//                     guard let url = URL(string: " https://api.airtable.com/v0/appXMW3ZsAddTpClm/user" )
//                             // لو صار غلط اطلع
//                     else {
//                         return
//                     }
//                     //هنا حولنا يو ار ال من سترينغ الي يو ار ال حقيقي وعطيناه للمتغير
//                     var request = URLRequest(url: url)
//                     //بعد ما اخذ متغير رابط اللحين يحتاج توكين ثم كي تاخذينهم من بوستمان
//                     request.setValue("Bearer pat7E88yW3dgzlY61.2b7d03863aca9f1262dcb772f7728bd157e695799b43c7392d5faf4f52fcb001", forHTTPHeaderField:"Authorization" )
//                     //اللحين وقت التنفيذ لازم احطه في دو وكاتش علشان لو صار غلط
//                     do{
//                         // كل كلام هنا ثابت الا اسم متغير
//                         let (data, _) = try await URLSession.shared.data(for: request)
//           
//                         print(String(data: data, encoding: .utf8),"💕" ?? "")
//                         let decoder = JSONDecoder()
//                     }
//                     // لو ما تنفذ اطبع لي ايرور  ونوعه
//                     catch{
//                         print("error \(error)")
//                         //بعد ما جبت بيانات جاسن اللحين خطوه ثانيه كيف اربط بيانات جاسن مع سوفت وهنا يجي دور مودل
//                     }
//                 }
//            //post booking
//            func loadPostBooking() async  {
//                     guard let url = URL(string: " https://api.airtable.com/v0/appXMW3ZsAddTpClm/booking" )
//                             // لو صار غلط اطلع
//                     else {
//                         return
//                     }
//                     //هنا حولنا يو ار ال من سترينغ الي يو ار ال حقيقي وعطيناه للمتغير
//                     var request = URLRequest(url: url)
//                     //بعد ما اخذ متغير رابط اللحين يحتاج توكين ثم كي تاخذينهم من بوستمان
//                     request.setValue("Bearer pat7E88yW3dgzlY61.2b7d03863aca9f1262dcb772f7728bd157e695799b43c7392d5faf4f52fcb001", forHTTPHeaderField:"Authorization" )
//                     //اللحين وقت التنفيذ لازم احطه في دو وكاتش علشان لو صار غلط
//                     do{
//                         // كل كلام هنا ثابت الا اسم متغير
//                         let (data, _) = try await URLSession.shared.data(for: request)
//           
//                         print(String(data: data, encoding: .utf8),"💕" ?? "")
//                         let decoder = JSONDecoder()
//                     }
//                     // لو ما تنفذ اطبع لي ايرور  ونوعه
//                     catch{
//                         print("error \(error)")
//                         //بعد ما جبت بيانات جاسن اللحين خطوه ثانيه كيف اربط بيانات جاسن مع سوفت وهنا يجي دور مودل
//                     }
//                 }
//            
//            
//            //get booking
//            func loadGetBooking() async  {
//                     guard let url = URL(string: "https://api.airtable.com/v0/appXMW3ZsAddTpClm/booking" )
//                             // لو صار غلط اطلع
//                     else {
//                         return
//                     }
//                     //هنا حولنا يو ار ال من سترينغ الي يو ار ال حقيقي وعطيناه للمتغير
//                     var request = URLRequest(url: url)
//                     //بعد ما اخذ متغير رابط اللحين يحتاج توكين ثم كي تاخذينهم من بوستمان
//                     request.setValue("Bearer pat7E88yW3dgzlY61.2b7d03863aca9f1262dcb772f7728bd157e695799b43c7392d5faf4f52fcb001", forHTTPHeaderField:"Authorization" )
//                     //اللحين وقت التنفيذ لازم احطه في دو وكاتش علشان لو صار غلط
//                     do{
//                         // كل كلام هنا ثابت الا اسم متغير
//                         let (data, _) = try await URLSession.shared.data(for: request)
//           
//                         print(String(data: data, encoding: .utf8),"💕" ?? "")
//                         //let decoder = JSONDecoder()
//                     }
//                     // لو ما تنفذ اطبع لي ايرور  ونوعه
//                     catch{
//                         print("error \(error)")
//                         //بعد ما جبت بيانات جاسن اللحين خطوه ثانيه كيف اربط بيانات جاسن مع سوفت وهنا يجي دور مودل
//                     }
//                 }
//            
//            
//            
//         
//    }
//}
import Foundation
import SwiftUI

class ChefViewModel: ObservableObject {
    @Published var chefName: String = ""  // لتخزين اسم الشيف
    
    // دالة لتحميل اسم الشيف بناءً على chefId
    func loadChefName(chefId: String) async {
        // بناء الـ URL بناءً على الـ chefId
        guard let url = URL(string: "https://api.airtable.com/v0/appXMW3ZsAddTpClm/chef?filterByFormula=id=\"\(chefId)\"") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer pat7E88yW3dgzlY61.2b7d03863aca9f1262dcb772f7728bd157e695799b43c7392d5faf4f52fcb001", forHTTPHeaderField: "Authorization")
        
        do {
            // إرسال الطلب وانتظار الاستجابة
            let (data, _) = try await URLSession.shared.data(for: request)
            
            // فك تشفير البيانات المستلمة
            let decodedResponse = try JSONDecoder().decode(ChefApiResponse.self, from: data)
            
            // تعيين اسم الشيف بعد فك التشفير
            if let chef = decodedResponse.records.first?.fields {
                DispatchQueue.main.async {
                    self.chefName = chef.name
                }
            }
        } catch {
            print("Error fetching data: \(error)")
        }
    }
}



import SwiftUI

class CourseViewModel: ObservableObject {
    @Published var courses: [Fields] = []
    
    func loadItems() async {
        guard let url = URL(string: "https://api.airtable.com/v0/appXMW3ZsAddTpClm/course") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer pat7E88yW3dgzlY61.2b7d03863aca9f1262dcb772f7728bd157e695799b43c7392d5faf4f52fcb001",
                         forHTTPHeaderField: "Authorization")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
            
            DispatchQueue.main.async {
                self.courses = decodedResponse.records.map { $0.fields }
            }
        } catch {
            print("Error fetching data: \(error)")
        }
    }
    
    
    
}

import Foundation

class BookingViewModel: ObservableObject {
    @Published var bookings: [Booking] = []

    func loadBookings() async {
        guard let url = URL(string: "https://api.airtable.com/v0/appXMW3ZsAddTpClm/course") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer pat7E88yW3dgzlY61.2b7d03863aca9f1262dcb772f7728bd157e695799b43c7392d5faf4f52fcb001", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
            
            DispatchQueue.main.async {
                self.bookings = decodedResponse.records.compactMap { record in
                    let id = record.fields.id
                    let userName = record.fields.userName ?? ""
                    let courseID = record.fields.courseID ?? "default_course_id"


                    return Booking(id: id, userId: userName, courseID: courseID)
                }
            }
        } catch {
            print("Error fetching bookings: \(error)")
        }
    }
}
