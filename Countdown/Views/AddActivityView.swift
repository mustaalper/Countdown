//
//  AddActivityView.swift
//  Countdown
//
//  Created by MAA on 31.08.2022.
//

import SwiftUI

struct AddActivityView: View {
    
    private let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let minDate = calendar.date(byAdding: .day, value: 0, to: .now)
        let maxDate = calendar.date(byAdding: .year, value: 10, to: .now)
        
        return minDate!...maxDate!
    }()
    
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var title = ""
    @State private var date = Date()
    
    var body: some View {
        Form {
            Section {
                TextField("Activity Name", text: $name)
                TextField("Activity Description", text: $title)
                
                VStack {
                    Text(date, style: .date)
                        .padding()
                    DatePicker(selection: $date, in: dateRangeFunc(), displayedComponents: .date) {
                        Label("Select a date", systemImage: "calendar")
                    }
                    .datePickerStyle(.graphical)
                }
                
                HStack {
                    Spacer()
                    Button("Submit") {
                        DataController().addActivity(name: name, title: title, date: date, context: managedObjContext)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityView()
    }
}
