//
//  HomeView.swift
//  Pakal
//
//  Created by Antonio Medina on 02/04/25.
//

import SwiftUI
import MapKit

struct HomeView: View {
    @State private var selectedTab = 0
    let topReports: [UrbanIssue] = [
        UrbanIssue(title: "Bache grande en Av. Reforma", category: "Bache", votes: 45, status: .pending),
        UrbanIssue(title: "Poste de luz caído en esquina", category: "Iluminación", votes: 32, status: .inProgress),
        UrbanIssue(title: "Robos en transporte público", category: "Criminalidad", votes: 28, status: .reported)
    ]
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Primera pestaña: Lista de reportes
            reportListTab()
                .tabItem {
                    Label("Reportes", systemImage: "list.bullet")
                }
                .tag(0)
            
            // Segunda pestaña: Mapa
            mapTab()
                .tabItem {
                    Label("Mapa", systemImage: "map")
                }
                .tag(1)
            
            // Tercera pestaña: Perfil (opcional)
            profileTab()
                .tabItem {
                    Label("Perfil", systemImage: "person")
                }
                .tag(2)
        }
        .accentColor(.blue) // Color de los íconos seleccionados
    }
    
    // MARK: - Componentes de las pestañas
    
    private func reportListTab() -> some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    // Encabezado
                    headerSection()
                    
                    // Lista de reportes
                    VStack(spacing: 12) {
                        Text("Problemas reportados")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        
                        ForEach(topReports) { report in
                            VerticalReportCard(report: report)
                                .padding(.horizontal)
                        }
                    }
                }
                .padding(.vertical)
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func mapTab() -> some View {
        NavigationStack {
            ZStack {
                // Mapa por defecto
                Map()
                    .edgesIgnoringSafeArea(.all)
                
                // Botón para centrar en ubicación (opcional)
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {}) {
                            Image(systemName: "location.fill")
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(radius: 3)
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Mapa de Reportes")
        }
    }
    
    private func profileTab() -> some View {
        NavigationStack {
            VStack {
                Text("Perfil del Usuario")
                    .font(.title)
                Spacer()
            }
            .navigationTitle("Mi Perfil")
        }
    }
    
    private func headerSection() -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Mi Ciudad Reporta")
                .font(.title)
                .bold()
                .foregroundColor(.primary)
            
            Text("Últimos reportes en tu área")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
}

// MARK: - Componente de Tarjeta Vertical (igual que antes)

struct VerticalReportCard: View {
    let report: UrbanIssue
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(report.category.uppercased())
                    .font(.system(size: 12, weight: .bold))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(categoryColor().opacity(0.2))
                    .foregroundColor(categoryColor())
                    .cornerRadius(12)
                
                Spacer()
                
                Text(report.status.rawValue.uppercased())
                    .font(.system(size: 11, weight: .semibold))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(statusColor().opacity(0.2))
                    .foregroundColor(statusColor())
                    .cornerRadius(12)
            }
            
            Text(report.title)
                .font(.subheadline)
                .bold()
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
            
            HStack {
                HStack(spacing: 4) {
                    Image(systemName: "hand.thumbsup.fill")
                        .imageScale(.small)
                    
                    Text("\(report.votes) apoyos")
                        .font(.caption)
                }
                .foregroundColor(.secondary)
                
                Spacer()
                
                HStack(spacing: 4) {
                    Image(systemName: "clock")
                        .imageScale(.small)
                    
                    Text("hace 2 días")
                        .font(.caption)
                }
                .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.1), lineWidth: 1)
        )
    }
    
    private func categoryColor() -> Color {
        switch report.category {
        case "Bache": return .orange
        case "Iluminación": return .yellow
        case "Criminalidad": return .red
        default: return .blue
        }
    }
    
    private func statusColor() -> Color {
        switch report.status {
        case .reported: return .blue
        case .pending: return .orange
        case .inProgress: return .green
        case .resolved: return .gray
        }
    }
}

// MARK: - Modelo de Datos (igual que antes)

struct UrbanIssue: Identifiable {
    let id = UUID()
    let title: String
    let category: String
    let votes: Int
    let status: ReportStatus
}

enum ReportStatus: String {
    case reported = "Reportado"
    case pending = "Pendiente"
    case inProgress = "En progreso"
    case resolved = "Resuelto"
}

// MARK: - Vista Previa

#Preview {
    HomeView()
}
