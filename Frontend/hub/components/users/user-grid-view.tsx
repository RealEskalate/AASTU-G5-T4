"use client"

import Link from "next/link"
import Image from "next/image"
import { Button } from "@/components/ui/button"
import { useTheme } from "@/components/theme/theme-provider"
import type { User } from "@/lib/redux/api/types"
import { useEffect, useState } from "react"

// Helper function to get gradient class
const getGradientClass = (preset: string) => {
  switch (preset) {
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

interface UserGridViewProps {
  users: User[]
  isLoading?: boolean
}

export function UserGridView({ users, isLoading = false }: UserGridViewProps) {
  const { colorPreset } = useTheme()
  const [gradientClass, setGradientClass] = useState("")

  useEffect(() => {
    setGradientClass(getGradientClass(colorPreset))
  }, [colorPreset])

  if (isLoading) {
    return (
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 w-full">
        {[...Array(6)].map((_, i) => (
          <div key={i} className="bg-white dark:bg-slate-800 rounded-lg overflow-hidden shadow-sm w-full animate-pulse">
            <div className="h-48 bg-slate-200 dark:bg-slate-700"></div>
            <div className="p-4 pt-0 relative">
              <div className="flex justify-center -mt-10">
                <div className="h-20 w-20 rounded-full bg-slate-300 dark:bg-slate-600 border-4 border-white dark:border-slate-800"></div>
              </div>
              <div className="text-center mt-2">
                <div className="h-6 w-32 bg-slate-200 dark:bg-slate-700 mx-auto mb-1 rounded"></div>
                <div className="h-4 w-24 bg-slate-200 dark:bg-slate-700 mx-auto rounded"></div>
              </div>
              <div className="flex justify-center gap-2 mt-3">
                <div className="h-6 w-6 rounded-full bg-slate-200 dark:bg-slate-700"></div>
                <div className="h-6 w-6 rounded-full bg-slate-200 dark:bg-slate-700"></div>
                <div className="h-6 w-6 rounded-full bg-slate-200 dark:bg-slate-700"></div>
              </div>
              <div className="grid grid-cols-3 gap-2 mt-4 text-center">
                <div>
                  <div className="h-4 w-16 bg-slate-200 dark:bg-slate-700 mx-auto mb-1 rounded"></div>
                  <div className="h-5 w-8 bg-slate-200 dark:bg-slate-700 mx-auto rounded"></div>
                </div>
                <div>
                  <div className="h-4 w-16 bg-slate-200 dark:bg-slate-700 mx-auto mb-1 rounded"></div>
                  <div className="h-5 w-8 bg-slate-200 dark:bg-slate-700 mx-auto rounded"></div>
                </div>
                <div>
                  <div className="h-4 w-16 bg-slate-200 dark:bg-slate-700 mx-auto mb-1 rounded"></div>
                  <div className="h-5 w-8 bg-slate-200 dark:bg-slate-700 mx-auto rounded"></div>
                </div>
              </div>
              <div className="mt-4">
                <div className="h-9 bg-slate-200 dark:bg-slate-700 rounded"></div>
              </div>
            </div>
          </div>
        ))}
      </div>
    )
  }

  if (!users || users.length === 0) {
    return (
      <div className="bg-white dark:bg-slate-800 rounded-lg p-8 text-center">
        <p className="text-slate-500 dark:text-slate-400">No users found.</p>
      </div>
    )
  }

  return (
    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 w-full">
      {users.map((user) => (
        <div key={user.id} className="bg-white dark:bg-slate-800 rounded-lg overflow-hidden shadow-sm w-full">
          <div
            className={`h-48 bg-gradient-to-r ${gradientClass} relative`}
            style={{
              backgroundImage: `linear-gradient(to right, var(--tw-gradient-stops)), url(${user.AvatarURL || "/images/profile-pic.png"})`,
              backgroundSize: "cover",
              backgroundBlendMode: "overlay",
            }}
          >
            {/* Background gradient with user image */}
          </div>
          <div className="p-4 pt-0 relative">
            <div className="flex justify-center -mt-10">
              <div className="h-20 w-20 rounded-full border-4 border-white dark:border-slate-800 overflow-hidden bg-white">
                <Image
                  src={user.AvatarURL || "/images/profile-pic.png"}
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
              <p className="text-sm text-slate-500 dark:text-slate-400">
                {user.role || "Student"} • {user.university || "University"}
              </p>
            </div>
            <div className="flex justify-center gap-2 mt-3">
              <div className={`h-6 w-6 rounded-full bg-${colorPreset}-500 flex items-center justify-center text-white text-xs`}>
                {user.preferred_language?.charAt(0) || "?"}
              </div>
              <div className={`h-6 w-6 rounded-full bg-${colorPreset}-500 flex items-center justify-center text-white text-xs`}>
                {user.country_id || "?"}
              </div>
              <div className={`h-6 w-6 rounded-full bg-${colorPreset}-500 flex items-center justify-center text-white text-xs`}>
                {user.group_id || "?"}
              </div>
            </div>
            <div className="grid grid-cols-3 gap-2 mt-4 text-center">
              <div>
                <p className="text-sm text-slate-500 dark:text-slate-400">Language</p>
                <p className="font-medium dark:text-white">{user.preferred_language || "N/A"}</p>
              </div>
              <div>
                <p className="text-sm text-slate-500 dark:text-slate-400">Group</p>
                <p className="font-medium dark:text-white">{user.group_id || "N/A"}</p>
              </div>
              <div>
                <p className="text-sm text-slate-500 dark:text-slate-400">Role</p>
                <p className="font-medium dark:text-white">{user.role_id || "N/A"}</p>
              </div>
            </div>
            <div className="mt-4">
              <Link href={`/profile/${user.id}`}>
                <Button
                  variant="ghost"
                  className="w-full border dark:border-slate-700 text-theme hover:text-theme-dark"
                >
                  View Profile
                </Button>
              </Link>
            </div>
          </div>
        </div>
      ))}
    </div>
  )
}
