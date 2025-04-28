"use client"

import { useState } from "react"
import Link from "next/link"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { GroupStudentsTab } from "@/components/groups/group-students-tab"
import { GroupStatisticsTab } from "@/components/groups/group-statistics-tab"

// Mock data for group details
const groupDetailsData = {
  id: "g56",
  name: "AASTU Group 56",
  code: "G56",
  members: 23,
  timeSpent: "246,672",
  solvedProblems: "731",
  avgRating: "1,220",
  students: [
    {
      id: "1",
      name: "Abenezer Mulugeta Woldesenbet",
      problems: 391,
      timeSpent: "8,461",
      rating: "1,271",
      lastSeen: "28d 1h 27m",
      image: "/placeholder.svg?height=32&width=32",
    },
    {
      id: "2",
      name: "Samrawit Gebremaryam Bahta",
      problems: 447,
      timeSpent: "13,135",
      rating: "1,380",
      lastSeen: "6d 6h 12m",
      image: "/placeholder.svg?height=32&width=32",
    },
    {
      id: "3",
      name: "Dawit Sema",
      problems: 381,
      timeSpent: "10,255",
      rating: "1,401",
      lastSeen: "80d 5h 50m",
      image: "/placeholder.svg?height=32&width=32",
    },
    {
      id: "4",
      name: "Solome Getachew Abebe",
      problems: 332,
      timeSpent: "8,226",
      rating: "1,124",
      lastSeen: "124d 17h 19m",
      image: "/placeholder.svg?height=32&width=32",
    },
    {
      id: "5",
      name: "Sefina Kamile Abrar",
      problems: 369,
      timeSpent: "10,813",
      rating: "1,013",
      lastSeen: "online",
      image: "/placeholder.svg?height=32&width=32",
    },
  ],
}

export default function GroupDetailPage({ params }: { params: { id: string } }) {
  const [activeTab, setActiveTab] = useState("students")

  return (
    <div className="p-4 md:p-6">
      <div className="mb-4">
        <div className="flex items-center gap-2 text-sm text-slate-500 dark:text-slate-400 mb-1">
          <Link href="/groups" className="hover:text-theme">
            Groups
          </Link>
          <span>•</span>
          <span>{groupDetailsData.code}</span>
        </div>
        <h1 className="text-2xl font-bold dark:text-white">{groupDetailsData.name}</h1>
      </div>

      <Tabs defaultValue="students" className="w-full" onValueChange={setActiveTab}>
        <TabsList className="w-full justify-between mb-6 bg-transparent">
          <div className="flex">
            <TabsTrigger
              value="students"
              className={`${
                activeTab === "students"
                  ? "border-b-2 border-theme text-slate-900 dark:text-white"
                  : "text-slate-500 dark:text-slate-400"
              } rounded-none px-4 py-2 font-medium`}
            >
              Students
            </TabsTrigger>
            <TabsTrigger
              value="statistics"
              className={`${
                activeTab === "statistics"
                  ? "border-b-2 border-theme text-slate-900 dark:text-white"
                  : "text-slate-500 dark:text-slate-400"
              } rounded-none px-4 py-2 font-medium`}
            >
              Statistics
            </TabsTrigger>
          </div>
        </TabsList>

        <TabsContent value="students" className="mt-0">
          <GroupStudentsTab students={groupDetailsData.students} />
        </TabsContent>

        <TabsContent value="statistics" className="mt-0">
          <GroupStatisticsTab groupId={params.id} />
        </TabsContent>
      </Tabs>
    </div>
  )
}
