import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ChatBotViewModel()
    @State private var textField = ""

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    // Handle home action
                }, label: {
                    Image(systemName: "house")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color(red: 23 / 255, green: 59 / 255, blue: 69 / 255))
                })
                .padding()
            }

            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.messages, id: \.self) { message in
                        Text(message)
                            .padding()
                            .background(message.starts(with: "Elastique") ? Color(red: 252 / 255, green: 246 / 255, blue: 238 / 255) : Color.white)
                            .cornerRadius(8)
                            .shadow(radius: 2)
                            .padding(.horizontal)
                            .padding(.bottom, 4)
                    }
                }
            }
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 2)
            .padding()

            HStack {
                TextField("Ask Me!", text: $textField)
                    .padding()
                    .background(Color.white)
                    .foregroundColor(Color(red: 180 / 255, green: 63 / 255, blue: 63 / 255))
                    .cornerRadius(8)
                    .shadow(radius: 2)

                Button(action: {
                    sendQuestion(textField)
                    textField = ""
                }, label: {
                    Text("SEND")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 23 / 255, green: 59 / 255, blue: 69 / 255))
                        .cornerRadius(8)
                })
            }
            .padding()

            HStack {
                Button(action: {
                    // Handle cancel action
                }) {
                    Text("Cancel")
                        .foregroundColor(Color.black)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 2)
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal)
        }
        .background(Color(red: 252 / 255, green: 246 / 255, blue: 238 / 255))
        .onTapGesture {
            // Dismiss keyboard when tapping outside
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }

    func sendQuestion(_ question: String) {
        if !question.isEmpty {
            Task {
                try await viewModel.genAnswer(question: question)
            }
        }
    }
}

#Preview {
    ContentView()
}
