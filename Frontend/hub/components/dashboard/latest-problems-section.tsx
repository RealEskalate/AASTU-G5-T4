"use client"

import Link from "next/link"
import { ArrowUpRight } from "lucide-react"
import { useGetProblemsQuery } from "@/lib/redux/api/problemApiSlice"
import { DifficultyBadge } from "@/components/difficulty-badge"

export function LatestProblemsSection() {
  const { data: problems, isLoading, error } = useGetProblemsQuery()

  console.log("LatestProblemsSection - raw problems data:", problems)

  // Ensure problems is an array
  const validProblems = Array.isArray(problems) ? problems : []
  if (!Array.isArray(problems)) {
    console.warn("LatestProblemsSection - problems data is not an array:", problems)
  }

  // Get the latest 10 problems, sorted by creation date
  const latestProblems =
    validProblems.length > 0
      ? [...validProblems]
          .filter((problem) => problem && problem.ID) // Make sure we have valid problems
          .sort((a, b) => {
            // Safely handle date comparison
            const dateA = a.CreatedAt ? new Date(a.CreatedAt).getTime() : 0
            const dateB = b.CreatedAt ? new Date(b.CreatedAt).getTime() : 0
            return dateB - dateA
          })
          .slice(0, 10)
      : []

  console.log("LatestProblemsSection - processed problems:", latestProblems)

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
    console.error("Error fetching problems:", error)
    return (
      <div className="mb-8">
        <h2 className="text-lg font-semibold mb-4 dark:text-white">Latest Problems</h2>
        <div className="bg-white dark:bg-slate-800 rounded-lg shadow-sm p-4 text-red-500">
          Error loading problems. Please try again later.
          <pre className="mt-2 text-xs overflow-auto max-h-40">{JSON.stringify(error, null, 2)}</pre>
        </div>
      </div>
    )
  }

  if (!latestProblems || latestProblems.length === 0) {
    return (
      <div className="mb-8">
        <h2 className="text-lg font-semibold mb-4 dark:text-white">Latest Problems</h2>
        <div className="bg-white dark:bg-slate-800 rounded-lg shadow-sm p-4 text-slate-500 dark:text-slate-400">
          No problems available at the moment.
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
                  <DifficultyBadge level={(problem.Difficulty || "medium").toLowerCase() as any} size="sm" />
                </td>
                <td className="py-3 px-4 dark:text-slate-300">{problem.Name}</td>
                <td className="py-3 px-4 text-right dark:text-slate-300">{problem.Tag}</td>
                <td className="py-3 px-4 text-right dark:text-slate-300">{problem.Platform}</td>
                <td className="py-3 px-4 text-right">
                  {problem.Link ? (
                    <Link href={problem.Link} target="_blank" className="text-blue-500 hover:text-blue-700">
                      <ArrowUpRight className="h-4 w-4 inline" />
                    </Link>
                  ) : (
                    <span className="text-slate-400">No link</span>
                  )}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  )
}
