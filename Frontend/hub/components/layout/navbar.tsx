"use client"

import Link from "next/link"
import Image from "next/image"
import { Bell, Search, Star } from "lucide-react"
import { Button } from "@/components/ui/button"
import { useState, useRef, useEffect } from "react"
import { MobileSidebar } from "@/components/layout/mobile-sidebar"

interface NavbarProps {
  notificationCount?: number
}

export function Navbar({ notificationCount = 0 }: NavbarProps) {
  const [isSearchOpen, setIsSearchOpen] = useState(false)
  const searchRef = useRef<HTMLDivElement | null>(null)

  // Handle clicks outside of the search bar
  useEffect(() => {
    function handleClickOutside(event: MouseEvent) {
      if (searchRef.current && !searchRef.current.contains(event.target as Node)) {
        setIsSearchOpen(false)
      }
    }

    if (isSearchOpen) {
      document.addEventListener("mousedown", handleClickOutside)
    }

    return () => {
      document.removeEventListener("mousedown", handleClickOutside)
    }
  }, [isSearchOpen])

  return (
    <header className="h-14 border-b bg-white dark:bg-slate-900 dark:border-slate-800 flex items-center px-4 sticky top-0 z-30">
      <div className="flex items-center gap-4 w-full">
        {/* Mobile Sidebar Toggle */}
        <MobileSidebar />

        {/* Search Overlay with Smooth Transition */}
        {isSearchOpen && (
          <div
            ref={searchRef}
            className="absolute top-0 left-0 w-full h-14 bg-white dark:bg-slate-900 p-3 px-10 z-50 flex items-center justify-between shadow-md transition-all duration-300"
          >
            <Search className="h-4 w-4 text-slate-400" />
            <input
              type="text"
              className="w-full px-4 py-2 bg-transparent text-slate-900 dark:text-white placeholder-slate-500 focus:outline-none"
              placeholder="Search..."
            />
            <Button onClick={() => setIsSearchOpen(false)} className="ml-3 bg-green-500 hover:bg-green-600 text-white">
              Search
            </Button>
          </div>
        )}

        {/* Search button */}
        <div className="flex-1 max-w-md">
          <Button
            variant="ghost"
            onClick={() => setIsSearchOpen(true)}
            className="flex items-center gap-2 text-slate-500 hover:text-slate-700 dark:text-slate-400 dark:hover:text-slate-300"
          >
            <Search className="h-4 w-4" />
            <span className="hidden md:inline">Search...</span>
          </Button>
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
