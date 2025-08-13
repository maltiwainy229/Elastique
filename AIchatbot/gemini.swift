import SwiftUI

import GoogleGenerativeAI



struct ContentView: View {

    let model = GenerativeModel(name: "gemini-pro", apiKey: APIKey.default)

    @State var userPrompt = ""

    @State var response = "How can I help you today?"

    @State var isLoading = false

    @State private var isRecording = false

    @State var selectedTab = 0

   

    

    var body: some View {

        

        TabView(selection: $selectedTab){

            VStack {

                

                    

                    Text("Welcome to Elastique AI")

                        .font(.title)

                        .fontWeight(.bold)

                        .foregroundStyle(.indigo)

                        .padding(.top, 40)

                    

                        

                

                

                

                ZStack {

                    

                    

                    

                    

                    

                    ScrollView {

                        Text(response)

                            .font(.title).padding(.horizontal, 20)

                            .padding(.vertical, 10)

                            .background(Color.indigo.opacity(0.3)

                                        

                                .cornerRadius(20)

                            )}

                    if isLoading {

                        ProgressView()

                            .progressViewStyle(CircularProgressViewStyle(tint: .indigo))

                            .scaleEffect(4)

                        

                    }

                    

                }

                

                HStack {

                    

                    TextField("Ask any exercise...", text: $userPrompt, axis: .vertical)

                        .lineLimit(5)

                        .font(.title)

                        .padding(EdgeInsets(top:10, leading:15, bottom: 10, trailing: 10))

                        .background(Color.indigo.opacity(0.2))

                        .cornerRadius(100)

                        .disableAutocorrection(true)

                    

                    

                    

                    

                    

                    

                    

                        

                }.padding(EdgeInsets(top:2, leading:15, bottom: 20, trailing: 10))

                

                            }

            

                .tabItem {

                    Image(systemName: "message.fill")

                    Text("Elastique AI")

                        .foregroundColor(.indigo)

                    

                }

            

            Text("model")

                .tabItem {

                    Image(systemName: "house.fill")

                    Text("Home")

                }

            Text("Excersise")

                .tabItem {

                    Image(systemName: "figure.walk")

                    Text("excersise")

                }

            Text("info")

                .tabItem {

                    Image(systemName: "person.crop.circle.fill")

                    Text("profile")

                        

                }

                

                

        }

        .accentColor(.indigo)

        .padding(.bottom, 5)

        

        

                    

                

               

                

                .onSubmit {

                    generateresponse()

                }

                

            

        

        

        

        }

        func generateresponse(){

            isLoading = true

            response = ""

            

            Task {

                do {

                    let result = try await model.generateContent(userPrompt)

                    isLoading = false

                    response = result.text ?? "No response found"

                    userPrompt = ""

                } catch {

                    response = "Something went wrong\n\(error.localizedDescription)"

                    

                    

                }

            }

     

        }

    }

    

    

    #Preview {

        ContentView()

    }
