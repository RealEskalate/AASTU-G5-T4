import { DataTable } from "@/components/data-table"
import { ConsistencyCalendar } from "@/components/consistency-calendar"
import { AttendanceGrid } from "@/components/attendance-grid"
import { ProfileLinks } from "@/components/profile-links"

export function ProfileContent({
  activeTab,
  userData,
  problems,
  isLoadingProblems,
  submissions,
  isLoadingSubmissions,
  generateMockAttendanceData,
  problemsColumns,
  submissionsColumns,
}: {
  activeTab: string
  userData: any
  problems: any
  isLoadingProblems: boolean
  submissions: any
  isLoadingSubmissions: boolean
  generateMockAttendanceData: () => any
  problemsColumns: any
  submissionsColumns: any
}) {
  const attendanceData = generateMockAttendanceData() // Generate attendance data once

  if (activeTab === "profile") {
    return (
      <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
        {/* Left column */}
        <div className="md:col-span-2 space-y-8">
          {/* Consistency section */}
          <ConsistencyCalendar year={2025} />

          {/* Attendance section */}
          <AttendanceGrid data={attendanceData} stats={{ absent: 0, excused: 1, present: 294, percentage: 99 }} />
        </div>

        {/* Right column */}
        <div className="space-y-8">
          {/* About section */}
          <ProfileLinks links={userData.links || []} /> {/* Ensure links is always an array */}
        </div>
      </div>
    )
  }

  if (activeTab === "problems") {
    return isLoadingProblems ? (
      <div className="text-center text-slate-500 dark:text-slate-400">Loading problems...</div>
    ) : problems && problems.length > 0 ? (
      <DataTable columns={problemsColumns} data={problems} />
    ) : (
      <div className="text-center text-slate-500 dark:text-slate-400">No problems available.</div>
    )
  }

  if (activeTab === "submissions") {
    return isLoadingSubmissions ? (
      <div className="text-center text-slate-500 dark:text-slate-400">Loading submissions...</div>
    ) : submissions && submissions.length > 0 ? (
      <DataTable columns={submissionsColumns} data={submissions} />
    ) : (
      <div className="text-center text-slate-500 dark:text-slate-400">No submissions available.</div>
    )
  }

  return null
}
