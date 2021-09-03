//
//  ContentView.swift
//  UnitsConverter
//
//  Created by User on 2021-09-01.
//

import SwiftUI

struct ContentView: View {

    @State private var inputNumber = ""
    @State private var selectedInputUnit = Unit.meters
    @State private var selectedOutputUnit = Unit.meters

    enum Unit: String, CaseIterable, Identifiable {
        var id: String { self.rawValue }
        case meters
        case kilometers
        case feet
        case miles
    }

    private func unitType (unit: Unit) -> UnitLength {
        switch unit {
        case .meters:
            return UnitLength.meters
        case .kilometers:
            return UnitLength.kilometers
        case .feet:
            return UnitLength.feet
        case .miles:
            return UnitLength.miles
        }
    }

    private var outputNumber: Double {
        let measure = Measurement(
            value: Double(inputNumber) ?? 0,
            unit: unitType(unit: selectedInputUnit)
        )

        return measure.converted(to: unitType(unit: selectedOutputUnit)).value
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Convert from").textCase(.none)){
                    TextField("Number", text: $inputNumber)
                    
                    Picker("Convert from", selection: $selectedInputUnit) {
                        ForEach(Unit.allCases) { unit in
                            Text(unit.rawValue).tag(unit)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Convert to").textCase(.none)) {
                    Picker("Converted number:", selection: $selectedOutputUnit) {
                        ForEach(Unit.allCases) {
                            Text($0.rawValue).tag($0)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Converted units").textCase(.none)) {
                    Text("\(outputNumber)")
                }
            }.navigationTitle("Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
