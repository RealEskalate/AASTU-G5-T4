"use client"

import type React from "react"

import { useState } from "react"
import Link from "next/link"
import Image from "next/image"
import { usePathname } from "next/navigation"
import { ChevronLeft, ChevronRight } from "lucide-react"
import { Home, BookOpen, FileText, Award, Map, MessageSquare, Calendar, User, Layers } from "lucide-react"
import { cn } from "@/lib/utils"
import { Button } from "@/components/ui/button"

interface NavItemProps {
  href: string
  icon: React.ElementType
  label?: string
  isActive?: boolean
  hasSubmenu?: boolean
  badge?: number | string
  collapsed: boolean
}

const NavItem = ({ href, icon: Icon, label, isActive, hasSubmenu, badge, collapsed }: NavItemProps) => {
  return (
    <Link
      href={href}
      className={cn(
        "flex items-center gap-3 py-2 text-sm rounded-md transition-colors",
        collapsed ? "justify-center px-0" : "px-3",
        isActive
          ? "bg-theme/10 text-theme font-medium dark:bg-theme/20"
          : "hover:bg-slate-100 text-slate-700 dark:text-slate-200 dark:hover:bg-slate-800/60",
      )}
    >
      <Icon className={cn("h-5 w-5", isActive ? "text-theme" : "text-slate-500 dark:text-slate-400")} />
      {!collapsed && (
        <>
          <span>{label}</span>
          {badge && (
            <span className="ml-auto bg-slate-200 dark:bg-slate-700 text-xs px-2 py-0.5 rounded-full">{badge}</span>
          )}
          {hasSubmenu && <span className="ml-auto">›</span>}
        </>
      )}
    </Link>
  )
}

export function CollapsibleSidebar() {
  const [collapsed, setCollapsed] = useState(false)
  const pathname = usePathname()

  // Skip rendering sidebar on auth pages
  if (pathname.includes("/auth/")) {
    return null
  }

  return (
    <aside
      className={cn(
        "h-screen border-r dark:border-slate-800 bg-white dark:bg-slate-900 flex flex-col sidebar fixed left-0 top-0 z-40 transition-all duration-300",
        collapsed ? "w-[60px]" : "w-[220px]",
      )}
    >
      {/* Toggle button */}
      <Button
        variant="ghost"
        size="icon"
        className="absolute -right-3 top-20 h-6 w-6 rounded-full border bg-white dark:bg-slate-800 dark:border-slate-700 shadow-sm z-50"
        onClick={() => setCollapsed(!collapsed)}
      >
        {collapsed ? (
          <ChevronRight className="h-3 w-3 text-slate-500" />
        ) : (
          <ChevronLeft className="h-3 w-3 text-slate-500" />
        )}
      </Button>

      {/* Logo section */}
      <div className={cn("p-4 border-b dark:border-slate-800", collapsed ? "flex justify-center" : "")}>
        <Link href="/dashboard" className="flex items-center">
          <Image src="/images/a2sv-hub-logo.png" alt="A2SV Hub" width={80} height={30} className="h-8 w-auto" />
        </Link>
      </div>

      {/* User profile section */}
      <div
        className={cn(
          "p-4 border-b dark:border-slate-800",
          collapsed ? "flex justify-center" : "flex items-center gap-3",
        )}
      >
        <div className="h-10 w-10 rounded-full bg-slate-200 dark:bg-slate-700 overflow-hidden flex-shrink-0">
          <Image
            src="/images/profile-pic.png"
            alt="User"
            width={40}
            height={40}
            className="h-full w-full object-cover"
          />
        </div>
        {!collapsed && (
          <div>
            <p className="font-medium text-sm dark:text-white">Natnael Worku Kelk...</p>
            <p className="text-xs text-slate-500 dark:text-slate-400">Student</p>
          </div>
        )}
      </div>

      {/* Navigation sections */}
      <div className="flex-1 overflow-auto py-4 px-2 space-y-6">
        {/* Student section */}
        <div>
          {!collapsed && (
            <h3 className="px-3 text-xs font-semibold text-slate-500 dark:text-slate-400 uppercase mb-2">STUDENT</h3>
          )}
          <nav className="space-y-1">
            <NavItem
              href="/dashboard"
              icon={Home}
              label="Home"
              isActive={pathname === "/dashboard"}
              collapsed={collapsed}
            />
            <NavItem
              href="/tracks"
              icon={BookOpen}
              label="Tracks"
              isActive={pathname.includes("/tracks")}
              hasSubmenu
              badge="59"
              collapsed={collapsed}
            />
            <NavItem
              href="/problems"
              icon={FileText}
              label="Problems"
              isActive={pathname.includes("/problems")}
              collapsed={collapsed}
            />
            <NavItem
              href="/contests"
              icon={Award}
              label="Contests"
              isActive={pathname.includes("/contests")}
              hasSubmenu
              collapsed={collapsed}
            />
            <NavItem
              href="/roadmap"
              icon={Map}
              label="Roadmap"
              isActive={pathname.includes("/roadmap")}
              collapsed={collapsed}
            />
            <NavItem
              href="/users"
              icon={User}
              label="Users"
              isActive={pathname.includes("/users")}
              collapsed={collapsed}
            />
            <NavItem
              href="/groups"
              icon={Layers}
              label="Groups"
              isActive={pathname.includes("/groups")}
              collapsed={collapsed}
            />
            <NavItem
              href="/forum"
              icon={MessageSquare}
              label="Forum"
              isActive={pathname.includes("/forum")}
              collapsed={collapsed}
            />
            <NavItem
              href="/sessions"
              icon={Calendar}
              label="Sessions"
              isActive={pathname.includes("/sessions")}
              collapsed={collapsed}
            />
          </nav>
        </div>
      </div>

      {/* Footer */}
      {!collapsed && (
        <div className="p-4 border-t dark:border-slate-800">
          <div className="text-sm text-slate-500 dark:text-slate-400">Hi, Natnael</div>
        </div>
      )}
    </aside>
  )
}
