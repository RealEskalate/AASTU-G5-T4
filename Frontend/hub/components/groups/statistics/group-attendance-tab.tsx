"use client"

import { useState } from "react"
import { Button } from "@/components/ui/button"
import { RefreshCw } from "lucide-react"

interface GroupAttendanceTabProps {
  groupId: string
}

export function GroupAttendanceTab({ groupId }: GroupAttendanceTabProps) {
  const [currentPage, setCurrentPage] = useState(1)

  // Mock data for attendance
  const attendanceData = {
    summary: {
      absents: 5,
      excuses: 428,
      present: 6352,
      presentPercentage: "93%",
    },
    students: [
      { id: "1", name: "Natnael", attendance: Array(30).fill("present") },
      { id: "2", name: "Eyerusalem", attendance: Array(28).fill("present").concat(Array(2).fill("excused")) },
      { id: "3", name: "Mahlet", attendance: Array(30).fill("present") },
      { id: "4", name: "Nebiyou", attendance: Array(30).fill("present") },
      { id: "5", name: "Ikram", attendance: Array(30).fill("present") },
    ],
  }

  // Generate dates for the last 30 days
  const dates = Array.from({ length: 30 }, (_, i) => {
    const date = new Date()
    date.setDate(date.getDate() - i)
    return date
  }).reverse()

  return (
    <div>
      <div className="flex justify-between items-center mb-4">
        <div>
          <h3 className="text-lg font-medium dark:text-white">Legacy Attendance Summary</h3>
          <p className="text-sm text-slate-500 dark:text-slate-400">
            Absents: {attendanceData.summary.absents} | Excuses: {attendanceData.summary.excuses} | Present:{" "}
            {attendanceData.summary.present} ({attendanceData.summary.presentPercentage})
          </p>
        </div>
        <div className="flex items-center gap-2">
          <Button variant="outline" size="sm" className="flex items-center gap-1">
            <span>Switch Attendance Mode</span>
          </Button>
          <div className="flex items-center gap-1 text-sm text-slate-500 dark:text-slate-400">
            <span>Showing: 1/11</span>
            <Button variant="ghost" size="icon" className="h-8 w-8">
              <RefreshCw className="h-4 w-4" />
            </Button>
          </div>
        </div>
      </div>

      <div className="bg-white dark:bg-slate-800 rounded-lg overflow-auto">
        <table className="w-full">
          <thead>
            <tr className="border-b dark:border-slate-700">
              <th className="py-2 px-4 text-left font-medium text-sm text-slate-600 dark:text-slate-300 w-12">#</th>
              <th className="py-2 px-4 text-left font-medium text-sm text-slate-600 dark:text-slate-300">Name</th>
              {dates.map((date, i) => (
                <th
                  key={i}
                  className="py-2 px-1 text-center font-medium text-xs text-slate-600 dark:text-slate-300 whitespace-nowrap"
                >
                  {date.getDate()}/{date.getMonth() + 1}
                  <div className="text-[10px]">{i % 2 === 0 ? "07:48" : "05:42"}</div>
                </th>
              ))}
            </tr>
          </thead>
          <tbody>
            {attendanceData.students.map((student, index) => (
              <tr key={student.id} className="border-b dark:border-slate-700">
                <td className="py-2 px-4 text-left text-sm dark:text-slate-300">{index + 1}</td>
                <td className="py-2 px-4 text-left text-sm dark:text-slate-300">{student.name}</td>
                {student.attendance.map((status, i) => (
                  <td key={i} className="py-2 px-1 text-center">
                    <div
                      className={`w-6 h-6 mx-auto rounded-sm ${
                        status === "present" ? "bg-green-500" : status === "excused" ? "bg-yellow-500" : "bg-red-500"
                      }`}
                    ></div>
                  </td>
                ))}
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  )
}
