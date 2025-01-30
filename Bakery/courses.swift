//
//  courses.swift
//  Bakery
//
//  Created by رشا القرني on 27/07/1446 AH.
//


import SwiftUI

struct CoursesView: View {
    @State private var searchText: String = ""
    @StateObject private var courseViewModel = CourseViewModel()
    
    var filteredCourses: [Fields] {
        if searchText.isEmpty {
            return courseViewModel.courses
        } else {
            return courseViewModel.courses.filter { $0.id.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // 🏷️ عنوان الصفحة
                Text("Courses")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top)
                
                // 🔍 شريط البحث
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search", text: $searchText)
                        .foregroundColor(.primary)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
                
                // 📋 قائمة الكورسات
                List(courseViewModel.courses, id: \.id) { course in
                    ZStack {
                        NavigationLink(destination: CourseDetailView(course: course)) {
                            EmptyView() // 🔥 رابط غير مرئي
                        }
                        .opacity(0) // 🔥 يخفي الرابط
                        
                        CourstRowView(course: course) // ✅ عرض البيانات فقط بدون سهم
                    }
                }
                .listStyle(PlainListStyle())
            }
            .padding()
            .task {
                await courseViewModel.loadItems()
            }
        }
    }
}




#Preview {
    CoursesView()
}
