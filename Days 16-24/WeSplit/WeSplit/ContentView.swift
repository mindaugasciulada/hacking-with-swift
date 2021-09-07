//
//  ContentView.swift
//  WeSplit
//
//  Created by Mindaugas Čiulada on 2021-08-28.
//

import SwiftUI

struct ContentView: View {
    
    @State private var price: String = ""
    @State private var selectedAmountOfPeople: Int = 0
    @State private var selectedPercentage: Int = 2
    
    let navigationTitle = "WeSplit"
    let selectAmountOfPeopleTitle = "Select amount of people"
    let selectPercentageTitle = "Select percentage to tip"
    let amountPerPersonTitle = "Amount per person"
    let totalAmountForCheck = "Original amount + tip"
    let percentages = [0, 10, 20, 30, 50]
    
    var dividedSum: Double {
        let sum = Double(price) ?? 0
        let people = Double(selectedAmountOfPeople + 2)
        let percentage = sum / people * Double(percentages[selectedPercentage]) / 100
        return sum / people + percentage
    }
    
    var totalSum: Double {
        let sum = Double(price) ?? 0
        let percentage = sum * Double(percentages[selectedPercentage]) / 100
        return sum + percentage
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Price", text: $price).keyboardType(.numberPad)
                    Picker("Selected \(selectedAmountOfPeople + 2) people", selection: $selectedAmountOfPeople){
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }.pickerStyle(MenuPickerStyle())
                }.onTapGesture {
                    UIApplication.shared.sendAction(
                        #selector(UIResponder.resignFirstResponder),
                        to:nil,
                        from:nil,
                        for:nil
                    )
                }
                
                Section(header: Text(selectPercentageTitle).textCase(.none)) {
                    Picker("Tip percentage", selection: $selectedPercentage) {
                        ForEach(0..<percentages.count) {
                            Text("\(percentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text(amountPerPersonTitle).textCase(.none)) {
                    Text(String(format: "%.2f", dividedSum))
                }
                
                Section(header: Text(totalAmountForCheck).textCase(.none)) {
                    Text(String(format: "%.2f", totalSum))
                        .foregroundColor(selectedPercentage == 0 ? .red : .blue)
                }
                
            }
            .navigationTitle(navigationTitle)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
