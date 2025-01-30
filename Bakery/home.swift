//
//  home.swift
//  Bakery
//
//  Created by رشا القرني on 27/07/1446 AH.
//
//
//import SwiftUI
//
//struct home: View {
//    @StateObject private var tool = ViewModel()
//    
//    @State private var searchString = ""
//    
//    var body: some View {
//        TabView {
//            // الصفحة الرئيسية
//            NavigationView {
//                ScrollView {
//                    VStack {
//                        Divider()
//                        
//                        Text("Upcoming")
//                            .font(.title)
//                            .fontWeight(.bold)
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .padding()
//                        
//                        HStack {
//                            VStack {
//                                Text("Dec")
//                                    .font(.system(size: 30))
//                                Text("15")
//                                    .font(.system(size: 30))
//                            }
//                            .foregroundColor(Color.brown) // تأكد من اللون
//                            .padding()
//                            .fontWeight(.bold)
//                            
//                            RoundedRectangle(cornerRadius: 10)
//                                .fill(Color.primary) // تأكد من اللون
//                                .frame(width: 8, height: 80)
//                            
//                            VStack {
//                                Text("Babka dough")
//                                    .font(.system(size: 20))
//                                Label("Riyadh, Alnarjis", systemImage: "location")
//                                    .font(.system(size: 14))
//                                Label("4:00 pm", systemImage: "hourglass")
//                                    .font(.system(size: 14))
//                            }
//                            
//                            Spacer()
//                        }
//                        .frame(width: 380, height: 100)
//                        .background(Color.white)
//                        .padding()
//                        
//                        // قسم Popular courses
//                        Text("Popular courses")
//                            .font(.title)
//                            .fontWeight(.bold)
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .padding()
//                        
//                        ForEach(tool.courses, id: \.id) { course in
//                            VStack {
//                                Text(course.title)
//                                    .font(.headline)
//                                Label(course.locationName ?? "Unknown", systemImage: "location")
//                            }
//                            .padding()
//                            .background(Color.white)
//                            .cornerRadius(10)
//                            .shadow(radius: 5)
//
//                            }
//                        
//                            .background(Color.backgrounded) // تأكد من اللون
//                            .navigationTitle("Home Bakery")
//                            .navigationBarTitleDisplayMode(.inline)
//                    }
//                }
//                .tabItem {
//                    Image("bakeryIcone")
//                }
//                
//                // تبويب البروفايل
//                courses() // تأكد من أن اسم الـ View صحيح
//                    .tabItem {
//                        Image("courses")
//                        Text("Courses")
//                    }
//                
//                // تبويب البروفايل
//                profile() // تأكد من أن اسم الـ View صحيح
//                    .tabItem {
//                        Image("profile")
//                        Text("Profile")
//                    }
//            }
//            
//        }
//    }
//    
//    
//}
//// مكوّن لعرض تفاصيل كل كورس
//struct CourseCard: View {
//    let courseName: String
//    let location: String
//    let time: String
//    
//    var body: some View {
//        HStack {
//            VStack(alignment: .leading) {
//                Text(courseName)
//                    .font(.headline)
//                Label(location, systemImage: "location")
//                    .font(.subheadline)
//                Label(time, systemImage: "clock")
//                    .font(.subheadline)
//            }
//            Spacer()
//        }
//        .padding()
//        .frame(maxWidth: .infinity)
//        .background(Color.white)
//        .cornerRadius(10)
//        .shadow(radius: 5)
//    }
//}
//#Preview {
//    home()
//}import SwiftUI
import SwiftUI


struct HomeView: View {
    @State private var searchText: String = ""
    @StateObject private var bookingViewModel = BookingViewModel()
    @StateObject private var courseViewModel = CourseViewModel()
    
    @AppStorage("username") private var username: String = ""
    @AppStorage("isAuthenticated") private var isAuthenticated: Bool = false

    var userBookings: [Booking] {
        return bookingViewModel.bookings.filter { $0.userId == username }
    }

