
//    
////    
//   import Foundation
//
//// استجابة API للطهاة
//struct ChefApiResponse: Codable {
//    let records: [ChefRecord]
//}
//
//struct ChefRecord: Codable {
//    let id: String
//    let name: String
//    let email: String
//    let password: String
//}
//
//// استجابة الـ API
//struct ApiResponse: Codable {
//    let records: [Record]
//}
//
//// تعريف بنية Record
//struct Record: Codable {
//    let id: String
//    let title: String
//    let description: String?
//    let level: String?
//    let imageUrl: String?
//    let locationName: String?
//    let locationLongitude: Double?
//    let locationLatitude: Double?
//    let startDate: Int?  // إذا كان التاريخ هو طابع زمني (timestamp)
//    let endDate: Int?    // إذا كان التاريخ هو طابع زمني (timestamp)
//    let chefId: String?
//}
//
//// استجابة الـ API للمستخدمين
//struct UserAPIResponse: Codable {
//    let records: [UserRecord]
//}
//
//struct UserRecord: Codable {
//    let id: String
//    let name: String
//    let email: String
//    let password: String
//}
//
//// الدورة التدريبية
//struct Course: Codable {
//    let id: String
//    let title: String
//    let description: String?
//    let level: String?
//    let imageUrl: String?
//    let locationName: String?
//    let locationLongitude: Double?
//    let locationLatitude: Double?
//    let startDate: Int?  // إذا كان التاريخ هو طابع زمني (timestamp)
//    let endDate: Int?    // إذا كان التاريخ هو طابع زمني (timestamp)
//    let chefId: String?
//}
//
//// تسميات الـ CodingKeys لـ Course
//enum CodingKeys: String, CodingKey {
//    case title
//    case description
//    case level
//    case imageUrl = "image_url"
//    case locationName = "location_name"
//    case locationLongitude = "location_longitude"
//    case locationLatitude = "location_latitude"
//    case startDate = "start_date"
//    case endDate = "end_date"
//    case id = "id"
//    case chefId = "chef_id"
//}
//
//struct Booking: Codable {
//    let id: String
//    let courseId: String
//    let userId: String
//    let status: String
//
//    // تسميات الـ CodingKeys لـ Booking
//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case courseId = "course_id"
//        case userId = "user_id"
//        case status = "status"
//    }
//}
//
//struct User: Codable {
//    let id: String
//    let name: String
//    let email: String
//    let password: String
//
//    // تسميات الـ CodingKeys لـ User
//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case name = "name"
//        case email = "email"
//        case password = "password"
//    }
//}
//
//struct Chef: Codable {
//    let id: String
//    let name: String
//    let email: String
//    let password: String
//
//    // تسميات الـ CodingKeys لـ Chef
//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case name = "name"
//        case email = "email"
//        case password = "password"
//    }
//}

import Foundation

// استجابة API للطهاة
struct ChefApiResponse: Codable {
    let records: [ChefRecord]
}

// كل كائن "record" في Airtable
struct ChefRecord: Codable {
    let id: String
    let fields: Chef
}

// البيانات الفعلية لكل شيف
struct Chef: Codable, Identifiable {
    let id: String
    let name: String
    let email: String
    let password: String
}
import Foundation

// MARK: - Root Object
struct ApiResponse: Codable {
    let records: [Record]
}

// MARK: - Record
struct Record: Codable {
    let id: String
    let createdTime: String
    let fields: Fields
}

// MARK: - Fields
struct Fields: Codable {
    let id: String
    let title: String
    let level: String
    var userName: String?
    let locationLongitude: Double
    let locationName: String
    let locationLatitude: Double
    let imageUrl: String
    let description: String
    let startDate: Double
    let endDate: Double
    let chefId: String
    var courseID: String?

    enum CodingKeys: String, CodingKey {
        case id, title, level, userName
        case locationLongitude = "location_longitude"
        case locationName = "location_name"
        case locationLatitude = "location_latitude"
        case imageUrl = "image_url"
        case description
        case startDate = "start_date"
        case endDate = "end_date"
        case chefId = "chef_id" // تأكد من مطابقة اسم الحقل في JSON
        case courseID = "course_id"
    }
}

struct Course: Identifiable {
    let id: String
    let title: String
    let chefId: String  // معرف الشيف المرتبط بهذه الدورة
    let locationLatitude: Double
    let locationLongitude: Double
}



import Foundation

struct UserAPIResponse: Codable {
    let records: [UserRecord]
}

struct UserRecord: Codable {
    let id: String
    let fields: User
}

struct User: Codable {
    let name: String
    let email: String
    let password: String
}


struct Booking: Identifiable, Codable {
    var id: String
    var userId: String?
    var courseID: String?
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case courseID = "course_id"
        case id
    }
}

struct UserModel: Identifiable {
    let id: String
    let userName: String
}
// MARK: - بنية بيانات الاستجابة لجدول الحجوزات
struct BookingApiResponse: Codable {
    let records: [BookingRecord]
}

struct BookingRecord: Codable {
    let id: String
    let createdTime: String
    let fields: BookingFields
}

struct BookingFields: Codable {
    let userId: String?
    let courseId: String?
    let bookingDate: Double?
    
    // 4. التأكد من مطابقة أسماء الحقول مع Airtable
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case courseId = "course_id"
        case bookingDate = "booking_date"
    }
}

// 5. تحديد نموذج الحجز مع الحقول الصحيحة
//struct Booking: Identifiable, Codable {
//    var id: String
//    var userId: String
//    var courseId: String
//    var bookingDate: Double?
//}
