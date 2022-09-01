//
//  EditActivityView.swift
//  Countdown
//
//  Created by MAA on 31.08.2022.
//

import SwiftUI

struct EditActivityView: View {
    
    
    
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    var activity: FetchedResults<Activity>.Element
    
    @State private var name = ""
    @State private var title = ""
    @State private var date = Date()
    
    var body: some View {
        Form {
            Section {
                TextField("\(activity.name!)", text: $name)
                    .onAppear {
                        name = activity.name!
                        date = activity.date!
                    }
                TextField("\(activity.title!)", text: $title)
                    .onAppear() {
                        title = activity.title!
                    }
                VStack {
                    Text(date, style: .date)
                        .padding()
                    DatePicker(selection: $date, in: dateRangeFunc() , displayedComponents: .date) {
                        Label("Select a date", systemImage: "calendar")
                    }
                    .datePickerStyle(.graphical)
                }
                HStack {
                    Spacer()
                    Button("Submit") {
                        DataController().editActivity(activity: activity, name: name, title: title, date: date, context: managedObjContext)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}
