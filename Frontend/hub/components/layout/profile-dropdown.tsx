"use client"

import { useState, useEffect, useRef } from "react"
import Link from "next/link"
import Image from "next/image"
import { LogOut, Home, User, Settings, RefreshCw } from "lucide-react"
import { getThemeColor } from "@/lib/utils"

interface ProfileDropdownProps {
  userEmail?: string
  userImage?: string
  userName?: string
  userRole?: string
}

export function ProfileDropdown({
  userEmail = "natnael.worku@a2sv.org",
  userImage = "/images/profile-pic.png",
  userName = "Natnael Worku Kelkile",
  userRole = "Student",
}: ProfileDropdownProps) {
  const [isOpen, setIsOpen] = useState(false)
  const [themeColor, setThemeColor] = useState("#10b981")
  const dropdownRef = useRef<HTMLDivElement>(null)

  useEffect(() => {
    setThemeColor(getThemeColor())

    const handleClickOutside = (event: MouseEvent) => {
      if (dropdownRef.current && !dropdownRef.current.contains(event.target as Node)) {
        setIsOpen(false)
      }
    }

    document.addEventListener("mousedown", handleClickOutside)
    return () => {
      document.removeEventListener("mousedown", handleClickOutside)
    }
  }, [])

  return (
    <div className="relative" ref={dropdownRef}>
      <button onClick={() => setIsOpen(!isOpen)} className="flex items-center focus:outline-none">
        <div className="h-8 w-8 rounded-full overflow-hidden border-2 border-gray-200">
          <Image
            src={userImage || "/placeholder.svg"}
            alt="Profile"
            width={32}
            height={32}
            className="h-full w-full object-cover"
          />
        </div>
      </button>

      {isOpen && (
        <div className="absolute right-0 mt-2 w-64 bg-white rounded-md shadow-lg overflow-hidden z-50 border border-gray-100">
          <div className="p-4 border-b border-gray-100">
            <div className="flex items-center">
              <div className="h-10 w-10 rounded-full overflow-hidden mr-3">
                <Image
                  src={userImage || "/placeholder.svg"}
                  alt="Profile"
                  width={40}
                  height={40}
                  className="h-full w-full object-cover"
                />
              </div>
              <div>
                <p className="text-sm font-medium text-gray-800">{userName}</p>
                <p className="text-xs text-gray-500">{userEmail}</p>
              </div>
            </div>
          </div>

          <div className="py-2">
            <Link href="/dashboard" className="flex items-center px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
              <Home className="h-4 w-4 mr-3 text-gray-500" />
              Home
            </Link>
            <Link href="/profile" className="flex items-center px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
              <User className="h-4 w-4 mr-3 text-gray-500" />
              Profile
            </Link>
            <Link href="/settings" className="flex items-center px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
              <Settings className="h-4 w-4 mr-3 text-gray-500" />
              Settings
            </Link>
            <Link href="/sync" className="flex items-center px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
              <RefreshCw className="h-4 w-4 mr-3 text-gray-500" />
              Sync leetcode
            </Link>
          </div>

          <div className="py-2 border-t border-gray-100">
            <button
              className="flex w-full items-center px-4 py-2 text-sm text-red-600 hover:bg-gray-100"
              onClick={() => console.log("Logout clicked")}
            >
              <LogOut className="h-4 w-4 mr-3" />
              Logout
            </button>
          </div>
        </div>
      )}
    </div>
  )
}
