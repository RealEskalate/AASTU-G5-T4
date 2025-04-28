"use client"

import { useState } from "react" // Add this import
import { AttendanceGrid } from "@/components/attendance-grid"
import { ConsistencyCalendar } from "@/components/consistency-calendar"
import { ProfileHeader } from "@/components/profile/ProfileHeader"
import { ProfileTabs } from "@/components/profile/ProfileTabs"
import { ProfileContent } from "@/components/profile/ProfileContent"

export const ProfilePageLayout = ({ userData, isLoadingUser, generateMockAttendanceData }: any) => {
  const [activeTab, setActiveTab] = useState("profile")

  if (isLoadingUser) {
    return <div className="text-center text-slate-500 dark:text-slate-400">Loading user data...</div>
  }

  if (!userData) {
    return <div className="text-center text-red-500">Failed to load user data.</div>
  }

  return (
    <div className="p-4 md:p-6 max-w-7xl mx-auto">
      <ProfileHeader userData={userData} />
      <ProfileTabs activeTab={activeTab} setActiveTab={setActiveTab} />
      <ProfileContent
        activeTab={activeTab}
        userData={userData}
        generateMockAttendanceData={generateMockAttendanceData}
      />
    </div>
  )
}
