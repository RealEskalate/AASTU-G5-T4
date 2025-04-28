"use client"

import { useGetProblemsQuery } from "@/lib/redux/api/problemApiSlice"

export function DebugApi() {
  const { data: problems, isLoading, error, refetch } = useGetProblemsQuery()

  return (
    <div className="p-4 bg-gray-100 dark:bg-gray-800 rounded-lg mb-8">
      <h2 className="text-lg font-bold mb-2">API Debug</h2>

      <div className="mb-4">
        <button onClick={() => refetch()} className="px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600">
          Refetch Problems
        </button>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        <div>
          <h3 className="font-semibold mb-2">Status</h3>
          <div className="bg-white dark:bg-gray-700 p-3 rounded">
            <p>Loading: {isLoading ? "Yes" : "No"}</p>
            <p>Error: {error ? "Yes" : "No"}</p>
            <p>Data: {problems ? `${problems.length} problems` : "No data"}</p>
          </div>
        </div>

        {error && (
          <div>
            <h3 className="font-semibold mb-2">Error Details</h3>
            <div className="bg-white dark:bg-gray-700 p-3 rounded overflow-auto max-h-40">
              <pre className="text-xs text-red-500">{JSON.stringify(error, null, 2)}</pre>
            </div>
          </div>
        )}

        {problems && problems.length > 0 && (
          <div className="col-span-1 md:col-span-2">
            <h3 className="font-semibold mb-2">First Problem</h3>
            <div className="bg-white dark:bg-gray-700 p-3 rounded overflow-auto max-h-60">
              <pre className="text-xs">{JSON.stringify(problems[0], null, 2)}</pre>
            </div>
          </div>
        )}
      </div>
    </div>
  )
}
