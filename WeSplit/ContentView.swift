//
//  ContentView.swift
//  WeSplit
//
//  Created by bharat venna on 16/08/23.
//
/*
 This application is developed to split the bill among the number of people with a tip included.
 */

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0 // bill cost
    @State private var numberOfPeople = 2 // number of people sharing the bill
    @State private var tipPercentage = 20 // percentage of bill wanted to add
    let tipPercentages = [0, 10, 20, 30] // Array of Int representing the tip percentages
    
    @FocusState var keyBoardFocus: Bool // Variable for keyboard focus control
    
    var totalPerPerson: Double { // computed property for calculating the total per person
        let tipValue = checkAmount / 100 * Double(tipPercentage) // variable to store the tip value
        let grandTotal = checkAmount + tipValue // variable to store total check and tip value
        let amountPerPerson = grandTotal / Double(numberOfPeople+2) // Dividing the total with number of persons
        
        return amountPerPerson // returning double value
    }
    
    var body: some View {
        NavigationStack{
            Form {
                Section {
                    TextField("Enter check amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")) // TextField for entering the bill value
                        .keyboardType(.decimalPad) // seleting a keyboard style
                        .focused($keyBoardFocus) // keyboard focus toggle
                    Picker("Number of people", selection: $numberOfPeople){ // Picker for selecting the number of people
                        ForEach(2..<100) {
                            Text("\($0) People")
                        }
                    }
                }
                Section {
                    Picker("Tip percentage", selection: $tipPercentage){ // Picker for selecting the tip percentage
                        ForEach(tipPercentages, id: \.self) { // Looping through array
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented) // Selecting a picker style
                }
            header: {
                Text("How munch tip do you want to leave?") // Heading for the picker
            }
                Section { // Section to display the result
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundColor(tipPercentage == 0 ? .red : .black)// conditional modifier for 0 tip selection
                }
            }
            .navigationTitle("WeSplit")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard) { // creating tool bar button for keyboard to toggle focus
                    Spacer()
                    Button("Done") {
                        keyBoardFocus = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