    var body: some View {
        TabView {
            NavigationView {
                VStack {
                    Text("Home Bakery")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.bottom, 5)
                    
                    Divider()
                        .background(Color.gray)
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .font(.title3)
                        
                        TextField("Search", text: $searchText)
                            .foregroundColor(.primary)
                            .font(.body)
                    }
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(15)
                    .frame(height: 50)
                    .padding(.horizontal, 20)
                    
                    Text("Upcoming Courses")
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    ScrollView {
                        if isAuthenticated {
                            if userBookings.isEmpty {
                                VStack {
                                    Image("nocourses")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 200, height: 200)
                                        .padding(.bottom, 20)
                                    
                                    Text("No upcoming courses")
                                        .foregroundColor(.gray)
                                        .padding()
                                }
                            } else {
                                ForEach(userBookings, id: \.id) { booking in
                                    Text("📅 \(booking.courseID ?? "")")
                                }
                            }
                        } else {
                            Text("No upcoming courses")
                                .foregroundColor(.gray)
                                .padding()
                        }
                    }
                    .frame(maxHeight: 250)
                    .padding(.horizontal)

                    Text("Popular Courses")
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)

                    ScrollView {
                        if courseViewModel.courses.isEmpty {
                            Text("No courses available")
                                .foregroundColor(.gray)
                                .padding()
                        } else {
                            ForEach(courseViewModel.courses, id: \.id) { course in
                                NavigationLink(destination: CourseDetailView(course: course)) {
                                    CourstRowView(course: course)
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .onAppear {
                    if bookingViewModel.bookings.isEmpty {
                        Task {
                            await bookingViewModel.loadBookings()
                        }
                    }
                    
                    if courseViewModel.courses.isEmpty {
                        Task {
                            await courseViewModel.loadItems()
                        }
                    }
                }
            }
            .tabItem {
                Image("bakeryIcone")
            }
            
            CoursesView()
                .tabItem {
                    Image("courses")
                    Text("Courses")
                }
            
            Profile()
                .tabItem {
                    Image("profile")
                    Text("Profile")
                }
        }
        .tint(Color.primary1)
        .navigationBarBackButtonHidden(true)
    }
}


// ✅ **عرض الكورسات القادمة**
struct UpcomingCourseView: View {
    var course: Fields

    var body: some View {
        VStack {
            Text(course.title)
                .font(.headline)
                .foregroundColor(.primary)

            Text("Level: \(course.level)")
                .font(.subheadline)
                .foregroundColor(.gray)

            Text("Location: \(course.locationName)")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.systemGray5))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

// ✅ **عرض صف الكورس في القائمة**
struct CourstRowView: View {
    let course: Fields
    
    var body: some View {
        HStack(spacing: 15) { // زدت المسافة بين العناصر
            // 🔳 صورة الكورس
            AsyncImage(url: URL(string: course.imageUrl)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 120, height: 100) // جعل الصورة أكبر
            .cornerRadius(12) // زيادة انحناء الحواف
            
            // 📝 تفاصيل الكورس
            VStack(alignment: .leading, spacing: 10) {
                Text(course.title)
                    .font(.headline)
                
                Text(course.level)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(6)
                    .background(leveleColor(for: course.level))
                    .cornerRadius(10)
                
                HStack {
                    Image(systemName: "calendar")
                    Text(formateDate(course.startDate, format: "MMM d, yyyy"))
                }
                .font(.subheadline)
                .foregroundColor(.brown1)
                
                HStack {
                    Image(systemName: "clock")
                    Text("\(formateDate(course.startDate, format: "h:mm a")) - \(formateDate(course.endDate, format: "h:mm a"))")
                }
                .font(.subheadline)
                .foregroundColor(.brown1)
            }
            Spacer() // لإبعاد العناصر عن بعضها
        }
        .padding(10) // حشوة داخلية لكل العنصر
        .background(Color.white)
        .cornerRadius(15) // جعل العنصر مستدير الحواف
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.gray, lineWidth: 0.2)
        )
        .padding(.vertical, 5) // إضافة مسافة بين العناصر
    }
}

// ✅ **تحويل التواريخ من Timestamp إلى نص مقروء**
func formateDate(_ timestamp: Double, format: String) -> String {
    let date = Date(timeIntervalSince1970: timestamp)
    let formatter = DateFormatter()
    formatter.dateFormat = format
    return formatter.string(from: date)
}

// ✅ **تحديد لون مستوى الكورس**
func leveleColor(for level: String) -> Color {
    switch level {
    case "beginner":
        return Color.brown1.opacity(1)
    case "intermediate":
        return Color.cream.opacity(0.7)
    default:
        return Color.primary1.opacity(0.9)
    }
}

#Preview {
    HomeView()
}
