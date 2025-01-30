//
//  profile.swift
//  Bakery
//
//  Created by رشا القرني on 27/07/1446 AH.
//
import SwiftUI

struct Profile: View {
    @AppStorage("username") private var username: String = ""
    @AppStorage("isAuthenticated") private var isAuthenticated: Bool = false
    @State private var showSignIn: Bool = false
    @StateObject private var bookingViewModel = BookingViewModel()
    @StateObject private var courseViewModel = CourseViewModel()
    
    var userBookings: [Booking] {
        return bookingViewModel.bookings.filter { $0.userId == username }
    }



    var body: some View {
        VStack(alignment: .leading) {
            Text("Profile")
                .font(.title)
                .bold()
                .padding(.top)
            
            Divider().padding()
            
            HStack(spacing: 16) {
                ZStack(alignment: .bottomTrailing) {
                    Circle()
                        .fill(Color(.systemGray5))
                        .frame(width: 60, height: 60)
                        .overlay(
                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.black)
                        )
                    Circle()
                        .fill(Color(.systemBrown))
                        .frame(width: 20, height: 20)
                        .overlay(
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 12, height: 12)
                                .foregroundColor(.white)
                        )
                        .offset(x: 6, y: 6)
                }
                
                TextField("Enter username", text: $username)
                    .font(.system(size: 16))
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                Button("Done") {
                    print("Done button tapped")
                }
                .foregroundColor(.brown)
                .font(.system(size: 16, weight: .bold))
            }
            .padding()
            .background(Color(.systemGray5))
            .cornerRadius(12)
            .shadow(radius: 2)
            
            Divider().padding(.top, 10)
            
            // عرض الكورسات المحجوزة
            Text("Booked courses")
                .font(.title)
                .bold()
                .padding(.top, 10)
            
            // عرض الكورسات المحجوزة
            if userBookings.isEmpty {
                Image("nocourses")
                    .resizable()  // لتعديل حجم الصورة
                    .scaledToFit()  // الحفاظ على نسبة الأبعاد
                    .frame(width: 200, height: 200)  // تعديل الحجم حسب الحاجة
                    .padding(.bottom, 20)  // إضافة مساحة بين الصورة والنص
                           } else {
                ScrollView {
                    ForEach(userBookings, id: \.id) { booking in
                        if let course = courseViewModel.courses.first(where: { $0.id == booking.courseID }) {
                            NavigationLink(destination: CourseDetailView(course: course)) {
                                UpcomingCourseView(course: course)
                                    .padding(.horizontal)
                            }
                        }
                    }
                }
            }

            Spacer()
        }
        .padding(.horizontal)
        .fullScreenCover(isPresented: $showSignIn) {
            SignIn()
        }
        .onAppear {
            if !isAuthenticated {
                showSignIn = true
            }
            
            // تحميل بيانات الحجوزات والكورسات
            Task {
                await bookingViewModel.loadBookings()
                await courseViewModel.loadItems()
            }
        }

    }
}
