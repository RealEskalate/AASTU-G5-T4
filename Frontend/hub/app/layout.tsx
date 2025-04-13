import type React from "react"
import type { Metadata } from "next"
import { Inter } from "next/font/google"
import "./globals.css"
import { Sidebar } from "@/components/layout/sidebar"
import { Navbar } from "@/components/layout/navbar"
import { ThemeProvider } from "@/components/theme/theme-provider"
import { SettingsPanel } from "@/components/theme/settings-panel"
import { SettingsToggle } from "@/components/theme/settings-toggle"

const inter = Inter({ subsets: ["latin"] })

export const metadata: Metadata = {
  title: "A2SV Hub",
  description: "A2SV Learning Hub Platform",
}

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode
}>) {
  return (
    <html lang="en">
      <body className={inter.className}>
        <ThemeProvider>
          <div className="flex h-screen">
            <div className="hidden md:block">
              <Sidebar userRole="head" userName="Kenenisa Alemayehu" userTitle="Head of Academy" />
            </div>
            <div className="flex-1 flex flex-col h-screen overflow-hidden">
              <Navbar notificationCount={14} />
              <main className="flex-1 overflow-auto bg-slate-50 dark:bg-slate-900">
                <div className="stretch-container">{children}</div>
              </main>
            </div>
          </div>
          <SettingsToggle />
          <SettingsPanel />
        </ThemeProvider>
      </body>
    </html>
  )
}
