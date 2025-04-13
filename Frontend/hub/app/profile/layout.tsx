import type React from "react"
import type { Metadata } from "next"

export const metadata: Metadata = {
  title: "Profile | A2SV Hub",
  description: "User profile on A2SV Learning Hub Platform",
}

export default function ProfileLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return children
}
