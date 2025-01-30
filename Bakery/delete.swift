//
//  delete.swift
//  Bakery
//
//  Created by رشا القرني on 28/07/1446 AH.
//

import SwiftUI
import MapKit

struct BookedCourseDetailView: View {
    let course: Fields
    
    @ObservedObject private var chefViewModel = ChefViewModel()
    @State private var navigateToHome = false
    @AppStorage("bookedCourses") private var bookedCourses: String = ""
    @State private var region: MKCoordinateRegion
    
    init(course: Fields) {
        self.course = course
        _region = State(initialValue: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: course.locationLatitude, longitude: course.locationLongitude),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        ))
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // صورة الكورس
                    AsyncImage(url: URL(string: course.imageUrl)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 300, height: 300)
                    .cornerRadius(8)
                    
                    // وصف الكورس
                    Text("About this course:\n \(course.description)")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 10)
                    
                    Divider()
                    
                    // اسم الشيف
                    if !chefViewModel.chefName.isEmpty {
                        HStack {
                            Text("Chef:")
                                .bold()
                            Text(chefViewModel.chefName)
                                .foregroundColor(.brown)
                            Spacer()
                        }
                        .font(.subheadline)
                    }
                    
                    // التفاصيل بتنسيق "يسار - يمين"
                    VStack(spacing: 10) {
                        HStack {
                            Text("Level:")
                                .bold()
                            Text(course.level)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .background(levelColor(for: course.level))
                                .cornerRadius(8)
                            Spacer()
                            Text("Duration:")
                                .bold()
                            Text(formatDuration(course.startDate, course.endDate))
                        }
                        HStack {
                            Text("Date:")
                                .bold()
                            Text(formatDate(course.startDate))
                            Spacer()
                            Text("Location:")
                                .bold()
                            Text(course.locationName)
                        }
                    }
                    .font(.subheadline)
                    .padding(.horizontal)
                    
                    // عرض الخريطة مع Pin
                    Map(coordinateRegion: $region, annotationItems: [course]) { location in
                        MapPin(coordinate: CLLocationCoordinate2D(latitude: location.locationLatitude, longitude: location.locationLongitude), tint: .red)
                    }
                    .frame(height: 200)
                    .cornerRadius(10)
                    
                    // زر إلغاء الحجز
                    Button(action: {
                        removeCourseFromProfile(course.id)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            navigateToHome = true
                        }
                    }) {
                        Text("Cancel Booking")
                            .font(.title2)
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    .padding(.bottom, 20)
                    
                    NavigationLink(destination: HomeView(), isActive: $navigateToHome) {
                        EmptyView()
                    }
                    
                    Spacer()
                }
                .padding()
                .navigationBarTitle(course.title, displayMode: .inline)
                .onAppear {
                    Task {
                        await chefViewModel.loadChefName(chefId: course.id)
                    }
                }
            }
        }
    }
    
    func levelColor(for level: String) -> Color {
        switch level {
        case "beginner":
            return Color.brown1.opacity(1)
        case "intermediate":
            return Color.cream.opacity(0.7)
        case "advanced":
            return Color.primary1.opacity(0.9)
        default:
            return Color.gray.opacity(0.2)
        }
    }
    
    func formatDate(_ timestamp: Double) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    func formatDuration(_ startTimestamp: Double, _ endTimestamp: Double) -> String {
        let startDate = Date(timeIntervalSince1970: startTimestamp)
        let endDate = Date(timeIntervalSince1970: endTimestamp)
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute]
        formatter.unitsStyle = .full
        return formatter.string(from: startDate, to: endDate) ?? "N/A"
    }
    
    func removeCourseFromProfile(_ courseId: String) {
        var courses = bookedCourses.split(separator: ",").map(String.init)
        courses.removeAll { $0 == courseId }
        bookedCourses = courses.joined(separator: ",")
    }
}

// إضافة Pin لموقع الكورس


