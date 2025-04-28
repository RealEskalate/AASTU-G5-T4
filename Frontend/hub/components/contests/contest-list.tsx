"use client"

import { useGetContestsQuery } from "@/lib/redux/api/contestApiSlice"
import Link from "next/link"

export const ContestList = () => {
  const { data: contests, isLoading, error } = useGetContestsQuery()
  console.log(contests)

  if (isLoading) {
    return <div>Loading contests...</div>
  }

  if (error) {
    return <div>Error loading contests. Please try again later.</div>
  }

  // Ensure contests is an array
  const contestList = Array.isArray(contests?.data) ? contests.data : []

  return (
    <div>
      {contestList.length > 0 ? (
        contestList.map((contestWrapper: any) => {
          const contest = contestWrapper.result.contest
          return (
            <Link
              key={contest.id}
              href={`/contests/${contest.id}`}
              className="block p-4 border-b hover:bg-gray-100 dark:hover:bg-gray-800"
            >
              <h3 className="font-bold">{contest.name}</h3>
              <p>{contest.type || "No type specified."}</p>
            </Link>
          )
        })
      ) : (
        <div>No contests available.</div>
      )}
    </div>
  )
}
