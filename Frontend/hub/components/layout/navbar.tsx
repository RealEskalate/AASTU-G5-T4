"use client"

import Link from "next/link"
import { Bell, ChevronLeft, Search } from "lucide-react"
import { Button } from "@/components/ui/button"
import { MobileSidebar } from "@/components/layout/mobile-sidebar"

interface NavbarProps {
  hasBackButton?: boolean
  userImage?: string
  notificationCount?: number
}

export function Navbar({ hasBackButton = false, userImage, notificationCount = 0 }: NavbarProps) {
  return (
    <header className="h-14 border-b bg-white flex items-center px-4">
      <div className="flex items-center gap-4 w-full">
        {/* Mobile sidebar toggle */}
        <MobileSidebar />

        {/* Logo or back button */}
        <div className="flex items-center gap-2">
          {hasBackButton ? (
            <Button variant="ghost" size="icon" className="h-8 w-8">
              <ChevronLeft className="h-5 w-5" />
            </Button>
          ) : (
            <Link href="/dashboard" className="text-green-500 font-bold text-xl">
              HUB
            </Link>
          )}
        </div>

        {/* Search */}
        <div className="hidden md:flex relative ml-4 flex-1 max-w-md">
          <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 h-4 w-4 text-slate-400" />
          <input
            type="text"
            placeholder="Search..."
            className="w-full h-9 pl-9 pr-4 rounded-md border border-slate-200 focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent"
          />
        </div>

        {/* Right side items */}
        <div className="ml-auto flex items-center gap-4">
          {/* Notifications */}
          <Button variant="ghost" size="icon" className="relative h-9 w-9">
            <Bell className="h-5 w-5" />
            {notificationCount > 0 && (
              <span className="absolute top-0 right-0 h-4 w-4 bg-red-500 text-white text-xs rounded-full flex items-center justify-center">
                {notificationCount > 9 ? "9+" : notificationCount}
              </span>
            )}
          </Button>

          {/* User profile */}
          <Link href="/profile" className="h-9 w-9 rounded-full bg-slate-200 overflow-hidden">
            {userImage ? (
              <img src={userImage || "/placeholder.svg"} alt="User" className="h-full w-full object-cover" />
            ) : (
              <div className="h-full w-full flex items-center justify-center bg-green-500 text-white">U</div>
            )}
          </Link>
        </div>
      </div>
    </header>
  )
}
