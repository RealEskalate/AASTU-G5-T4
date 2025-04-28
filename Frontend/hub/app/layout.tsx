import type React from "react"
import type { Metadata } from "next"
import { Inter } from "next/font/google"
import "./globals.css"
import { ThemeProvider } from "@/components/theme/theme-provider"
import { SettingsPanel } from "@/components/theme/settings-panel"
import { SettingsToggle } from "@/components/theme/settings-toggle"
import { ReduxProvider } from "@/lib/redux/provider"

const inter = Inter({ subsets: ["latin"] })

export const metadata: Metadata = {
  title: "A2SV Hub",
  description: "A2SV Learning Hub Platform",
}

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en">
      <body>
        <ReduxProvider>
          <ThemeProvider>
            <div className={inter.className}>
              {children}
              <SettingsPanel />
              <SettingsToggle />
            </div>
          </ThemeProvider>
        </ReduxProvider>
      </body>
    </html>
  )
}
