import type React from "react"
import type { Metadata } from "next"
import Link from "next/link"
import { ChevronRightIcon } from "lucide-react"

export const metadata: Metadata = {
  title: "Contest Details | A2SV Hub",
  description: "View contest details and standings",
}

export default function ContestDetailLayout({
  children,
  params,
}: {
  children: React.ReactNode
  params: { id: string }
}) {
  return (
    <div className="p-6">
      <div className="flex items-center gap-2 text-sm text-slate-500 dark:text-slate-400 mb-4">
        <Link href="/contests" className="hover:text-blue-600 dark:hover:text-blue-400">
          Contests
        </Link>
        <ChevronRightIcon className="h-4 w-4" />
        <span className="text-slate-900 dark:text-white">Contest #{params.id}</span>
      </div>
      {children}
    </div>
  )
}
