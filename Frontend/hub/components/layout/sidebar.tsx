"use client"

import type React from "react"

import Link from "next/link"
import Image from "next/image"
import { usePathname } from "next/navigation"
import {
  Home,
  BookOpen,
  FileText,
  Award,
  Map,
  MessageSquare,
  Calendar,
  Clock,
  PlusSquare,
  Trophy,
  BarChart2,
  User,
  Layers,
} from "lucide-react"

import { cn } from "@/lib/utils"
import { useTheme } from "@/components/theme/theme-provider"

interface NavItemProps {
  href: string
  icon: React.ElementType
  label: string
  isActive?: boolean
  hasSubmenu?: boolean
  badge?: number | string
}

const NavItem = ({ href, icon: Icon, label, isActive, hasSubmenu, badge }: NavItemProps) => {
  const { theme, colorPreset } = useTheme()

  return (
    <Link
      href={href}
      className={cn(
        "flex items-center gap-3 px-3 py-2 text-sm rounded-md transition-colors",
        isActive
          ? "bg-theme/10 text-theme font-medium dark:bg-theme/20"
          : "hover:bg-slate-100 text-slate-700 dark:text-slate-200 dark:hover:bg-slate-800/60",
      )}
    >
      <Icon className={cn("h-5 w-5", isActive ? "text-theme" : "text-slate-500 dark:text-slate-400")} />
      <span>{label}</span>
      {badge && (
        <span className="ml-auto bg-slate-200 dark:bg-slate-700 text-xs px-2 py-0.5 rounded-full">{badge}</span>
      )}
      {hasSubmenu && <span className="ml-auto">›</span>}
    </Link>
  )
}

interface SidebarProps {
  userRole?: "student" | "head" | "admin"
  userName?: string
  userTitle?: string
  userImage?: string
}

export function Sidebar({ userRole = "student", userName = "User", userTitle = "", userImage }: SidebarProps) {
  const pathname = usePathname()
  const { direction } = useTheme()

  // Skip rendering sidebar on auth pages
  if (pathname.includes("/auth/")) {
    return null
  }

  return (
    <aside
      className={`w-[220px] h-screen border-r dark:border-slate-800 bg-white dark:bg-slate-900 flex flex-col sidebar fixed left-0 top-0 ${
        direction === "rtl" ? "border-r-0 border-l" : ""
      }`}
    >
      {/* Logo section */}
      <div className="p-4 border-b dark:border-slate-800">
        <Link href="/dashboard" className="flex items-center">
          <Image src="/images/a2sv-hub-logo.png" alt="A2SV Hub" width={80} height={30} className="h-8 w-auto" />
        </Link>
      </div>

      {/* User profile section */}
      <div className="p-4 border-b dark:border-slate-800 flex items-center gap-3">
        <div className="h-10 w-10 rounded-full bg-slate-200 dark:bg-slate-700 overflow-hidden">
          {userImage ? (
            <img src={userImage || "/placeholder.svg"} alt={userName} className="h-full w-full object-cover" />
          ) : (
            <Image
              src="/images/profile-pic.png"
              alt={userName}
              width={40}
              height={40}
              className="h-full w-full object-cover"
            />
          )}
        </div>
        <div>
          <p className="font-medium text-sm dark:text-white">{userName}</p>
          <p className="text-xs text-slate-500 dark:text-slate-400">{userTitle}</p>
        </div>
      </div>

      {/* Navigation sections */}
      <div className="flex-1 overflow-auto py-4 px-2 space-y-6">
        {/* Student section */}
        <div>
          <h3 className="px-3 text-xs font-semibold text-slate-500 dark:text-slate-400 uppercase mb-2">STUDENT</h3>
          <nav className="space-y-1">
            <NavItem href="/dashboard" icon={Home} label="Home" isActive={pathname === "/dashboard"} />
            <NavItem
              href="/tracks"
              icon={BookOpen}
              label="Tracks"
              isActive={pathname.includes("/tracks")}
              hasSubmenu
              badge="59"
            />
            <NavItem href="/problems" icon={FileText} label="Problems" isActive={pathname.includes("/problems")} />
            <NavItem
              href="/contests"
              icon={Award}
              label="Contests"
              isActive={pathname.includes("/contests")}
              hasSubmenu
            />
            <NavItem href="/roadmap" icon={Map} label="Roadmap" isActive={pathname.includes("/roadmap")} />
            <NavItem href="/users" icon={User} label="Users" isActive={pathname.includes("/users")} />
            <NavItem href="/groups" icon={Layers} label="Groups" isActive={pathname.includes("/groups")} />
            <NavItem href="/forum" icon={MessageSquare} label="Forum" isActive={pathname.includes("/forum")} />
            <NavItem href="/sessions" icon={Calendar} label="Sessions" isActive={pathname.includes("/sessions")} />
          </nav>
        </div>

        {/* Head section - only visible for head role */}
        {(userRole === "head" || userRole === "admin") && (
          <div>
            <h3 className="px-3 text-xs font-semibold text-slate-500 dark:text-slate-400 uppercase mb-2">HEAD</h3>
            <nav className="space-y-1">
              <NavItem
                href="/attendance"
                icon={Clock}
                label="Take Attendance"
                isActive={pathname.includes("/attendance")}
              />
              <NavItem
                href="/add-problem"
                icon={PlusSquare}
                label="Add Problem"
                isActive={pathname.includes("/add-problem")}
              />
              <NavItem
                href="/add-contest"
                icon={Trophy}
                label="Add Contest"
                isActive={pathname.includes("/add-contest")}
              />
              <NavItem
                href="/add-track"
                icon={BarChart2}
                label="Add Track"
                isActive={pathname.includes("/add-track")}
              />
              <NavItem href="/add-event" icon={Calendar} label="Add Event" isActive={pathname.includes("/add-event")} />
            </nav>
          </div>
        )}

        {/* Head of Academy section - only visible for head role */}
        {userRole === "head" && (
          <div>
            <h3 className="px-3 text-xs font-semibold text-slate-500 dark:text-slate-400 uppercase mb-2">
              HEAD OF ACADEMY
            </h3>
            <nav className="space-y-1">
              <NavItem
                href="/generate-invite"
                icon={User}
                label="Generate Invite"
                isActive={pathname.includes("/generate-invite")}
              />
            </nav>
          </div>
        )}
      </div>

      {/* Footer */}
      <div className="p-4 border-t dark:border-slate-800">
        <div className="text-sm text-slate-500 dark:text-slate-400">Hi, {userName.split(" ")[0]}</div>
      </div>
    </aside>
  )
}
