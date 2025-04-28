"use client"

import { useEffect, useState } from "react"
import { useGetProblemsQuery } from "@/lib/redux/api/problemApiSlice"
import { DataTable } from "@/components/data-table"

export function LatestSubmissionsSection() {
  const { data: problems, isLoading: isLoadingProblems, error: problemsError } = useGetProblemsQuery()
  const [submissions, setSubmissions] = useState([])

  // Fetch submissions for multiple problem IDs
  useEffect(() => {
    if (!problems || problems.length === 0) {
      setSubmissions([])
      return
    }

    const fetchSubmissions = async () => {
      const allSubmissions = []
      for (const problem of problems) {
        try {
          const response = await fetch(
            `https://a2sv-hub-52ak.onrender.com/api/v0/submission/problem?problemID=${problem.ID}`
          )
          const data = await response.json()
          if (data?.submissions && Array.isArray(data.submissions)) {
            // Map submissions to include only required fields
            const mappedSubmissions = data.submissions.map((submission) => ({
              problemName: problem.Name,
              userName: submission.User?.Name || "Unknown User",
              timeSpent: submission.TimeSpent || "N/A",
              language: submission.Language || "N/A",
            }))
            allSubmissions.push(...mappedSubmissions)
          }
        } catch (error) {
          console.warn(`Skipping problem ID ${problem.ID} due to error or no submissions.`)
        }
      }

      // Sort submissions by time spent and limit to the latest 5
      const sortedSubmissions = allSubmissions.slice(0, 5)
      setSubmissions(sortedSubmissions)
    }

    fetchSubmissions()
  }, [problems])

  // Define columns for the submissions table
  const submissionsColumns = [
    {
      key: "problemName",
      title: "Problem Name",
    },
    {
      key: "userName",
      title: "User Name",
    },
    {
      key: "timeSpent",
      title: "Time Spent (mins)",
      align: "right" as const,
    },
    {
      key: "language",
      title: "Language",
      align: "right" as const,
    },
  ]

  if (isLoadingProblems) {
    return (
      <div className="mb-8">
        <h2 className="text-lg font-semibold mb-4 dark:text-white">Latest Submissions</h2>
        <div className="bg-white dark:bg-slate-800 rounded-lg shadow-sm p-4">
          <div className="animate-pulse space-y-4">
            {[...Array(5)].map((_, i) => (
              <div key={i} className="h-6 bg-slate-200 dark:bg-slate-700 rounded"></div>
            ))}
          </div>
        </div>
      </div>
    )
  }

  if (problemsError) {
    console.error("Error fetching problems:", problemsError)
    return (
      <div className="mb-8">
        <h2 className="text-lg font-semibold mb-4 dark:text-white">Latest Submissions</h2>
        <div className="bg-white dark:bg-slate-800 rounded-lg shadow-sm p-4 text-red-500">
          Error loading problems. Please try again later.
        </div>
      </div>
    )
  }

  if (!problems || problems.length === 0) {
    return (
      <div className="mb-8">
        <h2 className="text-lg font-semibold mb-4 dark:text-white">Latest Submissions</h2>
        <div className="bg-white dark:bg-slate-800 rounded-lg shadow-sm p-4 text-slate-500 dark:text-slate-400">
          No problems available at the moment.
        </div>
      </div>
    )
  }

  if (submissions.length === 0) {
    return (
      <div className="mb-8">
        <h2 className="text-lg font-semibold mb-4 dark:text-white">Latest Submissions</h2>
        <div className="bg-white dark:bg-slate-800 rounded-lg shadow-sm p-4 text-slate-500 dark:text-slate-400">
          No submissions available at the moment.
        </div>
      </div>
    )
  }

  return (
    <div className="mb-8">
      <h2 className="text-lg font-semibold mb-4 dark:text-white">Latest Submissions</h2>
      <div className="bg-white dark:bg-slate-800 rounded-lg shadow-sm overflow-hidden">
        <DataTable columns={submissionsColumns} data={submissions} />
      </div>
    </div>
  )
}
