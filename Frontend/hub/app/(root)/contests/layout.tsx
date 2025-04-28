import type React from "react"
import type { Metadata } from "next"

export const metadata: Metadata = {
  title: "Contests | A2SV Hub",
  description: "View and participate in A2SV coding contests",
}

export default function ContestsLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <div className="p-6">
      <h1 className="text-2xl font-bold mb-6">Contests</h1>
      {children}
    </div>
  )
}
