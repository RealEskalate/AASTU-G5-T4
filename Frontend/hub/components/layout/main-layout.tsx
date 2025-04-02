"use client"

import type React from "react"
import Link from "next/link"
import Image from "next/image"
import { usePathname } from "next/navigation"
import {
  Home,
  GitBranch,
  Code,
  Award,
  Map,
  Users,
  MessageSquare,
  Calendar,
  ClipboardCheck,
  PlusSquare,
  Trophy,
  FilePlus,
  CalendarPlus,
  UserPlus,
  ChevronLeft,
  Search,
  Bell,
} from "lucide-react"

export default function MainLayout({ children }: { children: React.ReactNode }) {
  const pathname = usePathname()

  const isActive = (path: string) => {
    return pathname === path
  }

  return (
    <div className="flex min-h-screen bg-gray-50">
      {/* Left Sidebar */}
      <div className="w-[220px] border-r bg-white flex flex-col">
        <div className="p-4 flex items-center">
          <Link href="/" className="flex items-center">
            <div className="bg-blue-600 text-white p-1 rounded">
              <span className="font-bold text-xl">H</span>
            </div>
            <span className="text-blue-600 font-bold text-xl ml-1">UB</span>
          </Link>
          <ChevronLeft className="ml-auto text-gray-400" size={20} />
        </div>

        <div className="p-4 bg-gray-50 rounded-lg mx-3 mb-4">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 rounded-full bg-gray-300 overflow-hidden">
              <Image
                src="/placeholder.svg?height=40&width=40"
                alt="Profile"
                width={40}
                height={40}
                className="object-cover"
              />
            </div>
            <div>
              <h3 className="font-medium text-sm">Kenenisa Alemayehu</h3>
              <p className="text-xs text-gray-500">Head of Academy</p>
            </div>
          </div>
        </div>

        <div className="px-3 mb-4">
          <div className="text-xs font-semibold text-gray-500 mb-2 px-3">STUDENT</div>
          <nav className="space-y-1">
            <Link
              href="/"
              className={`flex items-center gap-3 px-3 py-2 text-sm rounded-lg ${
                isActive("/") ? "bg-blue-50 text-blue-600" : "text-gray-600 hover:bg-gray-100"
              }`}
            >
              <Home size={18} />
              <span>Home</span>
            </Link>
            <Link
              href="/tracks"
              className={`flex items-center gap-3 px-3 py-2 text-sm rounded-lg ${
                isActive("/tracks") ? "bg-blue-50 text-blue-600" : "text-gray-600 hover:bg-gray-100"
              }`}
            >
              <GitBranch size={18} />
              <span>Tracks</span>
            </Link>
            <Link
              href="/problems"
              className={`flex items-center gap-3 px-3 py-2 text-sm rounded-lg ${
                isActive("/problems") ? "bg-blue-50 text-blue-600" : "text-gray-600 hover:bg-gray-100"
              }`}
            >
              <Code size={18} />
              <span>Problems</span>
            </Link>
            <Link
              href="/contests"
              className={`flex items-center gap-3 px-3 py-2 text-sm rounded-lg ${
                isActive("/contests") ? "bg-blue-50 text-blue-600" : "text-gray-600 hover:bg-gray-100"
              }`}
            >
              <Award size={18} />
              <span>Contests</span>
            </Link>
            <Link
              href="/roadmap"
              className={`flex items-center gap-3 px-3 py-2 text-sm rounded-lg ${
                isActive("/roadmap") ? "bg-blue-50 text-blue-600" : "text-gray-600 hover:bg-gray-100"
              }`}
            >
              <Map size={18} />
              <span>Roadmap</span>
            </Link>
            <Link
              href="/groups"
              className={`flex items-center gap-3 px-3 py-2 text-sm rounded-lg ${
                isActive("/groups") ? "bg-blue-50 text-blue-600" : "text-gray-600 hover:bg-gray-100"
              }`}
            >
              <Users size={18} />
              <span>Groups & Users</span>
            </Link>
            <Link
              href="/forum"
              className={`flex items-center gap-3 px-3 py-2 text-sm rounded-lg ${
                isActive("/forum") ? "bg-blue-50 text-blue-600" : "text-gray-600 hover:bg-gray-100"
              }`}
            >
              <MessageSquare size={18} />
              <span>Forum</span>
            </Link>
            <Link
              href="/events"
              className={`flex items-center gap-3 px-3 py-2 text-sm rounded-lg ${
                isActive("/events") ? "bg-blue-50 text-blue-600" : "text-gray-600 hover:bg-gray-100"
              }`}
            >
              <Calendar size={18} />
              <span>Events</span>
            </Link>
          </nav>
        </div>

        <div className="px-3 mb-4">
          <div className="text-xs font-semibold text-gray-500 mb-2 px-3">HEAD</div>
          <nav className="space-y-1">
            <Link
              href="/attendance"
              className={`flex items-center gap-3 px-3 py-2 text-sm rounded-lg ${
                isActive("/attendance") ? "bg-blue-50 text-blue-600" : "text-gray-600 hover:bg-gray-100"
              }`}
            >
              <ClipboardCheck size={18} />
              <span>Take Attendance</span>
            </Link>
            <Link
              href="/add-problem"
              className={`flex items-center gap-3 px-3 py-2 text-sm rounded-lg ${
                isActive("/add-problem") ? "bg-blue-50 text-blue-600" : "text-gray-600 hover:bg-gray-100"
              }`}
            >
              <PlusSquare size={18} />
              <span>Add Problem</span>
            </Link>
            <Link
              href="/add-contest"
              className={`flex items-center gap-3 px-3 py-2 text-sm rounded-lg ${
                isActive("/add-contest") ? "bg-blue-50 text-blue-600" : "text-gray-600 hover:bg-gray-100"
              }`}
            >
              <Trophy size={18} />
              <span>Add Contest</span>
            </Link>
            <Link
              href="/add-track"
              className={`flex items-center gap-3 px-3 py-2 text-sm rounded-lg ${
                isActive("/add-track") ? "bg-blue-50 text-blue-600" : "text-gray-600 hover:bg-gray-100"
              }`}
            >
              <FilePlus size={18} />
              <span>Add Track</span>
            </Link>
            <Link
              href="/add-event"
              className={`flex items-center gap-3 px-3 py-2 text-sm rounded-lg ${
                isActive("/add-event") ? "bg-blue-50 text-blue-600" : "text-gray-600 hover:bg-gray-100"
              }`}
            >
              <CalendarPlus size={18} />
              <span>Add Event</span>
            </Link>
          </nav>
        </div>

        <div className="px-3 mb-4">
          <div className="text-xs font-semibold text-gray-500 mb-2 px-3">HEAD OF ACADEMY</div>
          <nav className="space-y-1">
            <Link
              href="/generate-invite"
              className={`flex items-center gap-3 px-3 py-2 text-sm rounded-lg ${
                isActive("/generate-invite") ? "bg-blue-50 text-blue-600" : "text-gray-600 hover:bg-gray-100"
              }`}
            >
              <UserPlus size={18} />
              <span>Generate Invite</span>
            </Link>
          </nav>
        </div>
      </div>

      {/* Main Content */}
      <div className="flex-1 flex flex-col">
        {/* Top Navigation */}
        <div className="h-12 border-b flex items-center px-4 justify-end gap-2 bg-white">
          <div className="flex-1"></div>
          <button className="p-2 text-gray-500 hover:bg-gray-100 rounded-full">
            <Search size={20} />
          </button>
          <div className="relative">
            <button className="p-2 text-gray-500 hover:bg-gray-100 rounded-full">
              <Bell size={20} />
            </button>
            <span className="absolute top-1 right-1 bg-red-500 text-white text-xs w-4 h-4 flex items-center justify-center rounded-full">
              1
            </span>
          </div>
          <div className="w-8 h-8 rounded-full bg-gray-300 overflow-hidden">
            <Image
              src="/placeholder.svg?height=32&width=32"
              alt="Profile"
              width={32}
              height={32}
              className="object-cover"
            />
          </div>
        </div>

        {/* Page Content */}
        <div className="flex-1">{children}</div>
      </div>
    </div>
  )
}

