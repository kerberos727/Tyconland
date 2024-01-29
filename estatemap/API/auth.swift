import Foundation

func LoginUser(email:String, password: String ) async -> Bool{
    // Define the URL
      let url = URL(string: "https://tycoonland.onrender.com/login")!

      // Create a dictionary to hold the email and password
      let parameters: [String: Any] = [
          "email": email,
          "password": password
      ]

      // Convert the parameters to JSON data
      do {
          let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])

          // Create a POST request
          var request = URLRequest(url: url)
          request.httpMethod = "POST"
          request.setValue("application/json", forHTTPHeaderField: "Content-Type")
          request.httpBody = jsonData
          let (data, _) = try await URLSession.shared.data(for: request)
          if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
              // try to read out a string array
              let isOK = json["result"]!

              if  String(describing: isOK) == "success"
                    {
                        return true
                    }
              else
                    {
                        return false
                    }
              
          }
      } catch {
          print("Error encoding parameters: \(error)")
      }
      return false
}
func RegisterUser(email:String, password: String ) async -> String{
    // Define the URL
      let url = URL(string: "https://tycoonland.onrender.com/adduser")!

      // Create a dictionary to hold the email and password
      let parameters: [String: Any] = [
          "email": email,
          "password": password
      ]

      // Convert the parameters to JSON data
      do {
          let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])

          // Create a POST request
          var request = URLRequest(url: url)
          request.httpMethod = "POST"
          request.setValue("application/json", forHTTPHeaderField: "Content-Type")
          request.httpBody = jsonData
          let (data, _) = try await URLSession.shared.data(for: request)
          if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
              // try to read out a string array
              let isOK = json["result"]!

              if  String(describing: isOK) == "success"
                    {
                        return "Success"
                    }
              else
                    {
                        return String(describing: json["message"]!)
                    }
              
          }
      } catch {
          print("Error encoding parameters: \(error)")
      }
      return "Please check Network state"
}
