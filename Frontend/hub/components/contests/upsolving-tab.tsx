"use client"

import { useGetContestByIdQuery } from "@/lib/redux/api/contestApiSlice"
import { Skeleton } from "@/components/ui/skeleton"

interface UpsolvingTabProps {
  contestId: string
}

export function UpsolvingTab({ contestId }: UpsolvingTabProps) {
  const { data, isLoading, error } = useGetContestByIdQuery(contestId)

  if (isLoading) {
    return (
      <div className="space-y-4">
        <Skeleton className="h-8 w-full" />
        <Skeleton className="h-64 w-full" />
      </div>
    )
  }

  if (error) {
    return <div className="p-4 text-red-500">Failed to load contest problems. Please try again later.</div>
  }

  if (!data?.data?.result) {
    return <div className="p-4 text-slate-500 dark:text-slate-400">No problems data available.</div>
  }

  const { contest, rows, problems } = data.data.result

  // Generate random submission times for visualization
  const generateRandomSubmission = () => {
    const solved = Math.random() > 0.3
    if (!solved) return null

    const attempts = Math.floor(Math.random() * 3) + 1
    const minutes = Math.floor(Math.random() * 100) + 1

    return `${attempts} | ${minutes}m`
  }

  return (
    <div className="overflow-x-auto">
      <table className="w-full">
        <thead>
          <tr>
            <th className="py-2 px-4 text-left font-medium text-sm text-slate-600 dark:text-slate-300 w-24"></th>
            {problems.map((problem) => (
              <th
                key={problem.index}
                className="py-2 px-4 text-center font-medium text-sm text-slate-600 dark:text-slate-300"
              >
                <div className="bg-purple-600 text-white p-2 rounded-md mb-2">
                  {problem.index} - {problem.name}
                </div>
              </th>
            ))}
          </tr>
        </thead>
        <tbody>
          {rows.map((row, index) => (
            <tr key={index} className="border-b dark:border-slate-700">
              <td className="py-3 px-4 dark:text-slate-300">
                <div className="flex items-center">
                  <span className="font-medium mr-2">{index + 1}</span>
                  <div className="h-8 w-8 rounded-full bg-slate-200 dark:bg-slate-700 mr-2"></div>
                  <span>{row.party.members[0]?.handle || "Unknown"}</span>
                </div>
              </td>
              {problems.map((problem, pIndex) => {
                const submission = generateRandomSubmission()
                return (
                  <td key={`${index}-${pIndex}`} className="py-3 px-4 text-center">
                    {submission ? (
                      <div className="bg-green-600 text-white p-2 rounded-md">{submission}</div>
                    ) : (
                      <div className="h-10"></div>
                    )}
                  </td>
                )
              })}
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  )
}
