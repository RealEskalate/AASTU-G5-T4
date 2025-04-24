"use client"

import Link from "next/link"
import Image from "next/image"
import { Button } from "@/components/ui/button"
import { useTheme } from "@/components/theme/theme-provider"

interface User {
  id: string
  name: string
  group: string
  problems: number
  submissions: number
  dedicatedTime: string
  rating?: number
  image: string
}

interface UserGridViewProps {
  users: User[]
}

export function UserGridView({ users }: UserGridViewProps) {
  const { colorPreset } = useTheme()

  const getGradientClass = () => {
    switch (colorPreset) {
      case "purple":
        return "from-purple-500 to-purple-700"
      case "blue":
        return "from-blue-500 to-blue-700"
      case "orange":
        return "from-orange-500 to-orange-700"
      case "red":
        return "from-red-500 to-red-700"
      case "indigo":
        return "from-indigo-500 to-indigo-700"
      default:
        return "from-green-500 to-green-700"
    }
  }

  return (
    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
      {users.map((user) => (
        <div key={user.id} className="bg-white dark:bg-slate-800 rounded-lg overflow-hidden shadow-sm">
          <div className={`h-48 bg-gradient-to-r ${getGradientClass()} relative`}>{/* Background gradient */}</div>
          <div className="p-4 pt-0 relative">
            <div className="flex justify-center -mt-10">
              <div className="h-20 w-20 rounded-full border-4 border-white dark:border-slate-800 overflow-hidden bg-white">
                <Image
                  src={user.image || "/images/profile-pic.png"}
                  alt={user.name}
                  width={80}
                  height={80}
                  className="h-full w-full object-cover"
                />
              </div>
            </div>
            <div className="text-center mt-2">
              <Link href={`/profile/${user.id}`} className="font-medium text-lg dark:text-white hover:text-theme">
                {user.name}
              </Link>
              <p className="text-sm text-slate-500 dark:text-slate-400">Student • {user.group}</p>
            </div>
            <div className="flex justify-center gap-2 mt-3">
              <div className="h-6 w-6 rounded-full bg-yellow-500 flex items-center justify-center text-white text-xs">
                C
              </div>
              <div className="h-6 w-6 rounded-full bg-blue-500 flex items-center justify-center text-white text-xs">
                S
              </div>
              <div className="h-6 w-6 rounded-full bg-green-500 flex items-center justify-center text-white text-xs">
                P
              </div>
              <div className="h-6 w-6 rounded-full bg-purple-500 flex items-center justify-center text-white text-xs">
                T
              </div>
            </div>
            <div className="grid grid-cols-3 gap-2 mt-4 text-center">
              <div>
                <p className="text-sm text-slate-500 dark:text-slate-400">Problems</p>
                <p className="font-medium dark:text-white">{user.problems}</p>
              </div>
              <div>
                <p className="text-sm text-slate-500 dark:text-slate-400">Submissions</p>
                <p className="font-medium dark:text-white">{user.submissions}</p>
              </div>
              <div>
                <p className="text-sm text-slate-500 dark:text-slate-400">Dedicated Time</p>
                <p className="font-medium dark:text-white">{user.dedicatedTime}</p>
              </div>
            </div>
            <div className="mt-4">
              <Button variant="ghost" className="w-full border dark:border-slate-700 text-theme hover:text-theme-dark">
                View Profile
              </Button>
            </div>
          </div>
        </div>
      ))}
    </div>
  )
}
