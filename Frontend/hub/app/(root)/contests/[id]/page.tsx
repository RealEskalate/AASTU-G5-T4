"use client"

import { useParams } from "next/navigation"
import { useGetContestByIdQuery } from "@/lib/redux/api/contestApiSlice"
import { Tabs, TabsList, TabsTrigger, TabsContent } from "@/components/ui/tabs"
import { StandingsTab } from "@/components/contests/standings-tab"
import { UpsolvingTab } from "@/components/contests/upsolving-tab"
import { Skeleton } from "@/components/ui/skeleton"
import { useState } from "react"

export default function ContestDetailPage() {
  const params = useParams() // Use useParams to unwrap params
  const contestId = params?.id // Safely access the id
  const [activeTab, setActiveTab] = useState("standings")
  const { data, isLoading } = useGetContestByIdQuery(contestId)

  return (
    <div>
      {isLoading ? (
        <Skeleton className="h-10 w-1/2 mb-6" />
      ) : (
        <h1 className="text-2xl font-bold mb-6">{data?.data?.result?.contest?.name || `Contest #${contestId}`}</h1>
      )}

      <Tabs defaultValue="standings" value={activeTab} onValueChange={setActiveTab} className="w-full">
        <TabsList className="mb-6">
          <TabsTrigger value="standings">Standings</TabsTrigger>
          <TabsTrigger value="upsolving">Upsolving</TabsTrigger>
        </TabsList>

        <TabsContent value="standings" className="w-full">
          <StandingsTab contestId={contestId} />
        </TabsContent>

        <TabsContent value="upsolving" className="w-full">
          <UpsolvingTab contestId={contestId} />
        </TabsContent>
      </Tabs>
    </div>
  )
}
