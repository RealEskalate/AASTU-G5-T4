"use client"

import Link from "next/link"
import { ArrowUpRight } from "lucide-react"
import { useGetProblemsQuery } from "@/lib/redux/api/apiSlice"
import { DifficultyBadge } from "@/components/difficulty-badge"

export function LatestProblemsSection() {
  const { data: problems, isLoading, error } = useGetProblemsQuery()

  // Get the latest 10 problems, sorted by creation date
  const latestProblems = problems
    ? [...problems].sort((a, b) => new Date(b.CreatedAt).getTime() - new Date(a.CreatedAt).getTime()).slice(0, 10)
    : []

  if (isLoading) {
    return (
      <div className="mb-8">
        <h2 className="text-lg font-semibold mb-4 dark:text-white">Latest Problems</h2>
        <div className="bg-white dark:bg-slate-800 rounded-lg shadow-sm p-4">
          <div className="animate-pulse space-y-4">
            {[...Array(5)].map((_, i) => (
              <div key={i} className="flex items-center space-x-4">
                <div className="h-6 w-16 bg-slate-200 dark:bg-slate-700 rounded"></div>
                <div className="h-6 flex-1 bg-slate-200 dark:bg-slate-700 rounded"></div>
                <div className="h-6 w-20 bg-slate-200 dark:bg-slate-700 rounded"></div>
                <div className="h-6 w-12 bg-slate-200 dark:bg-slate-700 rounded"></div>
                <div className="h-6 w-8 bg-slate-200 dark:bg-slate-700 rounded"></div>
                <div className="h-6 w-6 bg-slate-200 dark:bg-slate-700 rounded"></div>
              </div>
            ))}
          </div>
        </div>
      </div>
    )
  }

  if (error) {
    return (
      <div className="mb-8">
        <h2 className="text-lg font-semibold mb-4 dark:text-white">Latest Problems</h2>
        <div className="bg-white dark:bg-slate-800 rounded-lg shadow-sm p-4 text-red-500">
          Error loading problems. Please try again later.
        </div>
      </div>
    )
  }

  return (
    <div className="mb-8">
      <h2 className="text-lg font-semibold mb-4 dark:text-white">Latest Problems</h2>
      <div className="bg-white dark:bg-slate-800 rounded-lg shadow-sm overflow-hidden">
        <table className="w-full">
          <thead>
            <tr className="border-b dark:border-slate-700">
              <th className="py-3 px-4 text-left font-medium text-sm text-slate-600 dark:text-slate-300">Diff.</th>
              <th className="py-3 px-4 text-left font-medium text-sm text-slate-600 dark:text-slate-300">Name</th>
              <th className="py-3 px-4 text-right font-medium text-sm text-slate-600 dark:text-slate-300">Tag</th>
              <th className="py-3 px-4 text-right font-medium text-sm text-slate-600 dark:text-slate-300">Platform</th>
              <th className="py-3 px-4 text-right font-medium text-sm text-slate-600 dark:text-slate-300">Link</th>
            </tr>
          </thead>
          <tbody>
            {latestProblems.map((problem) => (
              <tr key={problem.ID} className="border-b dark:border-slate-700">
                <td className="py-3 px-4">
                  <DifficultyBadge level={problem.Difficulty.toLowerCase() as any} size="sm" />
                </td>
                <td className="py-3 px-4 dark:text-slate-300">{problem.Name}</td>
                <td className="py-3 px-4 text-right dark:text-slate-300">{problem.Tag}</td>
                <td className="py-3 px-4 text-right dark:text-slate-300">{problem.Platform}</td>
                <td className="py-3 px-4 text-right">
                  <Link href={problem.Link} target="_blank" className="text-blue-500 hover:text-blue-700">
                    <ArrowUpRight className="h-4 w-4 inline" />
                  </Link>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  )
}
