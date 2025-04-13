"use client"

import { useState } from "react"
import { Switch } from "@/components/ui/switch"

interface AttendanceDay {
  date: string
  time: string
  status: "present" | "absent" | "excused"
}

interface AttendanceGridProps {
  data: AttendanceDay[]
  stats: {
    absent: number
    excused: number
    present: number
    percentage: number
  }
}

export function AttendanceGrid({
  data = [],
  stats = { absent: 0, excused: 1, present: 294, percentage: 99 },
}: AttendanceGridProps) {
  const [showDetail, setShowDetail] = useState(false)

  const getStatusColor = (status: string) => {
    switch (status) {
      case "present":
        return "bg-green-500"
      case "absent":
        return "bg-red-500"
      case "excused":
        return "bg-yellow-500"
      default:
        return "bg-gray-200"
    }
  }

  return (
    <div className="bg-white rounded-lg shadow-sm p-4 dark:bg-slate-800 dark:border dark:border-slate-700">
      <div className="flex justify-between items-center mb-4">
        <h2 className="text-lg font-semibold dark:text-white">Attendance</h2>
        <div className="flex items-center gap-2">
          <span className="text-sm text-slate-500 dark:text-slate-400">Show detail</span>
          <Switch checked={showDetail} onCheckedChange={setShowDetail} />
        </div>
      </div>

      {showDetail ? (
        <div className="grid grid-cols-5 gap-1 sm:grid-cols-7 md:grid-cols-10 lg:grid-cols-12">
          {data.map((day, index) => (
            <div key={index} className={`${getStatusColor(day.status)} rounded-sm p-1 text-xs text-white`}>
              <div className="text-center font-medium">
                {day.date.split(" ")[0]}
                <sup>{day.date.split(" ")[1]}</sup>
              </div>
              <div className="text-center">{day.time}</div>
            </div>
          ))}
        </div>
      ) : (
        <div className="flex flex-wrap gap-0.5">
          {Array.from({ length: stats.present + stats.absent + stats.excused }).map((_, i) => {
            let status = "present"
            if (i < stats.absent) status = "absent"
            else if (i < stats.absent + stats.excused) status = "excused"

            return <div key={i} className={`h-3 w-3 ${getStatusColor(status)} rounded-sm`} />
          })}
        </div>
      )}

      <div className="mt-4 flex flex-wrap items-center text-xs text-slate-500 dark:text-slate-400 gap-4">
        <div className="flex items-center gap-1">
          <span>Absent: {stats.absent}</span>
        </div>
        <div className="flex items-center gap-1">
          <span>Excused: {stats.excused}</span>
        </div>
        <div className="flex items-center gap-1">
          <span>Present: {stats.present}</span>
        </div>
        <div className="flex items-center gap-1">
          <span>{stats.percentage}%</span>
        </div>
      </div>
    </div>
  )
}
