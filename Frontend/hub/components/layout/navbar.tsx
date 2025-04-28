"use client"

import Link from "next/link"
import Image from "next/image"
import { Bell, Search, Star } from "lucide-react"
import { Button } from "@/components/ui/button"
import { useState, useRef, useEffect } from "react"
import { MobileSidebar } from "@/components/layout/mobile-sidebar"
import { cn } from "@/lib/utils"

interface NavbarProps {
  notificationCount?: number
}

export function Navbar({ notificationCount = 0 }: NavbarProps) {
  const [isSearchOpen, setIsSearchOpen] = useState(false)
  const searchRef = useRef<HTMLDivElement | null>(null)

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
    <header className="h-16 border-b bg-white dark:bg-slate-900 dark:border-slate-800 flex items-center px-6 sticky top-0 z-30">
      <div className="flex items-center gap-6 w-full">
        <MobileSidebar />

        {isSearchOpen && (
          <div
            ref={searchRef}
            className="absolute top-0 left-0 w-full h-16 bg-white dark:bg-slate-900 p-4 px-12 z-50 flex items-center justify-between shadow-md transition-all duration-300 border-b border-slate-200 dark:border-slate-700"
          >
            <Search className="h-5 w-5 text-slate-400" />
            <input
              type="text"
              className="w-full px-4 py-2 bg-transparent text-slate-900 dark:text-white placeholder-slate-500 focus:outline-none border border-slate-300 dark:border-slate-600 rounded-md"
              placeholder="Search..."
            />
            <Button onClick={() => setIsSearchOpen(false)} className="ml-3 bg-green-500 hover:bg-green-600 text-white">
              Search
            </Button>
          </div>
        )}

        <div className="flex-1 max-w-lg">
          <Button
            variant="ghost"
            onClick={() => setIsSearchOpen(true)}
            className="flex items-center gap-2 text-slate-500 hover:text-slate-700 dark:text-slate-400 dark:hover:text-slate-300"
          >
            <Search className="h-5 w-5" />
            <span className="hidden md:inline">Search...</span>
          </Button>
        </div>

        <div className="ml-auto flex items-center gap-6">
          <Button variant="ghost" size="icon" className="h-10 w-10 text-yellow-500">
            <Star className="h-6 w-6" />
          </Button>

          <Button variant="ghost" size="icon" className="relative h-10 w-10">
            <Bell className="h-6 w-6" />
            {notificationCount > 0 && (
              <span
                className={cn(
                  "absolute top-0 right-0 h-5 w-5 bg-red-500 text-white text-xs rounded-full flex items-center justify-center",
                  notificationCount > 0 && "animate-pulse"
                )}
              >
                {notificationCount > 9 ? "9+" : notificationCount}
              </span>
            )}
          </Button>

          <Link href="/profile" className="h-10 w-10 rounded-full bg-slate-200 overflow-hidden hover:ring-2 ring-theme transition-all">
            <Image
              src="/images/profile-pic.png"
              alt="User"
              width={40}
              height={40}
              className="h-full w-full object-cover"
            />
          </Link>
        </div>
      </div>
    </header>
  )
}
