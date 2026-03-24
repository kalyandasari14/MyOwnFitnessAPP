//
//  LoginView.swift
//  MyOwnFitnessAPP
//
//  Created by kalyan on 3/22/26.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth
import AuthenticationServices
import CryptoKit

struct LoginView: View {
    @State private var errorMessage: String?
    @State private var isLoading = false
    @State private var currentNonce: String?
    
    private let backgroundGradient = LinearGradient(
        colors: [.green.opacity(0.25), .blue.opacity(0.25)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    // Check if running on simulator
    private var isSimulator: Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
    
    var body: some View {
        ZStack {
            // Background
            backgroundGradient
                .ignoresSafeArea()

            // Content Card
            VStack {
                Spacer(minLength: 24)

                VStack(spacing: 20) {
                    // App Icon
                    ZStack {
                        Circle()
                            .fill(.ultraThinMaterial)
                            .frame(width: 110, height: 110)
                            .shadow(color: .black.opacity(0.1), radius: 12, x: 0, y: 6)
                        Image(systemName: "figure.strengthtraining.traditional")
                            .font(.system(size: 56, weight: .semibold))
                            .foregroundStyle(.green)
                    }
                    .padding(.top, 8)

                    // Title & Subtitle
                    VStack(spacing: 6) {
                        Text("MyFitness")
                            .font(.system(.largeTitle, design: .rounded)).bold()
                            .foregroundStyle(.primary)
                        Text("Track your workouts, meals, and progress")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }

                    // Simulator warning
                    if isSimulator {
                        HStack(spacing: 8) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundStyle(.orange)
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Running on Simulator")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                Text("Sign in with Apple may not work. Try Google Sign In or test on a real device.")
                                    .font(.caption2)
                            }
                        }
                        .padding(12)
                        .background(Color.orange.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    
                    // Error message
                    if let error = errorMessage {
                        Text(error)
                            .font(.footnote)
                            .foregroundStyle(.red)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    // Buttons
                    VStack(spacing: 12) {
                        GoogleSignInButton(scheme: .dark, style: .wide, action: signInWithGoogle)
                            .frame(height: 50)
                            .clipShape(Capsule())
                            .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)

                        SignInWithAppleButton(.signIn, onRequest: configureAppleSignInRequest, onCompletion: handleAppleSignIn)
                            .signInWithAppleButtonStyle(.black)
                            .frame(height: 50)
                            .clipShape(Capsule())
                            .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
                    }
                    .padding(.top, 8)

                    // Terms / hint
                    Text("By continuing, you agree to our Terms and Privacy Policy.")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.top, 6)
                }
                .padding(24)
                .background(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .fill(.thinMaterial)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .strokeBorder(Color.white.opacity(0.2))
                )
                .padding(.horizontal)

                Spacer(minLength: 24)
            }

            // Loading overlay
            if isLoading {
                Color.black.opacity(0.2)
                    .ignoresSafeArea()
                ProgressView()
                    .progressViewStyle(.circular)
                    .tint(.green)
                    .scaleEffect(1.2)
            }
        }
    }
    
    // MARK: - Google Sign In
    private func signInWithGoogle() {
        isLoading = true
        errorMessage = nil
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            errorMessage = "Cannot find root view controller"
            isLoading = false
            return
        }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [self] result, error in
            defer { isLoading = false }
            
            if let error {
                errorMessage = error.localizedDescription
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                errorMessage = "Failed to get user token"
                return
            }
            
            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: user.accessToken.tokenString
            )
            
            Auth.auth().signIn(with: credential) { _, error in
                if let error {
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    // MARK: - Apple Sign In
    private func configureAppleSignInRequest(_ request: ASAuthorizationAppleIDRequest) {
        request.requestedScopes = [.fullName, .email]
        let nonce = randomNonceString()
        currentNonce = nonce
        request.nonce = sha256(nonce)
    }
    
    private func handleAppleSignIn(result: Result<ASAuthorization, Error>) {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        switch result {
        case .failure(let error):
            let nsError = error as NSError
            print("❌ Apple Sign In Error: \(error.localizedDescription)")
            print("Error Domain: \(nsError.domain), Code: \(nsError.code)")
            
            // Error code 1000 = user canceled or auth failed
            // Error code 1001 = unknown error
            if nsError.code == 1000 {
                if isSimulator {
                    errorMessage = "Sign in with Apple doesn't work reliably on simulator. Please use Google Sign In or test on a real device."
                } else {
                    errorMessage = "Sign in was canceled. Please try again."
                }
            } else if nsError.code == 1001 {
                if isSimulator {
                    errorMessage = "Simulator authentication error. Try Google Sign In instead, or test on a real device."
                } else {
                    errorMessage = "Unknown error occurred. Please try again or use Google Sign In."
                }
            } else {
                errorMessage = "Error: \(error.localizedDescription)"
            }
            
        case .success(let authorization):
            print("✅ Apple authorization successful")
            
            guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {
                print("❌ Failed to get AppleID credential")
                errorMessage = "Invalid AppleID credential"
                return
            }
            
            print("Apple User ID: \(appleIDCredential.user)")

            guard let nonce = currentNonce else {
                print("❌ Missing nonce")
                errorMessage = "Missing login request nonce"
                return
            }

            guard let appleIDToken = appleIDCredential.identityToken,
                  let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("❌ Failed to get identity token")
                errorMessage = "Unable to fetch identity token"
                return
            }
            
            print("✅ Got identity token, signing in to Firebase...")

            let credential = OAuthProvider.appleCredential(
                withIDToken: idTokenString,
                rawNonce: nonce,
                fullName: appleIDCredential.fullName
            )

            Auth.auth().signIn(with: credential) { authResult, error in
                if let error {
                    print("❌ Firebase sign in error: \(error.localizedDescription)")
                    errorMessage = error.localizedDescription
                } else {
                    print("✅ Successfully signed in to Firebase")
                    print("User: \(authResult?.user.uid ?? "unknown")")
                }
            }
        }
    }

    // MARK: - Nonce Helpers
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length

        while remainingLength > 0 {
            var random: UInt8 = 0
            let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
            if errorCode != errSecSuccess {
                fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
            }

            if random < charset.count {
                result.append(charset[Int(random)])
                remainingLength -= 1
            }
        }

        return result
    }

    private func sha256(_ input: String) -> String {
        guard let inputData = input.data(using: .utf8) else { return input }
        let hashed = SHA256.hash(data: inputData)
        return hashed.compactMap { String(format: "%02x", $0) }.joined()
    }
}

#Preview {
    LoginView()
}

