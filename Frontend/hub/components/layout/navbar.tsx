"use client"

import Link from "next/link"
import Image from "next/image"
import { Bell, Search, Star } from "lucide-react"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"

interface NavbarProps {
  notificationCount?: number
}

export function Navbar({ notificationCount = 0 }: NavbarProps) {
  return (
    <header className="h-14 border-b bg-white dark:bg-slate-900 dark:border-slate-800 flex items-center px-4 sticky top-0 z-10">
      <div className="flex items-center gap-4 w-full">
        {/* Search */}
        <div className="flex-1 max-w-md">
          <div className="relative">
            <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 h-4 w-4 text-slate-400" />
            <Input
              type="text"
              placeholder="Search..."
              className="w-full h-9 pl-9 pr-4 rounded-md border border-slate-200 focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent dark:bg-slate-800 dark:border-slate-700 dark:text-white"
            />
          </div>
        </div>

        {/* Right side items */}
        <div className="ml-auto flex items-center gap-4">
          {/* Star button */}
          <Button variant="ghost" size="icon" className="h-9 w-9 text-yellow-500">
            <Star className="h-5 w-5" />
          </Button>

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
            <Image
              src="/images/profile-pic.png"
              alt="User"
              width={36}
              height={36}
              className="h-full w-full object-cover"
            />
          </Link>
        </div>
      </div>
    </header>
  )
}
