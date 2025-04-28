"use client"

import { useGetContestByIdQuery } from "@/lib/redux/api/contestApiSlice"
import { Skeleton } from "@/components/ui/skeleton"
import { ArrowUpIcon } from "lucide-react"

interface StandingsTabProps {
  contestId: string
}

export function StandingsTab({ contestId }: StandingsTabProps) {
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
    return <div className="p-4 text-red-500">Failed to load contest standings. Please try again later.</div>
  }

  if (!data?.data?.result) {
    return <div className="p-4 text-slate-500 dark:text-slate-400">No standings data available.</div>
  }

  const { rows } = data.data.result

  // Generate random gain values for visualization
  const gains = [173, 21, 180, 63, 105, 90, 45, 32, 78, 54]

  return (
    <div className="overflow-x-auto">
      <table className="w-full">
        <thead>
          <tr className="border-b dark:border-slate-700">
            <th className="py-3 px-4 text-left font-medium text-sm text-slate-600 dark:text-slate-300">Rank</th>
            <th className="py-3 px-4 text-left font-medium text-sm text-slate-600 dark:text-slate-300">Contestant</th>
            <th className="py-3 px-4 text-center font-medium text-sm text-slate-600 dark:text-slate-300">Solved</th>
            <th className="py-3 px-4 text-center font-medium text-sm text-slate-600 dark:text-slate-300">Penalty</th>
            <th className="py-3 px-4 text-right font-medium text-sm text-slate-600 dark:text-slate-300">Gain</th>
          </tr>
        </thead>
        <tbody>
          {rows.map((row, index) => {
            // Calculate solved problems count
            const solved = row.problemResults.filter((pr) => pr.points > 0).length

            return (
              <tr key={index} className="border-b dark:border-slate-700">
                <td className="py-3 px-4">
                  <div className="flex items-center">
                    <span className="font-medium">{row.rank}</span>
                    <span className="ml-2 text-green-500 flex items-center text-xs">
                      <ArrowUpIcon className="h-3 w-3 mr-1" />
                      {index < 10 ? index + 1 : 1}
                    </span>
                  </div>
                </td>
                <td className="py-3 px-4">
                  <div className="flex items-center">
                    <div className="h-8 w-8 rounded-full bg-slate-200 dark:bg-slate-700 mr-3"></div>
                    <span>{row.party.members[0]?.handle || "Unknown"}</span>
                  </div>
                </td>
                <td className="py-3 px-4 text-center">{solved}</td>
                <td className="py-3 px-4 text-center">{row.penalty}</td>
                <td className="py-3 px-4 text-right text-green-500">+{gains[index % gains.length]}</td>
              </tr>
            )
          })}
        </tbody>
      </table>
    </div>
  )
}
